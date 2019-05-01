//
//  WordExampleCell.swift
//  CoordinatorPattern
//
//  Created by Chung Han Hsin on 2019/5/1.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit

class WordExampleCell: UITableViewCell {
    fileprivate var wordExample: WordExample?{
        didSet{
            textLabel?.text = wordExample?.word
            detailTextLabel?.text = wordExample?.meaning
        }
    }
}

extension WordExampleCell{
    public func setupValue(wordExample: WordExample){
        self.wordExample = wordExample
    }
}

