import Foundation
import CoreLocation

protocol LocationAuthorizationCheckable {
    var locationManager: CLLocationManager { get }
    func checkUserDevicelocationServiceAuthorization(locationManager: CLLocationManager) //위치서비스활성화 여부
    func checkUserCurrentLocationAuthorization(locationManager: CLLocationManager, _ authorizationStatus: CLAuthorizationStatus) //권한상태분기처리
}

extension LocationAuthorizationCheckable {
    
    func checkUserDevicelocationServiceAuthorization(locationManager: CLLocationManager) {
        print("위처서비스 켜져 있나?1️⃣")
        DispatchQueue.main.async
        {
            let authorizationStatus: CLAuthorizationStatus
            
            if #available(iOS 14.0, *)
            {
                authorizationStatus = locationManager.authorizationStatus
            } else {
                authorizationStatus = CLLocationManager.authorizationStatus()
            }
            
            if CLLocationManager.locationServicesEnabled()
            {
                checkUserCurrentLocationAuthorization(locationManager: locationManager, authorizationStatus)
            } else {
                print("위치 서비스가 꺼져 잇어서 위치 권한 요청을 못합니다.")
            }
        }
    }
    
    func checkUserCurrentLocationAuthorization(locationManager: CLLocationManager, _ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("❓","NOTDETERMINED")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("❌DENEIED, 아이폰 설정으로 유도")
        case .authorizedWhenInUse:
            print("🎊"+"WHEN IN USE")
            locationManager.startMonitoringSignificantLocationChanges()
        default: print("DEFAULT")
        }
    }
}
