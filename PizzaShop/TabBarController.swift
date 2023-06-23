//
//  TabBarController.swift
//  PizzaShop
//
//  Created by Алексей Ревякин on 23.06.2023.
//

import UIKit

enum Tabs: Int, CaseIterable {
    case menu
    case contacts
    case profile
    case bascet
}

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = R.Color.colorB1
        tabBar.barTintColor = R.Color.inactive
        
        let controllers: [UINavigationController] = Tabs.allCases.map { tab in
            let controller = UINavigationController(rootViewController: getController(for: tab))
            controller.tabBarItem = UITabBarItem(title: getTitle(for: tab),
                                                 image: getImage(for: tab),
                                                 tag: tab.rawValue)
            return controller
        }
        
        setViewControllers(controllers, animated: true)
        tabBar.layer.borderColor = R.Color.separatot.cgColor
        tabBar.layer.borderWidth = 0.5
    }
    
    private func getController(for tab: Tabs) -> UIViewController {
        switch tab {
        case .menu:
            return MenuController()
        default:
            return UIViewController()
        }
    }
    
    private func getTitle(for tab: Tabs) -> String {
        switch tab {
        case .menu:
            return R.Strings.menu
        case .contacts:
            return R.Strings.contacts
        case .profile:
            return R.Strings.profile
        case .bascet:
            return R.Strings.bascet
        }
    }
    
    private func getImage(for tab: Tabs) -> UIImage?{
        switch tab {
        case .menu:
            return R.Image.menu
        case .contacts:
            return R.Image.contacts
        case .profile:
            return R.Image.profile
        case .bascet:
            return R.Image.bascet
        }
    }
    

}
