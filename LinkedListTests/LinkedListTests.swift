//
//  LinkedListTests.swift
//  LinkedListTests
//
//  Created by Ерохин Ярослав Игоревич on 17.04.2020.
//  Copyright © 2020 Ерохин Ярослав Игоревич. All rights reserved.
//

import XCTest
@testable import LinkedList

class LinkedListTest: XCTestCase {
    
    func testIt() {
        let list = LinkedList<String>()
        print(list)
        
        list.append("Hello")
        list.append(",")
        list.append(" ")
        list.append("World")
        
        XCTAssertEqual("Hello",     list[0])
        XCTAssertEqual(",",         list[1])
        XCTAssertEqual(" ",         list[2])
        XCTAssertEqual("World",     list[3])
        
        list[3] = "Sailor"
        
        XCTAssertEqual("Sailor", list[3])
        
        expectingPreconditionFailure("Index out of bounds") { _ = list[4] }
        expectingPreconditionFailure("Index out of bounds") { _ = list[-1] }
        
        list.reverse()
        
        XCTAssertEqual("Hello",     list[3])
        XCTAssertEqual(",",         list[2])
        XCTAssertEqual(" ",         list[1])
        XCTAssertEqual("Sailor",    list[0])
        
        print(list)
        
        let copiedList = list.copy()
        
        XCTAssertEqual("Hello",     copiedList[3])
        XCTAssertEqual(",",         copiedList[2])
        XCTAssertEqual(" ",         copiedList[1])
        XCTAssertEqual("Sailor",    copiedList[0])
    }
}

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
