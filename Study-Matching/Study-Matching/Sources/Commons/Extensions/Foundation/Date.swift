//
//  Date.swift
//  Study-Matching
//
//  Created by HWAKSEONG KIM on 2022/11/12.
//

import Foundation

extension Date {
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }

    var day: Int {
        return Calendar.current.component(.day, from: self)
    }

}
