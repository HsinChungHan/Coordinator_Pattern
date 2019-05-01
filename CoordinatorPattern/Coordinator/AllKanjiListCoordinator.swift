//
//  KanjiListCoordinator.swift
//  CoordinatorPattern
//
//  Created by Chung Han Hsin on 2019/5/1.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import Foundation
import UIKit

class AllKanjiListCoordinator: Coordinator {
    fileprivate let presenter: UINavigationController
    fileprivate let allKanjiList: [Kanji]
    fileprivate var kanjiListViewController: KanjiListViewController?
    fileprivate let kanjiStorage: KanjiStorage
    fileprivate var word: String?
    
    //MARK: - Coordinator
    fileprivate var kanjiDetasilCoordinator: KanjiDetailCoordinator?
    
    init(presenter: UINavigationController, kanjiStorage: KanjiStorage, word: String? = nil) {
        self.presenter = presenter
        self.kanjiStorage = kanjiStorage
        self.word = word
        allKanjiList = kanjiStorage.allKanjis()
    }
    
    func start() {
        let kanjiListViewController = KanjiListViewController()
        kanjiListViewController.delegate = self
        self.kanjiListViewController = kanjiListViewController
        kanjiListViewController.title = "Kanji List"
        kanjiListViewController.kanjiList = allKanjiList
        if let word = word{
            kanjiListViewController.title = word
            kanjiListViewController.word = word
            kanjiListViewController.shouldOpenDetailsOnCellSelection = false
        }
        
        presenter.pushViewController(kanjiListViewController, animated: true)
        
    }
}

extension AllKanjiListCoordinator: KanjiListViewControllerDelegate{
    func kanjiListViewControllerDidSelectKanji(_ selectedKanji: Kanji) {
        let kanjiDetailCoordinator = KanjiDetailCoordinator.init(presenter: presenter, kanjiStorage: kanjiStorage, kanji: selectedKanji)
        kanjiDetailCoordinator.start()
        self.kanjiDetasilCoordinator = kanjiDetailCoordinator
    }
}
