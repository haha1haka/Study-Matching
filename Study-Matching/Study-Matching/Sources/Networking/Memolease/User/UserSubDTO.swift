//
//  UserSubDTO.swift
//  Study-Matching
//
//  Created by HWAKSEONG KIM on 2022/11/18.
//

import Foundation


struct UserSubDTO: Codable, Hashable {
    
    let gender: Int
    let study: String
    let searchable: Int
    let ageMin, ageMax: Int
    

}
