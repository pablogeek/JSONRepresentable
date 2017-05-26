//
//  JSONRepresentable.swift
//  IrisConnect
//
//  Created by Pablo Martinez on 30/03/2017.
//  Copyright © 2017 Iris Connect. All rights reserved.
//

import Foundation

protocol OptionalProtocol {
    func wrappedType() -> Any.Type
    func unwrap() -> Any
}

extension Optional: OptionalProtocol{
    func wrappedType() -> Any.Type {
        return Wrapped.self
    }
    
    func unwrap() -> Any {
        
        let mi = Mirror(reflecting: self as Any)
        
        if mi.displayStyle != .optional {
            return self as Any
        }
        if mi.children.count == 0 { return NSNull() }
        let (_, some) = mi.children.first!
        return some
        
    }
}

protocol JSONRepresentable {
    var JSONRepresentation: Any { get }
}

protocol JSONSerializable: JSONRepresentable {
}

extension JSONSerializable {
    var JSONRepresentation: Any {
        return valueMirror(v: self) as Any
    }
    
    func valueMirror(v: Any) -> [String: Any]{
        var representation = [String: Any]()
        for case let (label?, value) in Mirror(reflecting: v).children {
            switch value {
            case let value as JSONRepresentable:
                representation[label] = value.JSONRepresentation
                break
            case let value as NSObject:
                representation[label] = value
                break
            case let value as OptionalProtocol:
                let unwrappedVal = value.unwrap()
                if unwrappedVal is NSNull{
                    break
                }else{
                    representation[label] = valueMirror(v: unwrappedVal)
                }
                break
            default:
                representation[label] = valueMirror(v: value)
                break
            }
        }
        return representation
    }
    
    func toJSON() -> (Data?,String?) {
        let representation = JSONRepresentation
        
        guard JSONSerialization.isValidJSONObject(representation) else {
            return (nil,nil)
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: representation, options: [])
            return (data,String(data: data, encoding: String.Encoding.utf8))
        } catch {
            return (nil,nil)
        }
    }
}
