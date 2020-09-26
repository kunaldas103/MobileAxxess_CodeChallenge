//
//  JSONDisplayInteractor.swift
//  MobileAxxess_CodeChallenge
//
//  Created by Kunal Das on 26/09/20.
//  Copyright © 2020 Kunal Das. All rights reserved.
//

import Foundation
import Alamofire

struct JSONDisplayInteractor: InteractorProtocol {
    var presenter: InteractorToPresenterProtocol?
    
    init(presenter: InteractorToPresenterProtocol) {
        self.presenter = presenter
    }
    
    func fetchJSONResponse() {
        AF.request(AXXESS_URL).response { (response) in
            if let data = response.data {
                do {
                    let array = try JSONDecoder().decode([ResponseArray].self, from: data)
                    self.presenter?.jsonFetchedSuccess(responseArray: array)
                } catch {
                    self.presenter?.jsonFetchFailed()
                }
                
            } else if response.error != nil {
                self.presenter?.jsonFetchFailed()
            }
        }
    }
}
