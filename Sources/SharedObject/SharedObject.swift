//
//  SharedObject.swift
//
//
//  Created by Lorenzo Fiamingo on 31/07/2020.
//

import SwiftUI
import Combine

/// A property wrapper type for an observable object supplied with an id or created at the moment.
@available(watchOS 6.0, tvOS 13.0, iOS 13.0, OSX 10.15, *)
@propertyWrapper
public struct SharedObject<ObjectType, ID>: DynamicProperty where ObjectType: ObservableObject, ID: Hashable {
	
	@ObservedObject private var object: Object<ObjectType>
	
	/// The underlying value referenced by the shared object.
	public var wrappedValue: ObjectType {
		get { object.object }
		nonmutating set { object.object = newValue }
	}
	
	/// A projection of the shared object that creates bindings to its properties using dynamic member lookup.
	public var projectedValue: SharedObject.Wrapper {
		.init(object.object)
	}
	
	/// Retrieves the shared object with the given id or creates a shared object with an initial wrapped value.
	public init(wrappedValue: ObjectType, _ id: ID) {
		object = .init(wrappedValue: wrappedValue, id: id)
	}
	
	/// Retrieves the shared object with the given id.
	public init(_ id: ID) {
		object = .init(wrappedValue: nil, id: id)
	}
	
	/// Retrieves the shared object with the given id or creates a shared object with an initial wrapped value provided by the object class.
	public init(_ id: ID) where ObjectType: SharableObject {
		object = .init(wrappedValue: ObjectType.initialValue, id: id)
	}
	
	private final class Object<ObjectType: ObservableObject>: ObservableObject {
		
		private var cancellable: AnyCancellable?
		
		var object: ObjectType { didSet { subscribe() } }
		
		init(wrappedValue: ObjectType?, id: ID) {
			object = SharedRepository.getObject(for: id.hashValue, defaultValue: wrappedValue)
			subscribe()
		}
		
		private func subscribe() {
			cancellable = object.objectWillChange.sink { [unowned self] _ in
				self.objectWillChange.send()
			}
		}
	}
	
	/// A wrapper of the underlying observable object that can create bindings to its properties using dynamic member lookup.
	@dynamicMemberLookup
	public struct Wrapper {
		
		private let object: ObjectType
		
		init(_ object: ObjectType) {
			self.object = object
		}
		
		subscript<Subject>(dynamicMember keyPath: ReferenceWritableKeyPath<ObjectType, Subject>) -> Binding<Subject> {
			.init {
				object[keyPath: keyPath]
			} set: { newValue in
				object[keyPath: keyPath] = newValue
			}
		}
	}
}
