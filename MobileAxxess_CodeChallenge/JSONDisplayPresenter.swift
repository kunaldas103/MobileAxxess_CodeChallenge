//
//  JSONDisplayPresenter.swift
//  MobileAxxess_CodeChallenge
//
//  Created by Kunal Das on 26/09/20.
//  Copyright © 2020 Kunal Das. All rights reserved.
//

import Foundation
import UIKit

struct JSONDisplayPresenter: PresenterProtocol {
    
    
    var view: ViewProtocol?
    var interactor: InteractorProtocol?
    var router: RouterProtocol?
    
    init(view: ViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func startFetchingJSONResponse() {
        interactor?.fetchJSONResponse()
    }
    
    func showDetailController(navigationController:UINavigationController, data: ResponseArray) {
        router?.pushToDetailScreen(navigationConroller: navigationController, data: data)
    }
}

extension JSONDisplayPresenter: InteractorToPresenterProtocol {
    func jsonFetchedSuccess(responseArray: [ResponseArray]) {
        view?.displayJSONFields(responseArray: responseArray)
    }
    
    func jsonFetchFailed() {
        view?.showError()
    }
}
