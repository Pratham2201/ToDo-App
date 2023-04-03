//
//  ViewController.swift
//  Todo
//
//  Created by Pratham Gupta on 28/02/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnLogIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    @IBOutlet weak var homeBackground: UIImageView!
    
    @IBAction func onClickLogIn(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LogInVC")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButtons(button: btnLogIn)
        setUpButtons(button: btnSignUp)
       
        homeBackground.layer.cornerRadius = 30
    }

    func setUpButtons(button: UIButton) {
        
        button.layer.cornerRadius = 10
        button.layer.borderColor = CGColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        button.layer.borderWidth = 1.0
        
    
        
    }
    
    func callAPI(completion: @escaping ([User]?, Error?) -> Void) {
        let urlString  = "https//google.com"
        guard let url = URL(string: urlString ) else {
            completion(nil, nil)
            return
        }
        let user = User(username: "prathamgupta@gmail.com", password: "Pratham123", name: "Pratham Gupta", dob: Date(), gender: "Male", phone: "1122334455")
        let parameters: [String: Any?] = [
            "username" : user.username,
            "password" : user.password
        ]
//        let parameters2: [String: String] = [
//            "username" : user.username,
//            "password" : user.password
//        ]
//        let _ = try? JSONEncoder().encode(parameters2)
        
        var urlRequest = URLRequest(url: url, timeoutInterval: Double.infinity)
        urlRequest.httpMethod = "POST"
        
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
           // self.btnSignUp.setTitle("", for: .normal)
//            if let httpResponse = response as? HTTPURLResponse {
//                httpResponse.statusCode
//            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
            do {
                let userData = try JSONDecoder().decode([User].self, from: data)
                completion(userData, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }

}

