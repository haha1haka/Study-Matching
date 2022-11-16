import UIKit
import SnapKit

class HeaderCell: BaseCollectionViewCell {
            
    var closedConstraint: NSLayoutConstraint?
    var openConstraint: NSLayoutConstraint?
    
    lazy var rootStack: UIStackView = {
        let rootStack = UIStackView(arrangedSubviews: [topStack, middleStack])
        rootStack.alignment = .top
        rootStack.distribution = .fillProportionally
        rootStack.axis = .vertical
        rootStack.spacing = 24
        return rootStack
    }()
    
    
    lazy var topStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            cellStackView,
            sectionLabel1,
            cardStackView
        ])
        view.axis = .vertical
        view.spacing = 16
        return view
    }()
    
    
    
    lazy var cellStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [sectionLabel0, disclosureView])
        view.distribution = .fillProportionally
        view.axis = .horizontal
        return view
    }()
    
    var sectionLabel0: UILabel = {
        let view = UILabel()
        view.text = "김새싹"
        view.font = SeSacFont.Title1_M16.set
        return view
    }()
    
    let disclosureView: UIImageView = {
        let disclosureView = UIImageView()
        disclosureView.image = UIImage(systemName: "chevron.down")
        disclosureView.contentMode = .scaleAspectFit
        disclosureView.preferredSymbolConfiguration = .init(textStyle: .body, scale: .small)
        disclosureView.tintColor = SeSacColor.gray7
        return disclosureView
    }()
    

    var sectionLabel1: UILabel = {
        let view = UILabel()
        view.text = "새싹 타이틀"
        view.font = SeSacFont.Title6_R12.set

        return view
    }()
    
    lazy var cardStackView: CardStackView = {
        let view = CardStackView()
        return view
    }()
    


    lazy var middleStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            sectionLabel2,
            textField
        ])
        view.axis = .vertical
        view.spacing = 16
        
        return view
    }()
    
    
    var sectionLabel2: UILabel = {
        let view = UILabel()
        view.text = "새싹 리뷰"
        view.font = SeSacFont.Title6_R12.set

        return view
    }()
    
    let textField: UITextField = {
        let view = UITextField()
        view.placeholder = "첫 리뷰를 기다리는 중이에요!"
        view.font = SeSacFont.Body3_R14.set
        return view
    }()
    
    

    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    

    override func configureHierarchy() {
        contentView.addSubview(rootStack)
    }
    
    override func configureLayout() {
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        rootStack.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.leading.trailing.equalTo(self).inset(16)
        }
        sectionLabel0.snp.makeConstraints {
            $0.height.equalTo(58)
        }
        disclosureView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(26)
            $0.width.equalTo(12)
            
        }
        topStack.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        middleStack.snp.makeConstraints {
            $0.top.equalTo(topStack.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
        
        
        closedConstraint =
        sectionLabel0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        closedConstraint?.priority = .defaultLow
        
        openConstraint =
        textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        openConstraint?.priority = .defaultLow
        
        
        updateAppearance()
    }
    
    
    override func configureAttributesInit() {
        layer.borderWidth = 1
        layer.borderColor = SeSacColor.gray2.cgColor
        layer.masksToBounds = true
        layer.cornerRadius = 8
    }
    
}


extension HeaderCell {
    func updateAppearance() {
        closedConstraint?.isActive = !isSelected
        openConstraint?.isActive = isSelected
        
        UIView.animate(withDuration: 0.3) {
            let upsideDown = CGAffineTransform(rotationAngle: .pi * 0.999 )
            self.disclosureView.transform = self.isSelected ? upsideDown :.identity
        }
    }
}
