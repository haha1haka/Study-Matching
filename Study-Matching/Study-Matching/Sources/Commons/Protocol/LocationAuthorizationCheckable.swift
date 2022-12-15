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
            print("❓","NOTDETERMINED") // 최초 정의 되어 있지 않으니깐
            locationManager.desiredAccuracy = kCLLocationAccuracyBest //정확도 넣어주기,정확도에 따라 🐷 호출 빈도 다른듯?
            locationManager.requestWhenInUseAuthorization() //얼럿띄워!
            
        case .restricted, .denied: // 허용 안한다 했을때
            print("❌DENEIED, 아이폰 설정으로 유도")
            //showRequestLocationServiceAlert() //설정 창으로 이동
            
        case .authorizedWhenInUse:
            print("🎊"+"WHEN IN USE") //한번만 허용 or 앱사용하는 동안 허용
            //locationManager.startUpdatingLocation() // 🐷 불르기
            locationManager.startMonitoringSignificantLocationChanges()
            
        default: print("DEFAULT")
            
        }
    }
    
    
}
