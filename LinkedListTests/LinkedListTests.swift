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
        let list: LinkedList = ["Hello", ",", " ", "World"]
        print(list)
        
        XCTAssertEqual("Hello", list[0])
        XCTAssertEqual(",",     list[1])
        XCTAssertEqual(" ",     list[2])
        XCTAssertEqual("World", list[3])
        XCTAssertEqual(4, list.count)
    }
    
    func testSubscriptOutOfBounds() {
        let list: LinkedList = ["Hello", ",", " ", "World"]
        
        expectingPreconditionFailure(LinkedListIndexError) { _ = list[4] }
        expectingPreconditionFailure(LinkedListIndexError) { _ = list[-1] }
        expectingPreconditionFailure(LinkedListIndexError) { list[5] = "" }
    }
    
    func testAppend() {
        let list = LinkedList<Int>()
        list.append(0)
        list.append(1)
        
        XCTAssertEqual(0, list[0])
        XCTAssertEqual(1, list[1])
        
        XCTAssertEqual(2, list.count)
        assertLinked(list)
    }
    
    func testPrepend() {
        let list = LinkedList<Int>()
        list.prepend(1)
        list.prepend(0)
        
        XCTAssertEqual(0, list[0])
        XCTAssertEqual(1, list[1])
        
        XCTAssertEqual(2, list.count)
        assertLinked(list)
    }
    
    func testReverse() {
        let list: LinkedList = [3, 2, 1, 0]
        list.reverse()
        
        XCTAssertEqual(0, list[0])
        XCTAssertEqual(1, list[1])
        XCTAssertEqual(2, list[2])
        XCTAssertEqual(3, list[3])
        
        XCTAssertEqual(4, list.count)
        assertLinked(list)
    }
    
    func testSubscriptSet() {
        let list: LinkedList = ["Hello", ",", " ", "World"]
        list[3] = "Sailor"
        
        XCTAssertEqual("Sailor", list[3])
        XCTAssertEqual(4, list.count)
        assertLinked(list)
    }
    
    func testSequence() {
        let list: LinkedList = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        let sum = list.reduce(0, +)
        
        XCTAssertEqual(45, sum)
        assertLinked(list)
    }
    
    func testSequenceGet() {
        let list: LinkedList = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        
        XCTAssertEqual(list.first, 1)
        assertLinked(list)
    }
    
    func testDropFirst() {
        let list: LinkedList = [1, 2, 3, 4, 5, 6]
        list.dropFirst()
        
        XCTAssertEqual(2, list.first)
        XCTAssertEqual(5, list.count)
        assertLinked(list)
        
        list.dropFirst(2)
        
        XCTAssertEqual(4, list.first)
        XCTAssertEqual(3, list.count)
        assertLinked(list)
        
        // drop exactly all the remaining
        list.dropFirst(3)
        XCTAssertNil(list.first)
        XCTAssert(list.isEmpty)
        
        // check drop more than count
        let list2: LinkedList = [1, 2, 3, 4, 5, 6]
        list2.dropFirst(1000)
        XCTAssertNil(list.first)
        XCTAssert(list.isEmpty)
        
        list2.dropFirst()
        print(list2)
        
        XCTAssert(list2.isEmpty)
    }
    
    func testDropLast() {
        let list: LinkedList = [1, 2, 3, 4, 5, 6]
        list.dropLast()
        
        XCTAssertEqual(5, list.last)
        XCTAssertEqual(5, list.count)
        assertLinked(list)
        
        list.dropLast(2)
        
        XCTAssertEqual(3, list.last)
        XCTAssertEqual(3, list.count)
        assertLinked(list)
        
        // drop exactly all the remaining
        list.dropLast(3)
        XCTAssertNil(list.first)
        XCTAssert(list.isEmpty)
        
        // check drop more than count
        let list2: LinkedList = [1, 2, 3, 4, 5, 6]
        list2.dropLast(1000)
        XCTAssertNil(list.first)
        XCTAssert(list.isEmpty)
        
        list2.dropLast()
    }
    
    func testRemove() {
        let list: LinkedList = ["Hello", ",", " ", "World"]
        list.remove(at: 1)
        
        XCTAssertEqual("Hello", list[0])
        XCTAssertEqual(" ",     list[1])
        XCTAssertEqual("World", list[2])
        XCTAssertEqual(3, list.count)
        assertLinked(list)
    }
    
    func testRemoveAtIndex() {
        let list: LinkedList = ["Hello", ",", " ", "World"]
        list.remove(at: 1)
        
        XCTAssertEqual("Hello", list[0])
        XCTAssertEqual(" ",     list[1])
        XCTAssertEqual("World", list[2])
        XCTAssertEqual(3, list.count)
        assertLinked(list)
    }
    
    func testRemoveFirst() {
        let list: LinkedList = [1, 2, 3, 4, 5]
        let secondNode = list.node(at: 1)
        list.remove(at: 0)
        
        XCTAssertEqual(4, list.count)
        XCTAssert(list.firstNode === secondNode)
        assertLinked(list)
    }
    
    func testRemoveLast() {
        let list: LinkedList = [1, 2, 3, 4, 5]
        let secondToLastNode = list.node(at: list.count-2)
        list.remove(at: list.count-1)
        
        XCTAssertEqual(4, list.count)
        XCTAssert(list.lastNode === secondToLastNode)
        assertLinked(list)
    }
    
    func testContains() {
        let list: LinkedList = [1, 2, 3, 4, 5]
        
        XCTAssertTrue(list.contains(1))
        XCTAssertTrue(list.contains(3))
        XCTAssertTrue(list.contains(5))
        XCTAssertFalse(list.contains(6))
        XCTAssertFalse(list.contains(0))
        XCTAssertFalse(list.contains(-1))
        assertLinked(list)
    }
    
    func testInsert() {
        let list: LinkedList = [1, 3, 4, 5]
        list.insert(2, at: 1)
        
        XCTAssertEqual(2, list[1])
        XCTAssertEqual(5, list.count)
        assertLinked(list)
        
        list.insert(0, at: 0)
        
        XCTAssertEqual(0, list.first)
        XCTAssertEqual(6, list.count)
        assertLinked(list)
        
        list.insert(6, at: list.count)
        
        XCTAssertEqual(6, list.last)
        XCTAssertEqual(7, list.count)
        assertLinked(list)
        
        list.insert(7, at: 100)
        
        XCTAssertEqual(7, list.last)
        XCTAssertEqual(8, list.count)
        assertLinked(list)
        
        let sum = list.reduce(0, +)
        
        XCTAssertEqual(28, sum)
        assertLinked(list)
    }
    
    func testMap() {
        let list: LinkedList = [1, 2, 3, 4, 5]
        
        let list2 = list.mapLinked { $0 * 2 }
        let listSum = list2.reduce(0, +)
        XCTAssertEqual(30, listSum)
        assertLinked(list2)
        
        let array = list.map { $0 * 2 }
        let arraySum = array.reduce(0, +)
        XCTAssertEqual(30, arraySum)
    }
    
    func testFilter() {
        let list = LinkedList(withArray: [1, 2, 3, 4, 5, 6, 7, 8, 9])
        
        let list2 = list.filterLinked { $0 > 5 }
        XCTAssertEqual(4, list2.count)
        assertLinked(list2)
        
        let array = list.filter { $0 > 5 }
        XCTAssertEqual(4, array.count)
    }
    
    func testSlice() {
        let list: LinkedList = [1, 2, 3, 4, 5]
        let slice = list[..<2]
        
        XCTAssertEqual(2, slice.count)
        
        let sublist = LinkedList(slice)
        XCTAssertEqual(2, sublist.count)
        assertLinked(sublist)
    }
    
    func assertLinked<T>(_ list: LinkedList<T>) {
        guard list.count > 0 else { return }
        
        func check(_ node: LinkedList<T>.Node) {
            if node !== list.firstNode {
                XCTAssertNotNil(node.previousNode)
            }
            if node !== list.lastNode {
                XCTAssertNotNil(node.nextNode)
            }
        }
        
        var node = list.firstNode!
        var count = 0
        while true {
            check(node)
            count += 1
            guard let nextNode = node.nextNode else { break }
            node = nextNode
        }
        XCTAssertEqual(list.count, count)
        
        node = list.lastNode!
        count = 0
        while true {
            check(node)
            count += 1
            guard let nextNode = node.previousNode else { break }
            node = nextNode
        }
        XCTAssertEqual(list.count, count)
    }
}
