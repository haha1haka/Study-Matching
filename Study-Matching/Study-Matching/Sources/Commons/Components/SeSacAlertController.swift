import UIKit
import SnapKit

class SeSacAlertController: UIViewController {
    
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
    
    let mainLabel: SeSacLabel = {
        let view = SeSacLabel(text_: "정말 탈퇴 하시겠습니까?", font_: SeSacFont.Body1_M16.set)
        return view
    }()
    let subLabel: SeSacLabel = {
        let view = SeSacLabel(text_: "탈퇴하시면 새싹 스터디를 이용할 수 없어요ㅠ", font_: SeSacFont.Title4_R14.set)
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
            $0.top.equalToSuperview().offset(329)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(327)
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
