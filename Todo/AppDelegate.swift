//
//  AppDelegate.swift
//  Todo
//
//  Created by Pratham Gupta on 28/02/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    // MARK: - Application Life Cycle Functions

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        loadData()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        setUpRootVC()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        deleteUsersFiles()
        saveAllTasksFile()
    }
    
    // MARK: - Utility Functions
    
    func loadData()
    {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let userFileURL = URL(fileURLWithPath: "user_file", relativeTo: directoryURL).appendingPathExtension("txt")
        
        do{
            
            let data = try encoder.encode(users)
            try data.write(to: userFileURL)
            print("File saved: \(userFileURL.absoluteURL)")
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteUsersFiles() {
        
        let userFileURL = URL(fileURLWithPath: "user_file", relativeTo: directoryURL).appendingPathExtension("txt")
        
        do {
            try FileManager.default.removeItem(at: userFileURL)
        } catch {
            print("File not removed")
        }
    }
    
    func saveAllTasksFile() {
        
        if UserDefaults.standard.bool(forKey: "isUserLoggedIn") == true{
            
           print("logging in")
                    
           let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let taskFileURL = URL(fileURLWithPath: "user_task_file", relativeTo: directoryURL).appendingPathExtension("txt")
            
            do{
                allData[UserDefaults.standard.string(forKey: "loggedInUsername")!] = tasksList
                let data = try encoder.encode(allData)
                try data.write(to: taskFileURL)
                print("File saved: \(taskFileURL.absoluteURL)")
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func setUpRootVC()
    {
        
        window?.rootViewController = UINavigationController(rootViewController: getUIViewControllerFromID("LogInVC"))
    }
    
    func addBottomTabBarViewController()
    {
        window?.rootViewController = getUIViewControllerFromID("BottomTabBarController")
    }
}

func getUIViewControllerFromID(_ id: String) -> UIViewController {
    
    let storyboard = UIStoryboard(name: "Main", bundle: .main)
    let viewController = storyboard.instantiateViewController(withIdentifier: id)
    return viewController
}

