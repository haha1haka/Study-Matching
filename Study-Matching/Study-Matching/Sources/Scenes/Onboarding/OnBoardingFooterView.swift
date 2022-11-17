import UIKit
import SnapKit

class OnBoardingFooterView: UICollectionReusableView {
    
    
    
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




