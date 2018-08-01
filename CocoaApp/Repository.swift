//
//  Repository.swift
//  CocoaApp
//
//  Created by Trung Kiên on 7/31/18.
//  Copyright © 2018 Trung Kiên. All rights reserved.
//

import Foundation
import Mapper
struct Repository: Mappable {
    
    let identifier: Int
    let language: String
    let name: String
    let fullName: String
    
    init(map: Mapper) throws {
        try identifier = map.from("id")
        try language = map.from("language")
        try name = map.from("name")
        try fullName = map.from("full_name")
    }
}
