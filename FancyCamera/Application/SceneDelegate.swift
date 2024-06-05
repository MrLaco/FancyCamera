//
//  SceneDelegate.swift
//  FancyCamera
//
//  Created by user on 31.05.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = CameraViewController(cameraService: CameraService())
        self.window = window
        window.makeKeyAndVisible()
    }
}

