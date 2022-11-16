import UIKit
import SnapKit





class MyInfoHeaderView: UICollectionReusableView {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = SeSacImage.profileImg
        return view
    }()
    
    let label: UILabel = {
        let view = UILabel()
        view.text = "김새싹"
        view.font = SeSacFont.Title1_M16.set
        return view
    }()
    
    let nextImageView: UIImageView = {
        let view = UIImageView()
        view.image = SeSacImage.moreArrow
        view.backgroundColor = .clear
        return view
    }()
    let nextButton: UIButton = {
        let view = UIButton()
        
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
    
    func configureHierarchy() {
        [imageView, label, nextImageView, nextButton].forEach { addSubview($0) }
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints {
            $0.leading.equalTo(self).offset(15)
            $0.centerY.equalTo(self.snp.centerY)
            $0.width.height.equalTo(50)
        }
        label.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(13)
            $0.centerY.equalTo(self.snp.centerY)
            
        }
        nextImageView.snp.makeConstraints {
            $0.trailing.equalTo(self).inset(23)
            $0.centerY.equalTo(self.snp.centerY)
        }
        nextButton.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
    
}



