import UIKit
import SnapKit

class ProfileMainCell: BaseCollectionViewCell {
            
    var closedConstraint: NSLayoutConstraint?
    var openConstraint: NSLayoutConstraint?
    
    lazy var totalStackView: UIStackView = {
        let rootStack = UIStackView(arrangedSubviews: [topStackView, middleStackView, bottomStackView])
        rootStack.alignment = .top
        rootStack.distribution = .fillProportionally
        rootStack.axis = .vertical
        rootStack.spacing = 24
        return rootStack
    }()
    
    
    lazy var topStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameLabel, disclosureView])
        view.distribution = .fillProportionally
        view.axis = .horizontal
        return view
    }()
    
    lazy var middleStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            sectionLabel1,
            cardStackView
        ])
        view.axis = .vertical
        view.spacing = 16
        return view
    }()
    lazy var bottomStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            sectionLabel2,
            textField
        ])
        view.axis = .vertical
        view.spacing = 16
        
        return view
    }()

    
    var nameLabel: UILabel = {
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
        contentView.addSubview(totalStackView)
    }
    
    override func configureLayout() {
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        totalStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.leading.trailing.equalTo(self).inset(16)
        }
        
        topStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        middleStackView.snp.makeConstraints( {
            $0.top.equalTo(topStackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        })
        
        bottomStackView.snp.makeConstraints {
            $0.top.equalTo(middleStackView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(58)
        }
        
        disclosureView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(26)
            $0.width.equalTo(12)
            
        }

        closedConstraint =
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
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
    
    func configure(with item: MemoleaseUser) {
        nameLabel.text = item.nick
        
        var cnt = 0
        [cardStackView.button0, cardStackView.button1, cardStackView.button2, cardStackView.button3, cardStackView.button4, cardStackView.button5].forEach {
            if item.reputation[cnt] == .zero {
                $0.backgroundColor = SeSacColor.green
                $0.setTitleColor(SeSacColor.white, for: .normal)
                $0.layer.borderColor = SeSacColor.white.cgColor
            } else {
                //⚠️여기로 옮기기
            }
            cnt += 1
        }
        
        if item.comment.isEmpty {
            textField.placeholder = "첫 리뷰를 기다리는 중이에요~!"
        } else {
            textField.text = item.comment.first ?? ""
        }
        

    
    }

}


extension ProfileMainCell {
    func updateAppearance() {
        closedConstraint?.isActive = !isSelected
        openConstraint?.isActive = isSelected
        
        UIView.animate(withDuration: 0.3) {
            let upsideDown = CGAffineTransform(rotationAngle: .pi * 0.999 )
            self.disclosureView.transform = self.isSelected ? upsideDown :.identity
        }
    }
}
