import UIKit
import SnapKit
import MapKit

class HomeView: BaseView {
    
    let mapView: MKMapView = {
        let view = MKMapView()
        return view
    }()
    
    let floattingButton: UIButton = {
        let view = UIButton(type: .custom)
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(SeSacImage.mapSearch, for: .normal)
        return view
    }()
    
        override func configureHierarchy() {
            addSubview(mapView)
            addSubview(floattingButton)
        }
    
        override func configureLayout() {
            mapView.snp.makeConstraints {
                $0.edges.equalTo(self.safeAreaLayoutGuide)
            }
            
            floattingButton.snp.makeConstraints {
                $0.width.height.equalTo(64)
                $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
                $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
            }
        }

    
}


