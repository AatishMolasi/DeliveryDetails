//
//  DeliveryManager.swift
//  Delivery
//
//  Created by Aatish Molasi on 2/24/19.
//  Copyright © 2019 Gaurav Rastogi. All rights reserved.
//

import Foundation

class DeliveryManager {
    static let sharedManager = DeliveryManager()

    init() {}

    func getDeliveries(page: Int, completion: @escaping ([Delivery]?, DataResponseError?)->()) {
        DeliveryRequest.get(deliveriesWith: 0, limit: 6) { (result) in
            switch result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
