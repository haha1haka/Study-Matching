import UIKit
import SnapKit
import MultiSlider

 

class AgeView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "상대방 연령대"
        label.font = SeSacFont.Title4_R14.set
        label.textColor = SeSacColor.black
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.text = "18 - 35"
        label.font = SeSacFont.Title3_M14.set
        label.textColor = SeSacColor.green
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    
    lazy var totalStackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
            titleLabel,
            ageLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    let multislider: MultiSlider = {
        let slider = MultiSlider()
        slider.minimumValue = 18
        slider.maximumValue = 65
        slider.thumbCount = 2
        slider.backgroundColor = .clear
        slider.orientation = .horizontal
        slider.tintColor = SeSacColor.green
        slider.outerTrackColor = SeSacColor.gray7
        slider.thumbImage = SeSacImage.filterControl
        slider.keepsDistanceBetweenThumbs = true
        slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
        return slider
    }()
    
    @objc
    func sliderChanged(_ slider: MultiSlider) {
        let minAge = Int(slider.value[0])
        let maxAge = Int(slider.value[1])
        ageLabel.text = "\(minAge) - \(maxAge)"
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        addSubview(totalStackView)
        addSubview(multislider)
    }
    
    func configureLayout() {
        totalStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self)
            
        }
        multislider.snp.makeConstraints {
            $0.top.equalTo(totalStackView.snp.bottom)
            $0.leading.bottom.trailing.equalTo(self)
        }
    }

    
}
