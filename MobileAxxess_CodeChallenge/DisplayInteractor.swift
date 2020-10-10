//
//  DisplayInteractor.swift
//  MobileAxxess_CodeChallenge
//
//  Created by Kunal Das on 26/09/20.
//  Copyright © 2020 Kunal Das. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

struct DisplayInteractor: DetailInteractorProtocol {
    
    
    var presenter: DetailInteractorToPresenterProtocol?
    
    init(presenter: DetailInteractorToPresenterProtocol) {
        self.presenter = presenter
    }
    
    private func saveImageData(data: Data, url: String) {
        do {
           let realm = try Realm()
                let imageOffline = ImageOffline()
                imageOffline.imageUrl = url
                imageOffline.photoData = data
                try  realm.write {
                    realm.add(imageOffline, update: .all)
                }
        } catch {
            print("Error initialising Realm : \(error)")
        }
    }
    
    private func getOfflineImageData(for url: String) {
        do {
            let realm = try Realm()
            let offlineImage = realm.object(ofType: ImageOffline.self, forPrimaryKey: url)
            if let data = offlineImage?.photoData {
                self.presenter?.imageFetchedSuccess(imageData: data)
            } else {
                self.presenter?.imageFetchFailed()
            }
            
           
        } catch {
             print("Error getting offline image from Realm : \(error)")
        }
    }
    
    private func getImageData(imageUrl: String) {
        AF.request(imageUrl).responseData { (response) in
            if let imgData = response.data {
                self.presenter?.imageFetchedSuccess(imageData: imgData)
                self.saveImageData(data: imgData, url: imageUrl)
            } else if response.error != nil {
                self.presenter?.imageFetchFailed()
            }
        }
    }
    
    func fetchImageData(imageUrl: String) {
        if Connectivity.isConnectedToInternet {
            getImageData(imageUrl: imageUrl)
        } else {
            getOfflineImageData(for: imageUrl)
        }
    }
}
