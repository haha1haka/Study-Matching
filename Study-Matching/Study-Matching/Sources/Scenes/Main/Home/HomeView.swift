import UIKit
import SnapKit
import MapKit

class HomeView: BaseView {
    
    let mapView: MKMapView = {
        let view = MKMapView()
        return view
    }()
    
    let mapMarker: UIImageView = {
        let view = UIImageView()
        view.image = SeSacImage.mapMarker
        return view
    }()
    
    lazy var totalStackView: UIStackView = {
        let view = UIStackView(
            arrangedSubviews: [
                topStackView,
                currentLocationButton
            ])
        view.axis = .vertical
        view.spacing = 16
        view.distribution = .fillProportionally
        return view
    }()
    
    lazy var topStackView: UIStackView = {
        let view = UIStackView(
            arrangedSubviews: [
                totalButton,
                manButton,
                womanButton
            ])
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    let totalButton: SeSacButton = {
        let view = SeSacButton(title: "전체", type: .map)
        return view
    }()
    
    let manButton: SeSacButton = {
        let view = SeSacButton(title: "남자", type: .map)
        return view
    }()
    
    let womanButton: SeSacButton = {
        let view = SeSacButton(title: "여자", type: .map)
        return view
    }()
    
    let currentLocationButton: SeSacButton = {
        let view = SeSacButton(title: "", type: .map)
        view.setImage(SeSacImage.place, for: .normal)
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
        addSubview(mapMarker)
        addSubview(totalStackView)
        addSubview(floattingButton)
    }
    
    override func configureLayout() {
        mapView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        mapMarker.snp.makeConstraints {
            $0.center.equalTo(self.snp.center)
        }
        
        floattingButton.snp.makeConstraints {
            $0.width.height.equalTo(64)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        totalStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(52)
            $0.leading.equalToSuperview().offset(16)
        }
        totalButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
        }
        currentLocationButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
        }
    }
    override func configureAttributes() {
        topStackView.toRadius
        currentLocationButton.toRadius
    }
    
    
    
}


