//
//  Untitled.swift
//  AppUIKiTTeste
//
//  Created by Sérgio César Lira Júnior on 11/04/25.
//
import Foundation

protocol APIENdoPoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: Error {
    case invalidURL
    case invalidData
    case invalidResponse
    case requestError(Error)
    case decodingError(Error)
    case parsingError
}

extension APIError: Equatable {
    static func ==(lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.invalidData, .invalidData):
            return true
        case (.invalidResponse, .invalidResponse):
            return true
        case (.parsingError, .parsingError):
            return true
        case (.requestError(let lhsError), .requestError(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.decodingError(let lhsError), .decodingError(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
