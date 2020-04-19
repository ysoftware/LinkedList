//
//  LinkedList.swift
//  LinkedList
//
//  Created by Ерохин Ярослав Игоревич on 17.04.2020.
//  Copyright © 2020 Ерохин Ярослав Игоревич. All rights reserved.
//

import Foundation

public class LinkedList<Element> {
    
    public class Node: CustomDebugStringConvertible {
        
        public fileprivate(set) var value: Element
        public fileprivate(set) var nextNode: Node?
        public fileprivate(set) var previousNode: Node?
        
        fileprivate init(_ value: Element) {
            self.value = value
        }
        
        public var debugDescription: String {
            "Node: prev: \(previousNode != nil), next: \(nextNode != nil), value: \"\(value)\""
        }
    }
    
    public private(set) var count: Int = 0
    public private(set) var firstNode: Node?
    public private(set) var lastNode: Node?
    
    // MARK: - Initialization
    
    public init(_ elements: Element...) {
        elements.forEach(append)
    }
}

extension LinkedList: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        let describe: (Node?)->String = { $0.map(String.init(describing:)).map { "(\($0))" } ?? "nil" }
        return "List: count: \(count), first: \(describe(firstNode)), last: \(describe(lastNode))"
    }
}

public extension LinkedList {
    
    func clear() {
        firstNode = nil
        lastNode = nil
        count = 0
    }
    
    func remove(at index: Int) {
        precondition(index >= 0 && index < count, "Index out of bounds")
        remove(node: node(at: index)!)
    }
    
    func remove(node: Node) {
        node.previousNode?.nextNode = node.nextNode
        node.nextNode?.previousNode = node.previousNode
        count -= 1
        
        if firstNode === node {
            firstNode = node.nextNode
        }
        else if lastNode === node {
            lastNode = node.previousNode
        }
    }
    
    func append(_ element: Element) {
        let node = Node(element)
        
        if let lastNode = lastNode {
            lastNode.nextNode = node
            node.previousNode = lastNode
        }
        
        if count == 0 { firstNode = node }
        count += 1
        lastNode = node
    }
    
    func insert(_ value: Element, at index: Int) {
        if index >= count || index <= 0 && count == 0 { // new last node
            append(value)
        }
        else if index <= 0 { // new first node
            let newNode = Node(value)
            firstNode?.previousNode = newNode
            newNode.nextNode = firstNode
            firstNode = newNode
            count += 1
        }
        else { // new node somewhere in the middle
            let newNode = Node(value)
            let currentNode = node(at: index)!
            let previousNode = currentNode.previousNode
            
            newNode.nextNode = currentNode
            newNode.previousNode = previousNode
            
            previousNode?.nextNode = newNode
            currentNode.previousNode = newNode
            count += 1
        }
    }
    
    func reverse() {
        var node: Node! = firstNode
        repeat {
            let _previousNode = node.previousNode
            node.previousNode = node.nextNode
            node.nextNode = _previousNode
            
            node = node.previousNode
        } while node != nil
        
        let _firstNode = firstNode
        firstNode = lastNode
        lastNode = _firstNode
    }
    
    subscript(index: Int) -> Element {
        get {
            precondition(index >= 0 && index < count, "Index out of bounds")
            return node(at: index)!.value
        }
        set(newValue) {
            precondition(index >= 0 && index < count, "Index out of bounds")
            node(at: index)!.value = newValue
        }
    }
    
    func node(at index: Int) -> Node? {
        var node: Node?
        if index <= count / 2 {
            var i = 0
            node = firstNode
            while i < index { node = node?.nextNode!; i += 1 }
        }
        else {
            node = lastNode
            var i = count - 1
            while i > index { node = node?.previousNode!; i -= 1 }
        }
        return node
    }
    
    func dropFirst(_ k: Int = 1) {
        guard count > 0 else { return }
        guard k < count else { return clear() }
        
        var node = firstNode
        for _ in 0..<k {
            node = node?.nextNode
        }
        
        node?.previousNode = nil
        firstNode = node
        count -= k
    }
    
    func dropLast(_ k: Int = 1) {
        guard count > 0 else { return }
        guard k < count else { return clear() }

        var node = lastNode
        for _ in 0..<k {
            node = node?.previousNode
        }
        
        node?.nextNode = nil
        lastNode = node
        count -= k
    }
    
    func map<T>(_ transform: (Element) throws -> T) rethrows -> [T] {
        var result = [T]()
        try forEach { result.append(try transform($0)) }
        return result
    }
    
    func mapLinked<T>(_ transform: (Element) throws -> T) rethrows -> LinkedList<T> {
        let newList = LinkedList<T>()
        try forEach {
            newList.append(try transform($0))
        }
        return newList
    }
    
    func filterLinked(_ isIncluded: (Element) throws -> Bool) rethrows -> LinkedList<Element> {
        let newList = LinkedList<Element>()
        try forEach {
            if try isIncluded($0) {
                newList.append($0)
            }
        }
        return newList
    }
    
    var first: Element? { firstNode?.value }
    
    var last: Element? { lastNode?.value }
}

extension LinkedList: Sequence {
    
    public class LinkedListIterator: IteratorProtocol {
        
        public typealias Element = LinkedListElement
        fileprivate var node: LinkedList.Node?
        
        public func next() -> Element? {
            let value = node?.value
            node = node?.nextNode
            return value
        }
        
        fileprivate init(firstNode: LinkedList.Node?) {
            self.node = firstNode
        }
    }
    
    public typealias LinkedListElement = Element

    public func makeIterator() -> LinkedListIterator {
        LinkedListIterator(firstNode: firstNode)
    }
}

extension LinkedList: Collection {
    
    public func index(after i: Int) -> Int { i + 1 }
    public var startIndex: Int { 0 }
    public var endIndex: Int { count - 1 }
}
