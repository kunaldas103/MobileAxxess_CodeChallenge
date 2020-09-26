//
//  JSONDisplayRouter.swift
//  MobileAxxess_CodeChallenge
//
//  Created by Kunal Das on 26/09/20.
//  Copyright © 2020 Kunal Das. All rights reserved.
//

import Foundation
import UIKit

struct JSONDisplayRouter: RouterProtocol {
    func pushToDetailScreen(navigationConroller: UINavigationController, data: ResponseArray) {
        let vc = DetailViewController()
        
        let presenter: DetailPresenterProtocol & DetailInteractorToPresenterProtocol = DisplayPresenter(view: vc)
        
        let interactor: DetailInteractorProtocol = DisplayInteractor(presenter: presenter)
        
        vc.dataToDisplay = data
        vc.presenter = presenter
        vc.presenter?.interactor = interactor
        vc.presenter?.interactor?.presenter = presenter
        
        navigationConroller.pushViewController(vc, animated: true)
    }
}
