//
//  KanjiDetailViewController.swift
//  CoordinatorPattern
//
//  Created by Chung Han Hsin on 2019/5/1.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit
enum DetailViewCellId: String{
    case wordExampleCellId
    case KanjiDetailCellId
}

protocol KanjiDetailViewControllerDelegate: class {
    func kanjiDetailViewControllerDidSelectWord(_ selectedWord: String)
}

class KanjiDetailViewController: UIViewController {
    weak var delegate: KanjiDetailViewControllerDelegate?
    
    var selectedKanji: Kanji?{
        didSet{
            guard let selectedKanji = selectedKanji else {
                return
            }
            DispatchQueue.main.async {[weak self] in
                self?.title = selectedKanji.character
                self?.tableView.reloadData()
            }
        }
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        registerTableViewCell()
    }
}

extension KanjiDetailViewController{
    fileprivate func setupLayout(){
        view.addSubview(tableView)
        tableView.fillSuperView()
    }
    
    fileprivate func registerTableViewCell(){
        tableView.register(WordExampleCell.self, forCellReuseIdentifier: DetailViewCellId.wordExampleCellId.rawValue)
        tableView.register(KanjiDetailCell.self, forCellReuseIdentifier: DetailViewCellId.KanjiDetailCellId.rawValue)
    }
    
    public func setupValue(selectedKanji: Kanji){
        self.selectedKanji = selectedKanji
    }
}

extension KanjiDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1: return "Words"
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return (selectedKanji != nil) ? 1 : 0
        case 1:
            return selectedKanji?.examples.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailViewCellId.KanjiDetailCellId.rawValue, for: indexPath) as! KanjiDetailCell
            guard let selectedKanji = selectedKanji else {return cell}
            cell.setupValue(kanjiData: selectedKanji)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailViewCellId.wordExampleCellId.rawValue, for: indexPath) as! WordExampleCell
            guard let wordExample = selectedKanji?.examples[indexPath.row] else {return cell}
            cell.setupValue(wordExample: wordExample)
            cell.accessoryType = .disclosureIndicator
            return cell
        default:
            fatalError("Fsailed to init cell")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 1 else{return}
        if let word = selectedKanji?.examples[indexPath.row].word{
            delegate?.kanjiDetailViewControllerDidSelectWord(word)
            /*
            let listVC = KanjiListViewController()
            listVC.shouldOpenDetailsOnCellSelection = false
            listVC.word = word
            navigationController?.pushViewController(listVC, animated: true)
             */
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 200
        default:
            return 60
        }
    }
}

