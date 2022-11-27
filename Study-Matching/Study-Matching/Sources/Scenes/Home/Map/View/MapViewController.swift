import UIKit
import RxSwift
import RxCocoa
import CoreLocation
import MapKit
import SnapKit

class MapViewController: BaseViewController {
    
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
        selfView.totalButton.toAct //⚠️ 개선
        bind()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}


extension MapViewController {
    func bind() {
        // MARK: - 플로팅 버튼
        selfView.floattingButton.rx.tap
            .bind(onNext: {
                let vc = SearchViewController()
                self.transition(vc)
                self.viewModel.requestQueueSearch {
                    switch $0 {
                    case .success:
                        return
                    case .failure(let error):
                        switch error {
                        case .idTokenError:
                            self.viewModel.requestQueueSearch { _ in }
                        case .unRegistedUser:
                            print("⚠️미가입된 회원입니다")
                        default:
                            return
                        }
                    }
                }
            })
            .disposed(by: disposeBag)
        
        
        viewModel.sesacFriendsArray
            .bind(onNext: {
                $0.forEach {
                    self.makeAnnotation($0)
                }
            })
            .disposed(by: disposeBag)
        
        
        selfView.totalButton.rx.tap
            .bind(onNext: {
                print("fasfasdfsdfsdafasdfsadfadf")
                self.requestQueueSearch {
                    self.selfView.mapView.removeAnnotations(self.selfView.mapView.annotations)
                    self.viewModel.sesacFriendsArray.value.forEach {
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
                    self.viewModel.sesacFriendsArray.value.filter { $0.gender == 1 }.forEach {
                        print("🥰🥰🥰🥰🥰🥰🥰\($0)")
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
                    self.viewModel.sesacFriendsArray.value.filter { $0.gender == 0 }.forEach {
                        print("🐸🐸🐸🐸🐸🐸🐸\($0)")
                        let coordinate = CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.long)
                        let friendsPin = SeSacAnnotation(coordinate: coordinate, sesac: $0.sesac)
                        self.selfView.mapView.addAnnotation(friendsPin)
                    }
                }

                self.selfView.makeActByGender(gender: .woman)
                
            })
            .disposed(by: disposeBag)
        
    }
    
    
    
    
}







// MARK: - LocationCheckable
///1)위치서비스활성화 여부확인 2) 승인상태 분기처리
extension MapViewController: LocationAuthorizationCheckable {}



// MARK: - CLLocationManagerDelegate
///1) 위치 받아오는함수  2) 디바이스 위치서비스  Auth 확인 --> 항상 초장에호출됨 --> 안에 "위치서비스" 여부 확인하는 코드 심어주기
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("🐷","내 위치 호출!",#function, locations)
        
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate)
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("🐶")
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
        print("🔥\(mapView.centerCoordinate.latitude), \(mapView.centerCoordinate.longitude)")
        viewModel.lat.accept(mapView.centerCoordinate.latitude)
        viewModel.long.accept(mapView.centerCoordinate.longitude)
        requestQueueSearch{}
    }
    
}


extension MapViewController {
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 700, longitudinalMeters: 700)
        selfView.mapView.setRegion(region, animated: true)
    }
}


extension MapViewController {
    func requestQueueSearch(completion: @escaping () -> Void) {
        self.viewModel.requestQueueSearch {
            switch $0 {
            case .success:
                print("🙀🙀🙀🙀🙀🙀🙀")
                completion()
            case .failure(let error):
                switch error {
                case .idTokenError:
                    self.requestQueueSearch { }
                    return
                case .unRegistedUser:
                    print("⚠️미가입된 회원입니다")
                default:
                    return
                }
            }
        }
    }
    func makeAnnotation(_ friends: FromQueueDB) {
        let coordinate = CLLocationCoordinate2D(latitude: friends.lat, longitude: friends.long)
        let friendsPin = SeSacAnnotation(coordinate: coordinate, sesac: friends.sesac)
        self.selfView.mapView.addAnnotation(friendsPin)
    }

}



//⚠️ 임시로 해놓은것 지워야됨.
//        FirebaseService.shared.fetchIdToken { result in
//            print(result)
//            switch result {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }

