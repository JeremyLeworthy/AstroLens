//
//  SceneDelegate.swift
//  AstroLens
//
//  Created by Jeremy Leworthy on 2023-03-04.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: windowScene)
		
		let navController = UINavigationController(rootViewController: TabBarController())
		navController.navigationBar.isTranslucent = true
		navController.navigationBar.tintColor = .white
		navController.navigationBar.prefersLargeTitles = true
		
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.shadowColor = .clear
		UINavigationBar.appearance().standardAppearance = appearance
		UINavigationBar.appearance().scrollEdgeAppearance = appearance
		
		window.rootViewController = navController
		window.makeKeyAndVisible()
		self.window = window
	}

	func sceneDidDisconnect(_ scene: UIScene) {
		
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
		
	}

	func sceneWillResignActive(_ scene: UIScene) {
		
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
		
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		
	}

}
