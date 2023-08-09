//
//  MainTabBarViewContrller.swift
//  Netflix Clone
//
//  Created by Xursandbek Qambaraliyev on 09/08/23.
//

import Foundation
import UIKit

class MainTabBarViewContrller: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemYellow
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: UpcomingViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc4 = UINavigationController(rootViewController: DowloandsViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        vc1.title = "Home"
        vc2.title = "Coming Soon"
        vc3.title = "Top Search"
        vc4.title = "Dowlands"
        
        tabBar.tintColor = .label
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
        
    }
}
