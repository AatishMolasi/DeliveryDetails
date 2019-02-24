//
//  APIRouter.swift
//  DeliveryDetails
//
//  Created by Aatish Molasi on 2/24/19.
//  Copyright © 2019 Aatish Molasi. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    case deliveries(offset: Int?, limit: Int?)

    private var method: HTTPMethod {
        switch self {
        case .deliveries:
            return .get
        }
    }

    private var endpoint: String {
        switch self {
        case .deliveries:
            return "/deliveries"
        }
    }

    private var parameters: Parameters? {
        switch self {
        case .deliveries(let offset, let limit):
            var paramDict: [String: Int] = [:]
            if offset == offset {
                paramDict[K.APIParameterKey.offset] = offset
            }
            if offset == offset {
                paramDict[K.APIParameterKey.limit] = limit
            }
            return paramDict
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(endpoint))

        urlRequest.httpMethod = method.rawValue

        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        return urlRequest
    }
}
