//
//  DisplayPresenter.swift
//  MobileAxxess_CodeChallenge
//
//  Created by Kunal Das on 26/09/20.
//  Copyright © 2020 Kunal Das. All rights reserved.
//

import Foundation

struct DisplayPresenter: DetailPresenterProtocol {
    
    
    var view: DetailViewProtocol?
    var interactor: DetailInteractorProtocol?
    
    init(view: DetailViewProtocol) {
        self.view = view
    }
    
    func startFetchingImageData(imageUrl: String) {
        interactor?.fetchImageData(imageUrl: imageUrl)
    }
}

extension DisplayPresenter: DetailInteractorToPresenterProtocol {
   
    func imageFetchFailed() {
         view?.showError()
    }
    
    func imageFetchedSuccess(imageData: Data) {
        view?.displayImage(imageData: imageData)
    }
}
