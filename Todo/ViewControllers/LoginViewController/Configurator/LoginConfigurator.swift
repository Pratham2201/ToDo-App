//
//  LoginConfigurator.swift
//  Todo
//
//  Created by Pratham Gupta on 27/03/23.
//

import Foundation

struct LoginConfigurator {
    
    static func configure(viewController: LogInVC) {
        
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        
        let worker = LoginWorker()
        let router = LoginRouter()
        
        presenter.output = viewController
        
        interactor.output = presenter
        interactor.worker = worker
        
        router.viewController = viewController
        
        viewController.output = interactor
        viewController.router = router
    }
}
