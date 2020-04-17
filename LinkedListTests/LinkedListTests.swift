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
    
    func testSubscriptGet() {
        let list = LinkedList("Hello", ",", " ", "World")
        
        XCTAssertEqual("Hello", list[0])
        XCTAssertEqual(",",     list[1])
        XCTAssertEqual(" ",     list[2])
        XCTAssertEqual("World", list[3])
    }
    
    func testSubscriptOutOfBounds() {
        let list = LinkedList("Hello", ",", " ", "World")
        expectingPreconditionFailure("Index out of bounds") { _ = list[4] }
        expectingPreconditionFailure("Index out of bounds") { _ = list[-1] }
    }
    
    func testReverse() {
        let list = LinkedList("Hello", ",", " ", "World")
        list.reverse()
        
        XCTAssertEqual("Hello", list[3])
        XCTAssertEqual(",",     list[2])
        XCTAssertEqual(" ",     list[1])
        XCTAssertEqual("World", list[0])
    }
    
    func testSubscriptSet() {
        let list = LinkedList("Hello", ",", " ", "World")
        list[3] = "Sailor"
        XCTAssertEqual("Sailor", list[3])
    }
    
    func testCopy() {
        let list = LinkedList("Hello", ",", " ", "World")
        let copiedList = list.copy()
        
        XCTAssertEqual("Hello", copiedList[0])
        XCTAssertEqual(",",     copiedList[1])
        XCTAssertEqual(" ",     copiedList[2])
        XCTAssertEqual("World", copiedList[3])
    }
    
    func testSequence() {
        let list = LinkedList(1, 2, 3, 4, 5, 6, 7, 8, 9)
        let sum = list.reduce(0, +)
        XCTAssertEqual(45, sum)
    }
    
    func testRemove() {
        let list = LinkedList("Hello", ",", " ", "World")
        list.remove(node: list.node(at: 1))
        
        XCTAssertEqual("Hello", list[0])
        XCTAssertEqual(" ",     list[1])
        XCTAssertEqual("World", list[2])
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
