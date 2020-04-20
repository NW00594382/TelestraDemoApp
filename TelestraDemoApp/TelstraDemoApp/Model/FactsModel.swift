//
//  DataModel.swift
//  AssignmentApp
//
//  Created by Nikhil Wagh on 4/15/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import Foundation

struct FactsModel: Decodable {
    let title: String
    let rows: [Row]
}

struct Row: Decodable {
    let title: String?
    var description: String?
    let imageHref: String?
}
