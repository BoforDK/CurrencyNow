//
//  Networking.swift
//  AppCore
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import Foundation

// MARK: – NetworkApi protocol

public protocol Networking {
    func sendGetRequest<T: Decodable>(type: T.Type, url: URL) async throws -> T
}

extension Networking {
    func sendGetRequest<T: Decodable>(type: T.Type = T.self, url: URL) async throws -> T {
        try await sendGetRequest(type: type, url: url)
    }
}

// MARK: - NetworkApi

public class Network: Networking {
    private var session: URLSession
    private var apiKey: String

    public init(
        session: URLSession = .shared,
        apiKey: String
    ) {
        self.session = session
        self.apiKey = apiKey
    }

    public func sendGetRequest<T: Decodable>(type: T.Type, url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue(Environment.apiKey, forHTTPHeaderField: "WEB-API-key")

        return try await sendRequest(request)
    }

    private func sendRequest<T: Decodable>(
        type: T.Type = T.self,
        _ request: URLRequest
    ) async throws -> T {
        let data = try await sendRequest(request)
        let decodedData = try JSONDecoder().decode(T.self, from: data)

        return decodedData
    }

    private func sendRequest(_ request: URLRequest) async throws -> Data {
        let (data, _) = try await session.data(for: request)

        return data
    }

    // MARK: - HTTPMethod

    public enum HTTPMethod: String {
        case get
    }
}
