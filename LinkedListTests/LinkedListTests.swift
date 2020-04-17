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
        XCTAssertEqual(4, list.count)
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
        XCTAssertEqual(4, list.count)
    }
    
    func testSubscriptSet() {
        let list = LinkedList("Hello", ",", " ", "World")
        list[3] = "Sailor"
        
        XCTAssertEqual("Sailor", list[3])
        XCTAssertEqual(4, list.count)
    }
    
    func testCopy() {
        let list = LinkedList("Hello", ",", " ", "World")
        let copiedList = list.copy()
        
        XCTAssertEqual("Hello", copiedList[0])
        XCTAssertEqual(",",     copiedList[1])
        XCTAssertEqual(" ",     copiedList[2])
        XCTAssertEqual("World", copiedList[3])
        XCTAssertEqual(list.count, copiedList.count)
    }
    
    func testSequence() {
        let list = LinkedList(1, 2, 3, 4, 5, 6, 7, 8, 9)
        let sum = list.reduce(0, +)
        
        XCTAssertEqual(45, sum)
    }
    
    func testSequenceGet() {
        let list = LinkedList(1, 2, 3, 4, 5, 6, 7, 8, 9)
        
        XCTAssertEqual(list.first, 1)
    }
    
    func testDropFirst() {
        let list = LinkedList(1, 2, 3, 4, 5, 6)
        list.dropFirst()
        
        XCTAssertEqual(2, list.first)
        XCTAssertEqual(5, list.count)
        
        list.dropFirst(2)
        
        XCTAssertEqual(4, list.first)
        XCTAssertEqual(3, list.count)
    }
    
    func testDropLast() {
        let list = LinkedList(1, 2, 3, 4, 5, 6)
        list.dropLast()
        
        XCTAssertEqual(5, list.last)
        XCTAssertEqual(5, list.count)
        
        list.dropLast(2)
        
        XCTAssertEqual(3, list.last)
        XCTAssertEqual(3, list.count)
    }
    
    func testRemove() {
        let list = LinkedList("Hello", ",", " ", "World")
        list.remove(node: list.node(at: 1))
        
        XCTAssertEqual("Hello", list[0])
        XCTAssertEqual(" ",     list[1])
        XCTAssertEqual("World", list[2])
        XCTAssertEqual(3, list.count)
    }
    
    func testRemoveAtIndex() {
        let list = LinkedList("Hello", ",", " ", "World")
        list.remove(at: 1)
        
        XCTAssertEqual("Hello", list[0])
        XCTAssertEqual(" ",     list[1])
        XCTAssertEqual("World", list[2])
        XCTAssertEqual(3, list.count)
    }
    
    func testRemoveFirst() {
        let list = LinkedList(1, 2, 3, 4, 5)
        let secondNode = list.node(at: 1)
        list.remove(at: 0)
        
        XCTAssertEqual(4, list.count)
        XCTAssert(list.firstNode === secondNode)
    }
    
    func testRemoveLast() {
        let list = LinkedList(1, 2, 3, 4, 5)
        let secondToLastNode = list.node(at: list.count-2)
        list.remove(at: list.count-1)
        
        XCTAssertEqual(4, list.count)
        XCTAssert(list.lastNode === secondToLastNode)
    }
    
    func testContains() {
        let list = LinkedList(1, 2, 3, 4, 5)
        
        XCTAssertTrue(list.contains(1))
        XCTAssertTrue(list.contains(3))
        XCTAssertTrue(list.contains(5))
        XCTAssertFalse(list.contains(6))
        XCTAssertFalse(list.contains(0))
        XCTAssertFalse(list.contains(-1))
    }
    
    func testInsert() {
        let list = LinkedList(1, 3, 4, 5)
        list.insert(2, at: 1)
        
        XCTAssertEqual(2, list[1])
        XCTAssertEqual(5, list.count)
        
        list.insert(0, at: 0)
        
        XCTAssertEqual(0, list.first)
        XCTAssertEqual(6, list.count)
        
        list.insert(7, at: list.count)
        
        XCTAssertEqual(7, list.last)
        XCTAssertEqual(7, list.count)
        
        list.insert(8, at: 100)
        
        XCTAssertEqual(8, list.last)
        XCTAssertEqual(8, list.count)
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
