//
//  MainTabBarController.swift
//  KeyKeeper
//
//  Created by Владислав Савосько on 25.07.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myVaultVC = createNavController(vc: MyVaultViewController(), image: "lock.fill", title: "My Vault")
        let generatorVC = createNavController(vc: GeneratorViewController(), image: "key.fill", title: "Generator")
        let settingsVC = createNavController(vc: SettingsViewController(), image: "gearshape.fill", title: "Settings")
        
        self.setViewControllers([myVaultVC, generatorVC, settingsVC], animated: false)
    }
    
}

extension MainTabBarController {
    
    func createNavController(vc: UIViewController, image: String, title: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: vc)
        
        navController.tabBarItem.image = UIImage(systemName: image)
        navController.tabBarItem.title = title
        
        return navController
    }
    
}
