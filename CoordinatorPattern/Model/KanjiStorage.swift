//
//  KanjiStorage.swift
//  CoordinatorPattern
//
//  Created by Chung Han Hsin on 2019/5/1.
//  Copyright © 2019 Chung Han Hsin. All rights reserved.
//

import Foundation

struct KanjiCache {
    let kanjiArray: [Kanji]
    let kanjiDictionary: [String: Kanji]
}

class KanjiStorage {
    static let sharedStorage = KanjiStorage()
    static let kanjiURL = Bundle.main.url(forResource: "knji", withExtension: "json")!
    
    private var allKanjiFromJSON: KanjiCache
    
    init(){
        do{
            let data = try Data.init(contentsOf: KanjiStorage.kanjiURL)
            let allKanjis = try JSONDecoder().decode([Kanji].self, from: data)
            let kanjiDictionary = allKanjis.reduce([:]){(dictionary, kanji) -> [String: Kanji] in
                var dictionary = dictionary
                print(kanji.character)
                dictionary[kanji.character] = kanji
                return dictionary
            }
            
            allKanjiFromJSON = KanjiCache.init(kanjiArray: allKanjis, kanjiDictionary: kanjiDictionary)
            
        }catch let error as NSError{
            fatalError("Faile to decode kanjis \(error)")
        }
//        allKanjiFromJSON = KanjiCache.init(kanjiArray: [], kanjiDictionary: [String: Kanji]())
    }
    
    public func allKanjis() -> [Kanji]{
        return allKanjiFromJSON.kanjiArray
    }
    
    public func kanjiForWord(_ word: String) -> [Kanji]{
        
        let kanjiInWord: [Kanji] = word.compactMap { (character) -> Kanji? in
            
            let kanjiForCharacter = allKanjiFromJSON.kanjiDictionary["\(character)"]
            return kanjiForCharacter
        }
        
        return kanjiInWord
    }
    
    
    
}
