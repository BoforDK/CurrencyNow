//
//  NetworkFake.swift
//  AppCore
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import Foundation

public class NetworkFake: Networking {
    public init(
        sendGetRequestTestBody: @escaping (Any, URL) -> Result<Data, Error>
    ) {
        self.sendGetRequestTestBody = sendGetRequestTestBody
    }

    public var sendGetRequestTestBody: (Any, URL) -> Result<Data, Error>
    public func sendGetRequest<T: Decodable>(
        type: T.Type,
        url: URL
    ) async throws -> T {
        switch sendGetRequestTestBody(type, url) {
        case let .success(data):
            return try JSONDecoder().decode(T.self, from: data)
        case let .failure(error):
            throw error
        }
    }
}
