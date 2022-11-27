//
//  SeSacButton+.swift
//  Study-Matching
//
//  Created by HWAKSEONG KIM on 2022/11/20.
//

import Foundation

extension SeSacButton {
    
    
    var toAct: Void  {
        backgroundColor = SeSacColor.green
        setTitleColor(SeSacColor.white, for: .normal)
        layer.borderColor = SeSacColor.white.cgColor
    }
    var toInAct: Void {
        backgroundColor = SeSacColor.white
        setTitleColor(SeSacColor.black, for: .normal)
        layer.borderColor = SeSacColor.gray4.cgColor
        layer.borderWidth = 1
    }
    
}
