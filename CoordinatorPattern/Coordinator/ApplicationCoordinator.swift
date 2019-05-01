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
    let kanjiListCoordinator: AllKanjiListCoordinator
    
    init(window: UIWindow){
        self.window = window
        kanjiStorage = KanjiStorage()
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        kanjiListCoordinator = AllKanjiListCoordinator.init(presenter: rootViewController, kanjiStorage: kanjiStorage)
    }
    
    func start() {
        window.rootViewController = rootViewController
        kanjiListCoordinator.start()
        window.makeKeyAndVisible()
    }
}
