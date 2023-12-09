//
//  ProfileViewController.swift
//  WA7-Chang-9179
//
//  Created by Chang on 2023/11/6.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {
    
    let profileScreenView = ProfileScreenView()
    
    override func loadView() {
        view = profileScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        
        showProfileDetail()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", image: nil, target: self, action: #selector(onButtonEditTapped))
        
        profileScreenView.block = { [weak self] value in
            
            self!.onButtonLogoutTapped()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let url = UserDefaults.standard.object(forKey: "storagePath")
        self.profileScreenView.setHeaderUrl(url: url as! String)
    }
    
    @objc func onButtonEditTapped() {

        let editScreenViewController = EditViewController()
        navigationController?.pushViewController(editScreenViewController, animated: true)
    }

    func onButtonLogoutTapped() {
        UserDefaults.standard.removeObject(forKey: "token")
        print("token removed")
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.switchToLoginViewController()
            let loginScreenViewController = LoginViewController()
            navigationController?.pushViewController(loginScreenViewController, animated: true)
        }
    }
}

extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
            popToViewController(vc, animated: true)
        }
    }
    func popViewController(viewsToPop: Int, animated: Bool = true) {
        if viewControllers.count > viewsToPop {
            let vc = viewControllers[viewControllers.count - 1 - viewsToPop]
            popToViewController(vc, animated: true)
        }
    }
}
