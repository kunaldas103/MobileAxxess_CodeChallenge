//
//  DisplayInteractor.swift
//  MobileAxxess_CodeChallenge
//
//  Created by Kunal Das on 26/09/20.
//  Copyright © 2020 Kunal Das. All rights reserved.
//

import Foundation
import Alamofire

struct DisplayInteractor: DetailInteractorProtocol {
    
    
    var presenter: DetailInteractorToPresenterProtocol?
    
    init(presenter: DetailInteractorToPresenterProtocol) {
        self.presenter = presenter
    }
    
    func fetchImageData(imageUrl: String) {
        AF.request(imageUrl).responseData { (response) in
            if let imgData = response.data {
                self.presenter?.imageFetchedSuccess(imageData: imgData)
            } else if response.error != nil {
                self.presenter?.imageFetchFailed()
            }
        }
    }
}
