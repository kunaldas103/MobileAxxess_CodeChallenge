//
//  JSONDisplayInteractor.swift
//  MobileAxxess_CodeChallenge
//
//  Created by Kunal Das on 26/09/20.
//  Copyright © 2020 Kunal Das. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

struct JSONDisplayInteractor: InteractorProtocol {
    var presenter: InteractorToPresenterProtocol?
    
    init(presenter: InteractorToPresenterProtocol) {
        self.presenter = presenter
    }
    
    func fetchJSONResponse() {
        if Connectivity.isConnectedToInternet {
            getResponse()
        } else {
            getOfflineData()
        }
    }
    
    private func getResponse() {
        AF.request(AXXESS_URL).response { (response) in
            if let data = response.data {
                do {
                    let array = try JSONDecoder().decode([ResponseArray].self, from: data)
                    self.saveDataOffine(array)
                    self.presenter?.jsonFetchedSuccess(responseArray: array)
                } catch {
                    self.presenter?.jsonFetchFailed()
                }
            } else if response.error != nil {
                self.presenter?.jsonFetchFailed()
            }
        }
    }
    
    private func getOfflineData() {
        do {
            let realm = try Realm()
            let offlineDataArray = realm.objects(DataOffline.self).toArray()
            let dataAvailable = returnArrayToDisplay(offlineDataArray)
            if dataAvailable.count > 0 {
                self.presenter?.jsonFetchedSuccess(responseArray: dataAvailable)
            } else {
                self.presenter?.jsonFetchFailed()
            }
        } catch {
             print("Error getting offline data from Realm : \(error)")
        }
    }
    
    private func saveDataOffine(_ arraydata: [ResponseArray]) {
        do {
            for data in arraydata {
                let container = try Container()
                try container.write { transaction in
                    transaction.add(data, update: .all)
                }
            }
        } catch {
            print("Error initialising Realm : \(error)")
        }
    }
    
    private func returnArrayToDisplay(_ arrayData: [DataOffline]) -> [ResponseArray] {
        var array = [ResponseArray]()
        for item in arrayData {
            let convertedItem = ResponseArray(id: item.id, type: item.type, date: item.date, data: item.data)
            array.append(convertedItem)
        }
        return array
    }
}
