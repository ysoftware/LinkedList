//
//  LinkedList.swift
//  LinkedList
//
//  Created by Ерохин Ярослав Игоревич on 17.04.2020.
//  Copyright © 2020 Ерохин Ярослав Игоревич. All rights reserved.
//

import Foundation

public class LinkedList<Element> {
    
    public var count: Int = 0
    
    public class Node: CustomDebugStringConvertible {
        
        fileprivate var value: Element
        fileprivate var nextNode: Node?
        fileprivate var previousNode: Node?
        
        fileprivate init(_ value: Element) {
            self.value = value
        }
        
        public var debugDescription: String {
            "Node: prev: \(previousNode != nil), next: \(nextNode != nil), value: \"\(value)\""
        }
    }
    
    fileprivate var firstNode: Node?
    fileprivate var lastNode: Node?
}

extension LinkedList: CustomDebugStringConvertible {
    
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
    
    subscript(index: Int) -> Element {
        get {
            getNode(at: index).value
        }
        set(newValue) {
            getNode(at: index).value = newValue
        }
    }
    
    public var debugDescription: String {
        let describe: (Node?)->String = { $0.map(String.init(describing:)).map { "(\($0))" } ?? "nil" }
        return "List: count: \(count), first: \(describe(firstNode)), last: \(describe(lastNode))"
    }
    
    // MARK: - Private
    
    fileprivate func getNode(at index: Int) -> Node {
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
}

