import Foundation

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate{
    override func viewDidLoad(){
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = .systemBackground
        view.backgroundColor = .systemBackground
        controllerSetup()
    }

    func controllerSetup(){
        viewControllers = [
            createNavController(for: FilesViewController(), title: "Files", image: UIImage(systemName: "folder")!),
        ]
    }

    private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController{
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        navController.navigationBar.isTranslucent = true
        rootViewController.navigationItem.title = title
        return navController
    }
}
