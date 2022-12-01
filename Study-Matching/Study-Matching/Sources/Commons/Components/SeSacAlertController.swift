import UIKit
import SnapKit

enum AlertType {
    case myInfo
    case findNearby
    case findRequested
}

class SeSacAlertController: UIViewController {
    
    var mainLabelText: String?
    var subLabelText: String?
    var heightControl = 0
    
    
    convenience init(alertType: AlertType) {
        self.init()
        switch alertType {
        case .myInfo:
            mainLabelText = "정말 탈퇴 하시겠습니까?"
            subLabelText = "탈퇴하시면 새싹 스터디를 이용할 수 없어요ㅠ"
        case .findNearby:
            mainLabelText = "스터디 요청할게요!"
            subLabelText = "상대방이 요청을 수락하면\n채팅창에서 대화를 나눌 수 있어요"
            self.heightControl = 20
        case .findRequested:
            mainLabelText = "스터디를 수락할까요?"
            subLabelText = "요청을 수락하면 채팅창에서 대화를 나룰 수 있어요"
            self.heightControl = 20
            
        }
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    
    lazy var labelStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            mainLabel,
            subLabel
        ])
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fillProportionally
        return view
    }()
    
    lazy var mainLabel: SeSacLabel = {
        let view = SeSacLabel(text_: self.mainLabelText!, font_: SeSacFont.Body1_M16.set)
        return view
    }()
    lazy var subLabel: SeSacLabel = {
        let view = SeSacLabel(text_: self.subLabelText!, font_: SeSacFont.Title4_R14.set)
        return view
    }()
    
    
    lazy var buttonStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            cancelButton,completeButton
        ])
        view.distribution = .fillEqually
        view.spacing = 8
        view.axis = .horizontal
        return view
    }()
    
    let cancelButton: SeSacButton = {
        let view = SeSacButton(title: "취소")
        return view
    }()
    let completeButton: SeSacButton = {
        let view = SeSacButton(title: "확인")
        view.toAct
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureAttributes()
    }
    
    
    
    func configureHierarchy() {
        view.addSubview(containerView)
        [labelStackView, buttonStackView].forEach { containerView.addSubview($0) }
    }
    
    func configureLayout() {
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(329 - heightControl)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(327 - heightControl)
        }
        
        
        labelStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(60)
        }
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(labelStackView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
    func configureAttributes() {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
}
