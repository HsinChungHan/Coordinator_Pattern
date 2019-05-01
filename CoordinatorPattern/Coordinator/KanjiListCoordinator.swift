//
//  KanjiListCoordinator.swift
//  CoordinatorPattern
//
//  Created by Chung Han Hsin on 2019/5/1.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import Foundation
import UIKit

class KanjiListControllerCoordinator: Coordinator {
    fileprivate let presenter: UINavigationController
    fileprivate let allKanjiList: [Kanji]
    fileprivate var kanjiListViewController: KanjiListViewController?
    fileprivate let kanjiStorage: KanjiStorage
    
    init(presenter: UINavigationController, kanjiStorage: KanjiStorage) {
        self.presenter = presenter
        self.kanjiStorage = kanjiStorage
        allKanjiList = kanjiStorage.allKanjis()
    }
    
    
    func start() {
        let kanjiListViewController = KanjiListViewController()
        self.kanjiListViewController = kanjiListViewController
        kanjiListViewController.title = "Kanji List"
        kanjiListViewController.kanjiList = allKanjiList
        presenter.pushViewController(kanjiListViewController, animated: true)
        
    }
}
