//
//  UserDefaultsViewController.swift
//  Todo
//
//  Created by Pratham Gupta on 09/03/23.
//

import UIKit

class UserDefaultsViewController: UIViewController {

    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var tfTestUserDefaults: UITextField!
    @IBOutlet weak var viewTestGCD: UIView!
    @IBOutlet weak var btnTestGCD: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let value = userDefaults.string(forKey: "name") ?? "No value Loaded"
        
        tfTestUserDefaults.text = value
    }
    
    @IBAction func saveOnValueChange(_ sender: Any) {
        
//        userDefaults.set(tfTestUserDefaults.text, forKey: "name")
    }
    
    @IBAction func saveonEditComplete(_ sender: Any) {
        
        userDefaults.set(tfTestUserDefaults.text, forKey: "name")
        print("Edit Did Complete")
    }
    
    @IBAction func DidEndOnExit(_ sender: Any) {
        print("Edit End on Exit")
    }
    @IBAction func EditingChanged(_ sender: Any) {
        print("Editing Changed")
    }
    
    @IBAction func EditDidBegin(_ sender: Any) {
        print("Edit Did Begin")
    }
    
    @IBAction func btnTestOnClick(_ sender: Any) {
        
//        viewTestGCD.backgroundColor = .blue
//        print("Button Tapped")
        
        DispatchQueue.global().async {
            for i in 0...10
            {
                print("Task 1: \(i)")
            }
//            self.viewTestGCD.backgroundColor = .green
            
            Thread.sleep(forTimeInterval: 1)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            print("Async After 2")
        })
        
        print("Color will change")
        viewTestGCD.backgroundColor = .blue
        print("Color changed")
        
        for i in 0...10
        {
            print("Task Main: \(i)")
        }

    }
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
