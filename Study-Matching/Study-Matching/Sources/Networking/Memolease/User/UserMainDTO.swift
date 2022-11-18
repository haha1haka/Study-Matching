//
//  UserDTO.swift
//  Study-Matching
//
//  Created by HWAKSEONG KIM on 2022/11/18.
//

import Foundation


struct UserMainDTO: Codable, Hashable {
    let nick: String
    let comment: [String]
    let reputation: [Int]
    let sesac: Int
    let background: Int

}
