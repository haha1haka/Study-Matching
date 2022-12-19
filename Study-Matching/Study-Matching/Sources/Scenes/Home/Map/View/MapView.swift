import UIKit
import SnapKit
import MapKit

enum Gender {
    case total
    case man
    case woman
}

class MapView: BaseView {
    
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
        view.setImage(SeSacImage.default, for: .normal)
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
    
    func makeActByGender(gender: Gender) {
        switch gender {
        case .total:
            totalButton.titleLabel?.font = SeSacFont.Title3_M14.set
            totalButton.backgroundColor = SeSacColor.green
            totalButton.setTitleColor(SeSacColor.white, for: .normal)
            manButton.titleLabel?.font = SeSacFont.Title4_R14.set
            manButton.backgroundColor = SeSacColor.white
            manButton.setTitleColor(SeSacColor.black, for: .normal)
            womanButton.titleLabel?.font = SeSacFont.Title4_R14.set
            womanButton.backgroundColor = SeSacColor.white
            womanButton.setTitleColor(SeSacColor.black, for: .normal)
            
        case .man:
            totalButton.titleLabel?.font = SeSacFont.Title4_R14.set
            totalButton.backgroundColor = SeSacColor.white
            totalButton.setTitleColor(SeSacColor.black, for: .normal)
            manButton.titleLabel?.font = SeSacFont.Title3_M14.set
            manButton.backgroundColor = SeSacColor.green
            manButton.setTitleColor(SeSacColor.white, for: .normal)
            womanButton.titleLabel?.font = SeSacFont.Title4_R14.set
            womanButton.backgroundColor = SeSacColor.white
            womanButton.setTitleColor(SeSacColor.black, for: .normal)
        case .woman:
            totalButton.titleLabel?.font = SeSacFont.Title4_R14.set
            totalButton.backgroundColor = SeSacColor.white
            totalButton.setTitleColor(SeSacColor.black, for: .normal)
            manButton.titleLabel?.font = SeSacFont.Title4_R14.set
            manButton.backgroundColor = SeSacColor.white
            manButton.setTitleColor(SeSacColor.black, for: .normal)
            womanButton.titleLabel?.font = SeSacFont.Title3_M14.set
            womanButton.backgroundColor = SeSacColor.green
            womanButton.setTitleColor(SeSacColor.white, for: .normal)
        }
    }
}


