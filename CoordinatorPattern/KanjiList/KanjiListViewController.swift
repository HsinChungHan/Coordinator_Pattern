//
//  KanjiListViewController.swift
//  CoordinatorPattern
//
//  Created by Chung Han Hsin on 2019/5/1.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit
protocol KanjiListViewControllerDelegate: class {
    func kanjiListViewControllerDidSelectKanji(_ selectedKanji: Kanji)
}


class KanjiListViewController: UIViewController {
    weak var delegate: KanjiListViewControllerDelegate?
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    var shouldOpenDetailsOnCellSelection = true
    
    var kanjiList: [Kanji] = KanjiStorage.sharedStorage.allKanjis(){
        didSet{
            tableView.reloadData()
        }
    }
    
    var word: String?{
        didSet{
            guard let word = word else {
                return
            }
            kanjiList = KanjiStorage.sharedStorage.kanjiForWord(word)
            title = word
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
}

extension KanjiListViewController{
    fileprivate func setupLayout(){
        title = "List"
        view.addSubview(tableView)
        tableView.fillSuperView()
    }
}


extension KanjiListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kanjiList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "ListItemId"){
            cell = dequeuedCell
        }else{
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "ListItemId")
        }
        let kanji = kanjiList[indexPath.row]
        cell.textLabel?.text = kanji.character
        cell.detailTextLabel?.text = kanji.meaning
        cell.accessoryType = shouldOpenDetailsOnCellSelection ? .disclosureIndicator : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //讓使用者ㄖ進入detailVC時，只能再查找一次，不要讓使用者無限查找
        guard shouldOpenDetailsOnCellSelection == true else{return}
        let kanji = kanjiList[indexPath.row]
        delegate?.kanjiListViewControllerDidSelectKanji(kanji)
        tableView.deselectRow(at: indexPath, animated: true)
         /*
        defer{
            tableView.deselectRow(at: indexPath, animated: true)
        }
       
         let kanjiDetailVC = KanjiDetailViewController()
         kanjiDetailVC.selectedKanji = kanji
         navigationController?.pushViewController(kanjiDetailVC, animated: true)
         */
        
    }
    
    
}
