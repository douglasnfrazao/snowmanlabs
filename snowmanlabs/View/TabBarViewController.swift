//  Created by dougas.nunes on 13/09/20.
//  Copyright © 2020 douglas nunes. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstViewController = MySpotsViewController()
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        let secondViewController = MapViewController()
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        let thirdViewController = ProfileViewController()
        thirdViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        let tabBarList = [firstViewController, secondViewController, thirdViewController]
        viewControllers = tabBarList
        removeTabbarItemsText()
        selectedIndex = 1
        tabBar.tintColor = UIColor.appColor(.snowManBlue)
    }
    
    private func removeTabbarItemsText() {
        if let items = tabBar.items {
            for item in items {
                item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
                item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.clear], for: .selected)
                item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.clear], for: .normal)
            }
        }
    }
    
}
