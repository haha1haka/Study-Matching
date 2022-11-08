import UIKit
import SnapKit


class DateLabel: UILabel {

    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .opaqueSeparator
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DateLabel {

    func configureLayout() {
        dividerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(1)
        }
    }
    func configureHierarchy() {
        self.addSubview(dividerView)
    }
}

