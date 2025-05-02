//
//  MockURLSessionDataTask.swift
//  AppUIKiTTeste
//
//  Created by Sérgio César Lira Júnior on 25/04/25.
//

import Foundation


class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
