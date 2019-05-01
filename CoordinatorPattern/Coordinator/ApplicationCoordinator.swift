//
//  ApplicationCoordinator.swift
//  CoordinatorPattern
//
//  Created by Chung Han Hsin on 2019/5/1.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    let kanjiStorage: KanjiStorage
    let window: UIWindow
    let rootViewController: UINavigationController
    let kanjiListCoordinator: KanjiListControllerCoordinator
    
    init(window: UIWindow){
        self.window = window
        kanjiStorage = KanjiStorage()
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        kanjiListCoordinator = KanjiListControllerCoordinator.init(presenter: rootViewController, kanjiStorage: kanjiStorage)
        
        
        //Testing Code
        /*
        let emptyViewController = UIViewController()
        emptyViewController.view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        rootViewController.pushViewController(emptyViewController, animated: true)
        */
    }
    
    func start() {
        window.rootViewController = rootViewController
        kanjiListCoordinator.start()
        window.makeKeyAndVisible()
    }
    
    
}
