//
//  Result.swift
//  DeliveryDetails
//
//  Created by Aatish Molasi on 2/24/19.
//  Copyright © 2019 Aatish Molasi. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(DataResponseError)
}
