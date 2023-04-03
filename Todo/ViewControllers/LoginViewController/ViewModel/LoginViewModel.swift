//
//  LoginViewModel.swift
//  Todo
//
//  Created by Pratham Gupta on 27/03/23.
//

import Foundation

struct User : Codable
{
    let username: String
    let password: String
    let name: String
    let dob: Date
    let gender: String
    let phone: String
}
