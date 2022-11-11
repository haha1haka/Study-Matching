import UIKit
import SnapKit

class FooterView: UICollectionReusableView {
    
    
    
    lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.isUserInteractionEnabled = true
        control.currentPageIndicatorTintColor = SeSacColor.black
        control.pageIndicatorTintColor = SeSacColor.gray5
        control.backgroundColor = .clear
        return control
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarcy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureHierarcy() {
        self.addSubview(pageControl)
    }
    
    func configureLayout() {
        pageControl.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
    

    func configure(with numberOfPages: Int) {
        pageControl.numberOfPages = numberOfPages
    }
    
}




class SectionHeaderView: UICollectionReusableView {
    static var identifier: String {
        return String(describing: SectionHeaderView.self)
    }
    // 2
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title2).pointSize, weight: .bold)
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 1
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(titleLabel)
        
        self.backgroundColor = .clear
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(self).offset(15)
            $0.top.equalTo(self).offset(30)
            $0.bottom.equalTo(self).offset(-8)
            //$0.centerY.equalTo(self)
        }

        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



