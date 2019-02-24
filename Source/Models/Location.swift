//
//  Location.swift
//  DeliveryDetails
//
//  Created by Aatish Molasi on 2/24/19.
//  Copyright © 2019 Aatish Molasi. All rights reserved.
//

import Foundation

struct Location : Decodable {
    var lat: Double
    var lng: Double
    var address: String
}
