//
//  SharableObject.swift
//
//
//  Created by Lorenzo Fiamingo on 31/07/2020.
//

import Foundation

/// A type of object that can provide a common initial value.
@available(watchOS 6.0, tvOS 13.0, iOS 13.0, OSX 10.15, *)
public protocol SharableObject: ObservableObject {
	
	static var initialValue: Self { get }
}
