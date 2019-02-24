//
//  DeliveyRequest.swift
//  DeliveryDetails
//
//  Created by Aatish Molasi on 2/24/19.
//  Copyright © 2019 Aatish Molasi. All rights reserved.
//

import Foundation
import Alamofire

class DeliveryRequest {
    static func get(deliveriesWith offset:Int?,
                    limit:Int?,
                    retries: Int = 2,
                    completion:@escaping (Result<[Delivery]>)->Void) {
        Alamofire.request(APIRouter.deliveries(offset: offset, limit: limit))
            .responseJSON { (response) in
                guard let data = response.data else {
                    print("API Error")
                    if retries > 0 {
                        get(deliveriesWith: offset, limit: limit, retries: retries - 1, completion: completion)
                    } else {
                        completion(.failure(DataResponseError.network))
                    }
                    return
                }
                do {
                    let jsonDecoder = JSONDecoder()
                    let deliveries = try jsonDecoder.decode([Delivery].self, from: data)
                    completion(.success(deliveries))
                } catch {
                    print("Formatting error: \(error)")
                    if retries > 0 {
                        get(deliveriesWith: offset, limit: limit, retries: retries - 1, completion: completion)
                    } else {
                        completion(.failure(DataResponseError.decoding))
                    }
                }
        }
    }
}
