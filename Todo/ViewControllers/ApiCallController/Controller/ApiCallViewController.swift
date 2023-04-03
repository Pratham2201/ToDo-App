//
//  ApiCallViewController.swift
//  Todo
//
//  Created by Pratham Gupta on 30/03/23.
//

import UIKit

class ApiCallViewController: UIViewController {

    let viewModel = ApiCallViewModel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        viewModel.getAirlinesData()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        viewModel.getAirlinesData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
