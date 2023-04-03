//
//  LogInVC.swift
//  Todo
//
//  Created by Pratham Gupta on 01/03/23.
//

import UIKit

class LogInVC: UIViewController, UITextFieldDelegate {
    
    
    var output: ILoginInteractor?
    var router: ILoginRouter?
    
    @IBOutlet weak var btnLogIn: UIButton!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var icGoogle: UIImageView!
    @IBOutlet weak var icFacebook: UIImageView!
    @IBOutlet weak var curvedView: UIView!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lblErrorUsername: UILabel!
    @IBOutlet weak var lblErrorPassword: UILabel!
    
    let borderUsername = CALayer()
    let borderPassword = CALayer()
    
    var allUsers: [User] = []
    
    // MARK: - Object Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.checkLoggedInStatus()
        setUpView()
    }
    
    func setUpView() {
        btnLogIn.layer.cornerRadius = 10
        curvedView.layer.cornerRadius = 50
        
        tfUsername.delegate = self
        tfPassword.delegate = self
        
        setUpBorder(border: borderUsername, textField: tfUsername)
        setUpBorder(border: borderPassword, textField: tfPassword)
        
        setUpSocialMediaWebView(#selector(self.facebookImageTapped), iconMedia: icGoogle)
        setUpSocialMediaWebView(#selector(self.googleImageTapped), iconMedia: icFacebook)
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
        loadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
        loadData()
    }
    
    func configure() {
        LoginConfigurator.configure(viewController: self)
    }
    
    func loadData() {
        output?.loadUsersFromFile()
    }
    
    func loadDataToAllUsers(data: [User]?) {
        allUsers = data ?? []
    }
    
    // MARK: - Tap and Click Gestures
    @objc func facebookImageTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            present(getUIViewControllerFromID("FacebookWebViewController"), animated: true, completion: nil)
        }
    }
    
    @objc func googleImageTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            present(getUIViewControllerFromID("GoogleWebViewController"), animated: true, completion: nil)
        }
    }
    
    @IBAction func onClickLogIn(_ sender: Any) {
        output?.checkForUsers(username: tfUsername.text ?? "", password: tfPassword.text ?? "", allUsers: allUsers)
        //        getDataFromServer()
    }
    
    // MARK: - SetUp Functions
    func setUpBorder(border: CALayer, textField: UITextField) {
        border.backgroundColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.height - 1, width: textField.frame.width, height: 1)
        textField.layer.addSublayer(border)
        self.view.layer.masksToBounds = true
    }
    
    func setUpSocialMediaWebView(_ action: Selector, iconMedia: UIImageView) {
        let tapGR1 = UITapGestureRecognizer(target: self, action: action)
        iconMedia.addGestureRecognizer(tapGR1)
        iconMedia.isUserInteractionEnabled = true
    }
    
    func setUpAlertBox(title: String, msg: String, alertStyle: UIAlertController.Style) {
        let alertDialogLogin = UIAlertController(title: title, message: msg, preferredStyle: alertStyle)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertDialogLogin.addAction(OKAction)
        self.present(alertDialogLogin, animated: true, completion: nil)
    }
    
    // MARK: - Text Limit Setters
    func textLimit(existingText: String?, newText: String, limit: Int) -> Bool {
        let text = existingText ?? ""
        let isAtLimit = text.count + newText.count <= limit
        return isAtLimit
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.textLimit(existingText: textField.text, newText: string, limit: 256)
    }
    
    // MARK: - Routing Calls
    func routeToTaskHomeScreen() {
        router?.setRootViewController()
    }
}

// MARK: - Email and Password
extension LogInVC {
    
    @IBAction func emailChanged(_ sender: Any) {
        output?.checkEmail(email: tfUsername.text ?? "")
        }
    
    @IBAction func passwordChanged(_ sender: Any) {
        output?.checkPassword(password: tfPassword.text ?? "")
    }
    
    func updateEmailChanges(isHidden: Bool, backgroundColor: CGColor) {
        lblErrorUsername.isHidden = isHidden
        borderUsername.backgroundColor = backgroundColor
    }
    
    func updatePasswordChanges(isHidden: Bool, backgroundColor: CGColor, errorMsg: String?) {
        lblErrorPassword.isHidden = isHidden
        borderPassword.backgroundColor = backgroundColor
        lblErrorPassword.text = errorMsg
    }

    func updateLoginButtonState(isEnabled: Bool, backgroundColor: UIColor?) {
        btnLogIn.isEnabled = isEnabled
        btnLogIn.backgroundColor = backgroundColor
    }
}

//extension LogInVC {
//
//    func getDataFromServer() {
//
//        //let session = URLSession(configuration: .default)
//
//        let urlString : String = "https://bfsd.uat.bfsgodirect.com/content/dam/mobileapp/bajajmarkets/v2/ios/loanzzzs.json"
//
//        let urlObject : URL = URL(string: urlString)!
//
//        let dataTask = URLSession.shared.dataTask(with: urlObject) { data , response, error in
//
//            print("Data - \(data ?? nil)")
//            print("Response - \(response)")
//            print("Error - \(error)")
//
//            guard let data = data , error == nil else {
//
//                print("Error")
//                return
//            }
//
//            if let parsedResponse = try? JSONSerialization.jsonObject(with: data) as? [String:Any] {
//                print(parsedResponse)
//            }
//        }
//        dataTask.resume()
//    }
//}
