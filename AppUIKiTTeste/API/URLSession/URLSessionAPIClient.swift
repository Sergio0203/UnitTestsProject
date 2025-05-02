//
//  URLSessionAPIClient.swift
//  AppUIKiTTeste
//
//  Created by Sérgio César Lira Júnior on 11/04/25.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

final class URLSessionAPIClient: APIClient {
     private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable, U: APIEndpoints>(_ endpoint:  U, completion: @escaping (Result<T, APIError>) -> Void) {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }

        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestError(error)))
                return
            }
            guard let response = response as? HTTPURLResponse, (200...399).contains(response.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch let decodingError {
                completion(.failure(.decodingError(decodingError)))
            }
        }.resume()
    }
}


