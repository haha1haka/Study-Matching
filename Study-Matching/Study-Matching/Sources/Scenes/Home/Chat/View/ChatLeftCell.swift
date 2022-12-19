import UIKit
import SnapKit

class ChatLeftCell: BaseCollectionViewCell {
    
    let dateLabel: UILabel = {
        let view = UILabel()
        view.textColor = SeSacColor.gray6
        view.text = "15:02"
        view.font = SeSacFont.Title6_R12.set
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.borderColor = SeSacColor.gray4.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let label: UILabel = {
        let view = UILabel()
        view.backgroundColor = .white
        view.numberOfLines = 0
        view.font = SeSacFont.Body3_R14.set
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(containerView)
        containerView.addSubview(label)
        addSubview(dateLabel)
    }
    
    override func configureLayout() {

        label.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(10)
            $0.leading.equalTo(self.snp.leading).offset(32)
            $0.bottom.equalTo(containerView.snp.bottom).offset(-10)
            $0.width.lessThanOrEqualTo(232)
        }
        
        containerView.snp.makeConstraints {
            $0.leading.equalTo(label.snp.leading).offset(-16)
            $0.trailing.equalTo(label.snp.trailing).offset(16)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(6)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-6)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.trailing).offset(8)
            $0.bottom.equalTo(containerView.snp.bottom)
        }
    }
    
    func configureCell(with itemIdentifier: Chat) {
        label.text = itemIdentifier.chat
        dateLabel.text = itemIdentifier.createdAt.stringToDate.toString
    }
}
