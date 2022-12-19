import UIKit
import RxSwift
import RxCocoa
import CoreLocation
import MapKit
import SnapKit


enum MatchState: Int {
    case matching
    case matched
    case `default`
}

extension MatchState {
    var setImage: UIImage {
        switch self {
        case .default:
            return SeSacImage.default!
        case .matching:
            return SeSacImage.matching!
        case .matched:
            return SeSacImage.mathed!
        }
    }
}



class MapViewController: BaseViewController, LocationAuthorizationCheckable {
    
    let selfView        = MapView()
    let viewModel       = MapViewModel()
    let disposeBag      = DisposeBag()
    let locationManager = CLLocationManager()
    
    override func loadView() { view = selfView }
}

extension MapViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.mapView.delegate = self
        locationManager.delegate = self
        checkUserDevicelocationServiceAuthorization(locationManager: locationManager)
        selfView.totalButton.toAct
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tabBarController?.tabBar.isHidden = false
        self.checkQueueState { }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension MapViewController {
    func bind() {
        
        viewModel.sesacFriendsList
            .bind(onNext: {
                $0.forEach {
                    self.makeAnnotation($0)
                }
            })
            .disposed(by: disposeBag)
        
        selfView.totalButton.rx.tap
            .bind(onNext: {
                self.requestQueueSearch {
                    self.selfView.mapView.removeAnnotations(self.selfView.mapView.annotations)
                    self.viewModel.sesacFriendsList.value.forEach {
                        self.makeAnnotation($0)
                    }
                }
                self.selfView.makeActByGender(gender: .total)
            })
            .disposed(by: disposeBag)
        
        selfView.manButton.rx.tap
            .bind(onNext: {
                
                self.requestQueueSearch {
                    self.selfView.mapView.removeAnnotations(self.selfView.mapView.annotations)
                    self.viewModel.sesacFriendsList.value.filter { $0.gender == 1 }.forEach {
                        self.makeAnnotation($0)
                    }
                }
                self.selfView.makeActByGender(gender: .man)
            })
            .disposed(by: disposeBag)

        selfView.womanButton.rx.tap
            .bind(onNext: {
                self.requestQueueSearch {
                    self.selfView.mapView.removeAnnotations(self.selfView.mapView.annotations)
                    self.viewModel.sesacFriendsList.value.filter { $0.gender == 0 }.forEach {
                        self.makeAnnotation($0)
                    }
                }
                self.selfView.makeActByGender(gender: .woman)
                
            })
            .disposed(by: disposeBag)
        
        selfView.floattingButton.rx.tap
            .bind(onNext: {
                let state = UserDefaultsManager.standard.matchedState
                switch state {
                case 0:
                    let vc = FindViewController()
                    self.transition(vc)
                case 1:
                    print("채팅 화면으로 가기")
                    let vc = ChatViewController()
                    self.transition(vc)
                default:
                    let vc = WishListViewController()
                    vc.viewModel.lat.accept(self.viewModel.lat.value)
                    vc.viewModel.long.accept(self.viewModel.long.value)
                    self.transition(vc)
                }
            })
            .disposed(by: disposeBag)
        
        selfView.currentLocationButton.rx.tap
            .bind(onNext: {
                self.setRegionAndAnnotation(center: self.viewModel.currentLocation)
            })
            .disposed(by: disposeBag)
    }
}



extension MapViewController {
    func requestQueueSearch(completion: @escaping () -> Void) {
        self.viewModel.requestQueueSearch {
            switch $0 {
            case .success:
                completion()
            case .failure(let error):
                switch error {
                case .idTokenError:
                    self.requestQueueSearch { }
                    return
                default:
                    return
                }
            }
        }
    }
    func checkQueueState(completion: @escaping () -> Void) {
        self.viewModel.checkQueueState {
            switch $0 {
            case .success:
                let state = UserDefaultsManager.standard.matchedState
                switch state {
                case 0:
                    self.selfView.floattingButton.setImage(SeSacImage.matching, for: .normal)
                default:
                    self.selfView.floattingButton.setImage(SeSacImage.mathed, for: .normal)
                }
                return
            case .failure(let error):
                switch error {
                case .defaultState:
                    self.selfView.floattingButton.setImage(SeSacImage.default, for: .normal)
                    return
                case .idTokenError:
                    self.checkQueueState { }
                default:
                    return
                }
            }
        }
    }

}

extension MapViewController {
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 700, longitudinalMeters: 700)
        selfView.mapView.setRegion(region, animated: true)
    }
    
    func makeAnnotation(_ friends: FromQueueDB) {
        let coordinate = CLLocationCoordinate2D(latitude: friends.lat, longitude: friends.long)
        let friendsPin = SeSacAnnotation(coordinate: coordinate, sesac: friends.sesac)
        self.selfView.mapView.addAnnotation(friendsPin)
    }
}


///1) 위치 받아오는함수  2) 디바이스 위치서비스  Auth 확인 --> 항상 초장에호출됨 --> 안에 "위치서비스" 여부 확인하는 코드 심어주기
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("🐷","내 위치 호출!",#function, locations)
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate)
            viewModel.currentLocation = coordinate
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDevicelocationServiceAuthorization(locationManager: locationManager)
    }
}



// MARK: - MKMapviewDelegate
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? SeSacAnnotation else { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: SeSacAnnotationView.className)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: SeSacAnnotationView.className)
            annotationView?.contentMode = .scaleAspectFit
        } else {
            annotationView?.annotation = annotation
        }
        
        let sesacImage = SeSacImage.sesacImageArray[annotation.sesac]

        let sesacSize = CGSize(width: 90, height: 90)
        UIGraphicsBeginImageContext(sesacSize)
        sesacImage!.draw(in: CGRect(x: 0, y: 0, width: sesacSize.width, height: sesacSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        annotationView?.image = resizedImage
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        viewModel.lat.accept(mapView.centerCoordinate.latitude)
        viewModel.long.accept(mapView.centerCoordinate.longitude)
        requestQueueSearch{}
    }
    
}
