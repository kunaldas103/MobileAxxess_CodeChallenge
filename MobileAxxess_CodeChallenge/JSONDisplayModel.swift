//
//  JSONDisplayModel.swift
//  MobileAxxess_CodeChallenge
//
//  Created by Kunal Das on 26/09/20.
//  Copyright © 2020 Kunal Das. All rights reserved.
//

import Foundation

struct ResponseArray: Codable {
    var id: String?
    var type: String?
    var date: String?
    var data: String?
}

extension ResponseArray: Persistable {
    public init(managedObject: DataOffline) {
        id = managedObject.id
        type = managedObject.type
        date = managedObject.date
        data = managedObject.data
    }
    
    public func managedObject() -> DataOffline {
        let offlineData = DataOffline()
        offlineData.id = id ?? ""
        offlineData.type = type ?? ""
        offlineData.date = date ?? ""
        offlineData.data = data ?? ""
        return offlineData
    }
    
    
}
