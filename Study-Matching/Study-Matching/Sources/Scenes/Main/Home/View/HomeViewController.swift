import UIKit
import RxSwift
import RxCocoa
import CoreLocation
import MapKit
import SnapKit

class HomeViewController: BaseViewController {
    
    let selfView        = HomeView()
    let viewModel       = HomeViewModel()
    let disposeBag      = DisposeBag()
    let locationManager = CLLocationManager()
    let center          = CLLocationCoordinate2D(latitude: 37.564713,longitude: 126.975122)
    
    override func loadView() { view = selfView }
}

extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.mapView.delegate = self
        locationManager.delegate = self
        checkUserDevicelocationServiceAuthorization(locationManager: locationManager)
        selfView.totalButton.toAct //⚠️ 개선
        bind()
    }
}


extension HomeViewController {
    func bind() {
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
                    let coordinate = CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.long)
                    let friendsPin = SeSacAnnotation(coordinate: coordinate, sesac: $0.sesac)
                    self.selfView.mapView.addAnnotation(friendsPin)
                }
            })
            .disposed(by: disposeBag)
        
        
        
    }
    
    
}







// MARK: - LocationCheckable
///1)위치서비스활성화 여부확인 2) 승인상태 분기처리
extension HomeViewController: LocationAuthorizationCheckable {}



// MARK: - CLLocationManagerDelegate
///1) 위치 받아오는함수  2) 디바이스 위치서비스  Auth 확인 --> 항상 초장에호출됨 --> 안에 "위치서비스" 여부 확인하는 코드 심어주기
extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("🐷","내 위치 호출!",#function, locations)
        
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate)
        }
        
        //selfView.mapView.centerCoordinate
        
        
        locationManager.stopUpdatingLocation()
        
    }
    
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("🐶")
        checkUserDevicelocationServiceAuthorization(locationManager: locationManager)
    }
    
    
}



// MARK: - MKMapviewDelegate
extension HomeViewController: MKMapViewDelegate {
    
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
    
}


extension HomeViewController {
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        selfView.mapView.setRegion(region, animated: true)
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
