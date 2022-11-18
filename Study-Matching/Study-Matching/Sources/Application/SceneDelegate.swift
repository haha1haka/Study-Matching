//
//  SceneDelegate.swift
//  Study-Matching
//
//  Created by HWAKSEONG KIM on 2022/11/07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
//        window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
        
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
    }
}
