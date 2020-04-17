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
    
    public class Node {
        
        fileprivate var value: Element
        fileprivate var nextNode: Node?
        fileprivate var previousNode: Node?
        
        fileprivate init(_ value: Element) {
            self.value = value
        }
    }
    
    fileprivate var firstNode: Node?
    fileprivate var lastNode: Node?
}

extension LinkedList {
    
    func append(_ element: Element) {
        let node = Node(element)
        
        if let lastNode = lastNode {
            lastNode.nextNode = node
            node.previousNode = lastNode
        }
        
        if count == 0 {
            firstNode = node
        }
        
        count += 1
        lastNode = node
    }
    
    subscript(index: Int) -> Element {
        get {
            getNode(at: index).value
        }
        set(newValue) {
            getNode(at: index).value = newValue
        }
    }
    
    fileprivate func getNode(at index: Int) -> Node {
        _precondition(index >= 0 && index < count, "Index out of bounds")
    
        var node: Node!
        var i = 0
        
        if index <= count / 2 {
            node = firstNode
            while i < index { node = node.nextNode!; i += 1 }
        }
        else {
            node = lastNode
            i = count - 1
            while i > index { node = node.previousNode!; i -= 1 }
        }
        return node
    }
}

