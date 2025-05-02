//
//  AppUIKiTTesteTests.swift
//  AppUIKiTTesteTests
//
//  Created by Sérgio César Lira Júnior on 07/04/25.
//

import Testing
import XCTest
@testable import AppUIKiTTeste

final class AppUIKiTTesteTests: XCTestCase {
    var session: URLSessionAPIClient!
    var mockSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        session = URLSessionAPIClient(session: mockSession)
    }
    
    override func tearDown() {
        session = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testResquestSuccessfulResponseReturnsDecodeObject() {
        //Given
        let expectedData = MockDecodable(id: 1, name: "Sergio")
        let jsonData = try! JSONEncoder().encode(expectedData)
        mockSession.data = jsonData
        mockSession.response = HTTPURLResponse(
            url: URL(string: "https://google.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        let endpoint = MockEndPoint(
            baseURL: URL(string: "https://google.com")!,
            path: "/test",
            method: .get
        )
        
        let expectation = self.expectation(description: "Success")
        
        //When
        session.request(endpoint) { (result: Result<MockDecodable, APIError>) in
            //Then
            switch result {
            case .success(let decodedObject):
                XCTAssertEqual(decodedObject, expectedData)
                
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testRequestNetworkErrorReturnsError() {
        //Given
        let expectedError = URLError(.notConnectedToInternet)
        mockSession.error = expectedError
        
        let endpoint = MockEndPoint(
            baseURL: URL(string: "https://google.com")!,
            path: "/test",
            method: .get
        )
        
        let expectation = self.expectation(description: "Network error expectation")
        
        //When
        session.request(endpoint) { (result: Result<MockDecodable, APIError>) in
            //Then
            switch result {
            case .success:
                XCTFail("Should not return success")
            case .failure(let error):
                switch error {
                case .requestError(let receivedError as URLError):
                    XCTAssertEqual(receivedError, expectedError)
                default:
                    XCTFail("Unexpected error \(error)")
                }
            }
            expectation.fulfill()
        }
        
         wait(for: [expectation], timeout: 1.0)
    }
}
