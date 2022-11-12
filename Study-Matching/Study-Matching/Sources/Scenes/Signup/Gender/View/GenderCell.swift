//
//  GenderCell.swift
//  Study-Matching
//
//  Created by HWAKSEONG KIM on 2022/11/12.
//

import UIKit

class GenderCell: BaseCollectionViewCell {

    let imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            isSelectedCell()
        }
    }
    
    func isSelectedCell() {
        if isSelected {
            imageView.backgroundColor = SeSacColor.whitegreen
        } else {
            imageView.backgroundColor = SeSacColor.white
        }
        
        
    }
    
    override func configureHierarchy() {
        self.addSubview(imageView)
    }
    override func configureLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }

}
