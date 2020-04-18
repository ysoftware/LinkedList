//
//  ExpectPrecondition.swift
//  LinkedListTests
//
//  Created by Ерохин Ярослав Игоревич on 18.04.2020.
//  Copyright © 2020 Ерохин Ярослав Игоревич. All rights reserved.
//

import XCTest
@testable import LinkedList

extension XCTestCase {
    
    func expectingPreconditionFailure(_ expectedMessage: String, _ block: () -> ()) {
        let ex = expectation(description: "failing precondition")
        preconditionClosure = { condition, message, file, line in
            if !condition {
                ex.fulfill()
                XCTAssertEqual(message, expectedMessage, "precondition message didn't match",
                               file: file, line: line)
            }
        }
        block()
        waitForExpectations(timeout: 0, handler: nil)
        preconditionClosure = defaultPreconditionClosure
    }
}
