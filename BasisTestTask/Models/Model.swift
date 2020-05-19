//
//  Model.swift
//  BasisTestTask
//
//  Created by Himanshu Chaurasiya on 19/05/20.
//  Copyright © 2020 Himanshu Chaurasiya. All rights reserved.
//

import Foundation

// MARK: - Response
struct ResponseModel: Codable {
    let data: [CardData]?
}

// MARK: - Datum
struct CardData: Codable {
    let id, text: String?
}
