//
//  RealmOfflineData.swift
//  MobileAxxess_CodeChallenge
//
//  Created by Kunal Das on 10/10/20.
//  Copyright © 2020 Kunal Das. All rights reserved.
//

import Foundation
import RealmSwift

class DataOffline: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var data: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class ImageOffline: Object {
    @objc dynamic var imageUrl: String = ""
    @objc dynamic var photoData: Data? = Data()
    
    override static func primaryKey() -> String? {
           return "imageUrl"
    }
}

public protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}

public final class WriteTransaction {
    private let realm: Realm
    internal init(realm: Realm) {
        self.realm = realm
    }
    
    public func add<T: Persistable>(_ value: T, update: Realm.UpdatePolicy) {
        realm.add(value.managedObject(), update: update)
    }
}

// Implement the Container
public final class Container {
    private let realm: Realm
    public convenience init() throws {
        try self.init(realm: Realm())
    }
    internal init(realm: Realm) {
        self.realm = realm
    }
    public func write(_ block: (WriteTransaction) throws -> Void)
    throws {
        let transaction = WriteTransaction(realm: realm)
        try realm.write {
            try block(transaction)
        }
    }
}

extension Results {
   func toArray() -> [Element] {
     return compactMap {
       $0
     }
   }
}

