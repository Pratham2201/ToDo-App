//
//  LoginPresenter.swift
//  Todo
//
//  Created by Pratham Gupta on 27/03/23.
//

import Foundation
import UIKit

protocol ILoginPresenter {
    
    func sendUserData(_ value: [User]?)

    func setEmailErrorValues(error: Bool)
    
    func setPasswordErrorValues(error: String?)
    
    func openLoginBottomTabBar()
    
    func setValueForAlertBox()
    
    func checkForValidForm(isHidden: Bool)
    
}

final class LoginPresenter: ILoginPresenter {
    
    weak var output: LogInVC?
    
    func sendUserData(_ value: [User]?) {
        output?.loadDataToAllUsers(data: value)
    }
    
    func setEmailErrorValues(error: Bool) {
        if error {
            output?.updateEmailChanges(isHidden: false, backgroundColor: UIColor.red.cgColor)
        }
        else {
            output?.updateEmailChanges(isHidden: true, backgroundColor: UIColor.black.cgColor)
        }
        checkForValidForm(isHidden: !error)
    }
    
    func setPasswordErrorValues(error: String?) {
        if let value = error {
            output?.updatePasswordChanges(isHidden: false, backgroundColor: UIColor.red.cgColor, errorMsg: value)
        }
        else {
            output?.updatePasswordChanges(isHidden: true, backgroundColor: UIColor.black.cgColor, errorMsg: error)
        }
        checkForValidForm(isHidden: error == nil ? true : false)
    }
    
    func checkForValidForm(isHidden: Bool) {
        if isHidden {
            output?.updateLoginButtonState(isEnabled: true, backgroundColor: .systemGreen)
        }
        else {
            output?.updateLoginButtonState(isEnabled: false, backgroundColor: UIColor(named: "invalid_button_white"))
        }
    }
    
    func openLoginBottomTabBar() {
        output?.routeToTaskHomeScreen()
    }
    
    func setValueForAlertBox() {
        output?.setUpAlertBox(title: "Wrong Credentials!", msg: "Please try again.", alertStyle: UIAlertController.Style.alert)
    }
}
