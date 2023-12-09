//
//  SceneDelegate.swift
//  ToDoList
//
//  Created by azure on 2023/11/20.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let defaults = UserDefaults.standard
        let loginViewController = UINavigationController(rootViewController: LoginViewController())
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil);
        let mainScreenController = storyboard.instantiateViewController(identifier: "HomeTabBarController")
        
//        let currentUser = Auth.auth().currentUser
        
//        if currentUser != nil {
//            window?.rootViewController = mainScreenController
//        } else {
//            window?.rootViewController = loginViewController
//        }

        if let _ = defaults.string(forKey: "token") {
            // set mainScreen as the root view controller
            window?.rootViewController = mainScreenController
        } else {
            window?.rootViewController = loginViewController
        }
//        
        window?.makeKeyAndVisible()
    }
    
    func switchToMainScreenController() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil);
        let mainScreenController = storyboard.instantiateViewController(identifier: "HomeTabBarController")
        window?.rootViewController = mainScreenController
    }
    
    func switchToLoginViewController() {
        let loginViewController = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginViewController)
        window?.rootViewController = navigationController
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

