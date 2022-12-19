import UIKit
import SnapKit

class ProfileSubCell: BaseCollectionViewCell {
    
    let genderView: Gender2View = {
        let view = Gender2View()
        return view
    }()
    
    let studyView: StudyView = {
        let view = StudyView()
        return view
    }()
    
    let switchView: SwitchView = {
       let view = SwitchView()
        return view
    }()
    
    let ageView: AgeView = {
        let view = AgeView()
        
        return view
    }()
    let withDrawView: WithDrawView = {
        let view = WithDrawView()
        return view
    }()

    override func configureHierarchy() {
        addSubview(genderView)
        addSubview(studyView)
        addSubview(switchView)
        addSubview(ageView)
        addSubview(withDrawView)
    }
    
    override func configureLayout() {
        genderView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self)
            $0.height.equalTo(74)
        }
        studyView.snp.makeConstraints {
            $0.top.equalTo(genderView.snp.bottom)
            $0.leading.trailing.equalTo(self)
            $0.height.equalTo(74)
            
        }
        switchView.snp.makeConstraints {
            $0.top.equalTo(studyView.snp.bottom)
            $0.leading.trailing.equalTo(self)
            $0.height.equalTo(74)
            
        }
        ageView.snp.makeConstraints {
            $0.top.equalTo(switchView.snp.bottom)
            $0.leading.trailing.equalTo(self)
            $0.height.equalTo(74)
        }
        
        withDrawView.snp.makeConstraints {
            $0.top.equalTo(ageView.snp.bottom)
            $0.leading.trailing.equalTo(self)
            $0.height.equalTo(74)
        }
    }
}
