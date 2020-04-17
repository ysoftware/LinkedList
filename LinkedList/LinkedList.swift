//
//  LinkedList.swift
//  LinkedList
//
//  Created by Ерохин Ярослав Игоревич on 17.04.2020.
//  Copyright © 2020 Ерохин Ярослав Игоревич. All rights reserved.
//

import Foundation

final public class LinkedList<Element> {
    
    public var count: Int = 0
    
    public class Node: CustomDebugStringConvertible {
        
        public var value: Element
        public fileprivate(set) var nextNode: Node?
        public fileprivate(set) var previousNode: Node?
        
        fileprivate init(_ value: Element) {
            self.value = value
        }
        
        public var debugDescription: String {
            "Node: prev: \(previousNode != nil), next: \(nextNode != nil), value: \"\(value)\""
        }
    }
    
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
    
    func removeElement(at index: Int) {
        precondition(index >= 0 && index < count, "Index out of bounds")
        remove(node: node(at: index))
    }
    
    func remove(node: Node) {
        // TODO: check if it's in this list or move method to Node
        
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
    
    func reverse() {
        var node: Node! = firstNode
        while node != nil {
            let _previousNode = node.previousNode
            node.previousNode = node.nextNode
            node.nextNode = _previousNode
            
            node = node.previousNode
        }
        
        let _firstNode = firstNode
        firstNode = lastNode
        lastNode = _firstNode
    }
    
    func copy() -> LinkedList<Element> {
        let newList = LinkedList<Element>()
        forEach { newList.append($0) }
        return newList
    }
    
    subscript(index: Int) -> Element {
        get {
            node(at: index).value
        }
        set(newValue) {
            node(at: index).value = newValue
        }
    }
    
    var last: Element? { lastNode?.value }
    
    func node(at index: Int) -> Node {
        precondition(index >= 0 && index < count, "Index out of bounds")
    
        var node: Node!
        if index <= count / 2 {
            var i = 0
            node = firstNode
            while i < index { node = node.nextNode!; i += 1 }
        }
        else {
            node = lastNode
            var i = count - 1
            while i > index { node = node.previousNode!; i -= 1 }
        }
        return node
    }
    
    func dropFirst(_ k: Int = 1) {
        for _ in 0..<k {
            removeElement(at: 0)
        }
    }
    
    func dropLast(_ k: Int = 1) {
        for _ in 0..<k {
            removeElement(at: count-1)
        }
    }
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
