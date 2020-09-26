//
//  JSONDisplayFactory.swift
//  MobileAxxess_CodeChallenge
//
//  Created by Kunal Das on 26/09/20.
//  Copyright © 2020 Kunal Das. All rights reserved.
//

import Foundation
import UIKit

struct JSONDisplayFactory {
    
    static func createModule() -> JSONDisplayViewController {
        
        let view = JSONDisplayViewController()
        let router: RouterProtocol = JSONDisplayRouter()
        let presenter: PresenterProtocol & InteractorToPresenterProtocol = JSONDisplayPresenter(view: view, router: router)
        
        let interactor: InteractorProtocol = JSONDisplayInteractor(presenter: presenter)
        
        
        view.presenter = presenter
        view.presenter?.interactor = interactor
        view.presenter?.router = router
        view.presenter?.interactor?.presenter = presenter
        
        return view
    }
    
}
