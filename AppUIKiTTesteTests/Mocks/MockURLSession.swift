//
//  MockURLSession.swift
//  AppUIKiTTeste
//
//  Created by Sérgio César Lira Júnior on 25/04/25.
//
import Foundation
@testable import AppUIKiTTeste



struct MockEndPoint: APIEndpoints {
    var baseURL: URL
    var path: String
    var method: HTTPMethod
    var headers: [String : String]?
    var parameters: [String : Any]?
}

struct MockDecodable: Codable, Equatable {
    let id: Int
    let name: String
}  

final class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        return MockURLSessionDataTask {
            completionHandler(self.data, self.response, self.error)
        }
    }
}
