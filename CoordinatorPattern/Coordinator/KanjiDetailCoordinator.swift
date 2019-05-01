//
//  KanjiDetailCoordinator.swift
//  CoordinatorPattern
//
//  Created by Chung Han Hsin on 2019/5/1.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import Foundation
import UIKit

class KanjiDetailCoordinator: Coordinator {
    fileprivate let presenter: UINavigationController
    fileprivate var kanjiDetailViewController: KanjiDetailViewController?
    fileprivate var wordKanjiListViewController: KanjiListViewController?
    fileprivate let kanjiStorage: KanjiStorage
    fileprivate let kanji: Kanji
    
    
    
    init(presenter: UINavigationController, kanjiStorage: KanjiStorage, kanji: Kanji) {
        self.kanji = kanji
        self.kanjiStorage = kanjiStorage
        self.presenter = presenter
    }
    
    func start() {
        let kanjiDetailViewController = KanjiDetailViewController()
        self.kanjiDetailViewController = kanjiDetailViewController
        kanjiDetailViewController.delegate = self
        kanjiDetailViewController.title = "Kanji detail"
        kanjiDetailViewController.selectedKanji = kanji
        
        presenter.pushViewController(kanjiDetailViewController, animated: true)
    }
}

extension KanjiDetailCoordinator: KanjiDetailViewControllerDelegate{
    func kanjiDetailViewControllerDidSelectWord(_ selectedWord: String) {
        let allKanjiListCoordinator = AllKanjiListCoordinator.init(presenter: presenter, kanjiStorage: kanjiStorage, word: selectedWord)
        allKanjiListCoordinator.start()
    }
    
    
}
