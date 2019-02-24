//
//  APIConstants.swift
//  DeliveryDetails
//
//  Created by Aatish Molasi on 2/24/19.
//  Copyright © 2019 Aatish Molasi. All rights reserved.
//

import Foundation

var limit = 6

enum InternetProtocol : String {
    case http = "http://"
    case https = "https://"
}

let hostname = "mock-api-mobile.dev.lalamove.com"

enum Endpoint : String {
    case deliveries = "/deliveries"
    case details = "/details"
}

struct K {
    struct ProductionServer {
        static let baseURL = InternetProtocol.https.rawValue + "mock-api-mobile.dev.lalamove.com"
    }

    struct APIParameterKey {
        static let offset = "offset"
        static let limit = "limit"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
