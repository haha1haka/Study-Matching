import UIKit
import SnapKit
import MapKit

class HomeView: BaseView {
    
    let mapView: MKMapView = {
        let view = MKMapView()
        return view
    }()
        override func configureHierarchy() {
            addSubview(mapView)
        }
        override func configureLayout() {
            mapView.snp.makeConstraints {
                $0.edges.equalTo(self.safeAreaLayoutGuide)
            }
        }

    
}


