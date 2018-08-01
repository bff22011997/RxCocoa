//
//  Issue.swift
//  CocoaApp
//
//  Created by Trung Kiên on 7/31/18.
//  Copyright © 2018 Trung Kiên. All rights reserved.
//

import Foundation
import Mapper

struct Issue: Mappable {
    
    let identifier: Int
    let number: Int
    let title: String
    let body: String
    
    init(map: Mapper) throws {
        try identifier = map.from("id")
        try number = map.from("number")
        try title = map.from("title")
        try body = map.from("body")
    }
}
