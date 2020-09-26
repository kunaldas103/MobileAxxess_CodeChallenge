//
//  JSONDisplayProtocol.swift
//  MobileAxxess_CodeChallenge
//
//  Created by Kunal Das on 26/09/20.
//  Copyright © 2020 Kunal Das. All rights reserved.
//

import Foundation
import UIKit

protocol PresenterProtocol {
    var view: ViewProtocol? {get set}
    var interactor: InteractorProtocol? {get set}
    var router: RouterProtocol? {get set}
    func startFetchingJSONResponse()
    func showDetailController(navigationController:UINavigationController, data: ResponseArray)
}

protocol ViewProtocol {
    func displayJSONFields(responseArray: [ResponseArray])
    func showError()
}

protocol RouterProtocol {
    func pushToDetailScreen(navigationConroller:UINavigationController, data: ResponseArray)
}

protocol InteractorProtocol {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchJSONResponse()
}

protocol InteractorToPresenterProtocol {
    func jsonFetchedSuccess(responseArray: [ResponseArray])
    func jsonFetchFailed()
}

protocol DetailPresenterProtocol {
    var view: DetailViewProtocol? {get set}
    var interactor: DetailInteractorProtocol? {get set}
    func startFetchingImageData(imageUrl: String)
}

protocol DetailViewProtocol {
    func displayImage(imageData: Data)
    func showError()
}

protocol DetailInteractorProtocol {
    var presenter: DetailInteractorToPresenterProtocol? {get set}
    func fetchImageData(imageUrl: String)
}

protocol DetailInteractorToPresenterProtocol {
    func imageFetchedSuccess(imageData: Data)
    func imageFetchFailed()
}
