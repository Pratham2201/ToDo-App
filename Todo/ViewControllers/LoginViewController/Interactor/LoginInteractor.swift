//
//  LoginInteractor.swift
//  Todo
//
//  Created by Pratham Gupta on 27/03/23.
//

import Foundation

protocol ILoginInteractor {
    
    func checkEmail(email: String)
    
    func checkPassword(password: String)
    
    func loadUsersFromFile()
    
    func checkLoggedInStatus()
    
    func checkForUsers(username: String, password: String, allUsers: [User])
}

final class LoginInteractor: ILoginInteractor {
    
    var worker: DataLoader?
    var output:  ILoginPresenter?
    
    func checkEmail(email: String) {
        output?.setEmailErrorValues(error: invalidEmail(email))
    }
    
    func checkPassword(password: String) {
        output?.setPasswordErrorValues(error: invalidPassword(password))
    }
    
    func loadUsersFromFile() {
        output?.sendUserData(worker?.loadAllUsers())
    }
    
    func checkLoggedInStatus() {
        if isUserLoggedIn() {
            output?.openLoginBottomTabBar()
        }
    }
    
    func invalidEmail(_ value: String) -> Bool {
        let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        if !predicate.evaluate(with: value) {
            return true
        }
        return false
    }
    
    func invalidPassword(_ value: String) -> String? {
        if value.count < 8 {
            return "Password must be at least 8 characters"
        }
        if containsDigit(value) {
            return "Password must contain at least 1 digit"
        }
        if containsLowerCase(value) {
            return "Password must contain at least 1 lowercase character"
        }
        if containsUpperCase(value) {
            return "Password must contain at least 1 uppercase character"
        }
        return nil
    }
    
    func containsDigit(_ value: String) -> Bool {
        let reqularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        print(predicate)
        return !predicate.evaluate(with: value)
    }
    
    func containsLowerCase(_ value: String) -> Bool {
        let reqularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsUpperCase(_ value: String) -> Bool {
        let reqularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isUserLoggedIn")
    }

    func checkForUsers(username: String, password: String, allUsers: [User]) {
        for user in allUsers {
            if(user.username == username && user.password == password) {
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.set(username, forKey: "loggedInUsername")
                output?.openLoginBottomTabBar()
            }
            else {
                output?.setValueForAlertBox()
            }
        }
    }
    
}
