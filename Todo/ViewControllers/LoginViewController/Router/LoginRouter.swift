//
//  LoginRouter.swift
//  Todo
//
//  Created by Pratham Gupta on 27/03/23.
//

import Foundation
import UIKit

protocol ILoginRouter {
    
    func setRootViewController()
}

class LoginRouter: ILoginRouter {
    
    weak var viewController : LogInVC?
    
    func setRootViewController() {
        (UIApplication.shared.delegate as? AppDelegate)?.addBottomTabBarViewController()
    }
}
