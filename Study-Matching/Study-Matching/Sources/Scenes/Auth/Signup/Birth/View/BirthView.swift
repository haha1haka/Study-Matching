import UIKit
import SnapKit

class BirthView: BaseView {

    let label = SeSacLabel(text_: "생년월일을 알려주세요")
    let button = SeSacButton(title: "다음")
    let datePicker = UIDatePicker()
    let monthDateLabel = SeSacTexField()
    let yearDateLabel = SeSacTexField()
    let dayDateLabel = SeSacTexField()
    let containerView = UIView()
    let yearLabel = UILabel()
    let monthLabel = UILabel()
    let dayLabel = UILabel()
    
    override func configureHierarchy() {
        [label, button, datePicker].forEach { self.addSubview($0) }
        self.addSubview(containerView)
        [yearDateLabel, yearLabel,
         monthDateLabel, monthLabel,
         dayDateLabel, dayLabel].forEach{ containerView.addSubview($0) }
    }
    
    override func configureLayout() {
        label.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(125)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(74)
            $0.height.equalTo(64)
        }

        containerView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(80)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(48)
        }
        yearDateLabel.snp.makeConstraints {
            $0.centerY.equalTo(containerView.snp.centerY)
            $0.leading.equalTo(containerView)
            $0.width.equalTo(80)
            $0.height.equalTo(44)
            
        }
        yearLabel.snp.makeConstraints {
            $0.centerY.equalTo(containerView.snp.centerY)
            $0.leading.equalTo(yearDateLabel.snp.trailing)
            $0.width.equalTo(15)
        }
        
        monthDateLabel.snp.makeConstraints {
            $0.centerY.equalTo(containerView.snp.centerY)
            $0.leading.equalTo(yearLabel.snp.trailing).offset(23)
            $0.width.equalTo(80)
            $0.height.equalTo(44)
        }
        monthLabel.snp.makeConstraints {
            $0.centerY.equalTo(containerView.snp.centerY)
            $0.leading.equalTo(monthDateLabel.snp.trailing)
            $0.width.equalTo(15)
        }
        
        dayDateLabel.snp.makeConstraints {
            $0.centerY.equalTo(containerView.snp.centerY)
            $0.leading.equalTo(monthLabel.snp.trailing).offset(23)
            $0.width.equalTo(80)
            $0.height.equalTo(44)
        }
        dayLabel.snp.makeConstraints {
            $0.centerY.equalTo(containerView.snp.centerY)
            $0.leading.equalTo(dayDateLabel.snp.trailing)
            $0.width.equalTo(15)
        }
        
        
        button.snp.makeConstraints {
            $0.top.equalTo(yearDateLabel.snp.bottom).offset(72)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(48)
            
        }
        datePicker.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(216)
        }
    }
    override func configureAttributes() {
        yearLabel.text = "년"
        monthLabel.text = "월"
        dayLabel.text = "일"
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels

    }


}
