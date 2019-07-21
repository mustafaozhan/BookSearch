//
//  URLSession.swift
//  BookSearch
//
//  Created by Mustafa Ozhan on 21/07/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation
import Combine

enum RequestError: Error {
    case request(code: Int, error: Error?)
    case cannotParse
    case unknown
}

extension URLSession {
    
    func send(request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { data, response  -> Data in
                let httpResponse = response as? HTTPURLResponse
                if let httpResponse = httpResponse, 200..<300 ~= httpResponse.statusCode {
                    return data
                } else if let httpResponse = httpResponse {
                    throw RequestError.request(code: httpResponse.statusCode, error: NSError(domain: httpResponse.description, code: httpResponse.statusCode, userInfo: httpResponse.allHeaderFields as? [String : Any]))
                } else {
                    throw RequestError.unknown
                }
        }
        .eraseToAnyPublisher()
    }
}
