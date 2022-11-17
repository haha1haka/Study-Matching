import UIKit
import CoreLocation
import MapKit
import SnapKit

class HomeViewController: BaseViewController {
    let selfView = HomeView()
    override func loadView() {
        view = selfView
    }
    let viewModel = HomeViewModel()
    
    let locationManager = CLLocationManager()
    let center = CLLocationCoordinate2D(latitude: 37.564713, longitude: 126.975122)
}

extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.mapView.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        locationManager.delegate = self
        
    }
}
extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("🐷","내 위치 호출!",#function, locations)
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate)
        }
//        locationManager.stopUpdatingLocation()
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("🐶",#function)
        checkUserDevicelocationServiceAuthorization()
    }
}

// MARK: - Methods 1) 위치서비스, 2) 승인상태 분기처리, 3) 설정으로가능Alert
extension HomeViewController {
    
    func checkUserDevicelocationServiceAuthorization() {
        print("위처서비스 켜져 있나?1️⃣")
        let authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        if CLLocationManager.locationServicesEnabled() {
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스가 꺼져 잇어서 위치 권한 요청을 못합니다.")
        }
    }

    
    
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("❓","NOTDETERMINED") // 최초 정의 되어 있지 않으니깐
            locationManager.desiredAccuracy = kCLLocationAccuracyBest //정확도 넣어주기,정확도에 따라 🐷 호출 빈도 다른듯?
            //locationManager.requestWhenInUseAuthorization() //얼럿띄워!
            
        case .restricted, .denied: // 허용 안한다 했을때
            print("❌DENEIED, 아이폰 설정으로 유도")
            showRequestLocationServiceAlert() //설정 창으로 이동
        case .authorizedWhenInUse:
            print("🎊"+"WHEN IN USE") //한번만 허용 or 앱사용하는 동안 허용
            locationManager.startUpdatingLocation() // 🐷 불르기
        default: print("DEFAULT")
            
        }
    }
    
    func showRequestLocationServiceAlert() {
      let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        
      let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
          if let appSetting = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(appSetting)
          }
      }
      let cancel = UIAlertAction(title: "취소", style: .default)
      requestLocationServiceAlert.addAction(cancel)
      requestLocationServiceAlert.addAction(goSetting)
      present(requestLocationServiceAlert, animated: true, completion: nil)
    }
}



extension HomeViewController {
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        selfView.mapView.setRegion(region, animated: true)

    }
}
extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return MKAnnotationView()
    }
}
