//
//  SharedRepository.swift
//
//
//  Created by Lorenzo Fiamingo on 31/07/2020.
//

import Foundation

final class SharedRepository {
	
	private static var objects: [Int: Any] = [:]
	
	static func getObject<ObjectType>(for key: Int, defaultValue: ObjectType?) -> ObjectType {
		print(type(of: defaultValue))
		if objects[key] == nil {
			guard let defaultValue = defaultValue else {
				preconditionFailure("SharedObject Error: The object was called for the first time without being initialized")
			}
			objects[key] = defaultValue
		}
		guard let object = objects[key] as? ObjectType else {
			preconditionFailure("SharedObject Error: The id was already used by another class")
		}
		return object
	}
}
