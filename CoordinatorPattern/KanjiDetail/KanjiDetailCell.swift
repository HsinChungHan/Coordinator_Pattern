//
//  KanjiDetailCell.swift
//  CoordinatorPattern
//
//  Created by Chung Han Hsin on 2019/5/1.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import UIKit

class KanjiDetailCell: UITableViewCell {
    var kanjiData: Kanji?{
        didSet{
            meaningValueLabel.text = kanjiData?.meaning
            characterLabel.text = kanjiData?.character
        }
    }
    
    fileprivate var leftStackView = UIStackView.init()
    fileprivate var overallStackView = UIStackView.init()
    fileprivate let meaningLabel: UILabel = {
        let label = UILabel()
        label.text = "Meaning"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let meaningValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Meaning..."
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate let characterLabel: UILabel = {
        let label = UILabel()
        label.text = "Character"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 120)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let seperatedView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return view
    }()
    
    fileprivate func setupLayout(){
        backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        leftStackView.addArrangedSubview(meaningLabel)
        leftStackView.addArrangedSubview(meaningValueLabel)
        leftStackView.axis = .vertical
        leftStackView.spacing = 10.0
        leftStackView.distribution = .fillEqually
        overallStackView.addArrangedSubview(leftStackView)
        overallStackView.addArrangedSubview(characterLabel)
        overallStackView.axis = .horizontal
        overallStackView.spacing = 10.0
        overallStackView.distribution = .fillEqually
        addSubview(overallStackView)
        overallStackView.fillSuperView(padding: .init(top: 0, left: 5, bottom: 3, right: 5))
        addSubview(seperatedView)
        seperatedView.anchor(top: overallStackView.bottomAnchor, bottom: nil
            , leading: overallStackView.leadingAnchor, trailing: overallStackView.trailingAnchor, padding: .zero, size: .init(width: 0, height: 2))
        
    }
    
    public func setupValue(kanjiData: Kanji){
        self.kanjiData = kanjiData
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
