//
//  Card.swift
//  Concentration
//
//  Created by Manh Hoang Le on 22.07.19.
//

import Foundation

//Struct: No inheritance, Value-Types if passed it gets copied i.e. Int, String, Dictionary
//Class: Has inheritance, Reference-Types

//Have free initializer
struct Card: Hashable{
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private static var identifierFactory = 0
    // -> return
    private static func getUniqueIdentifier() -> Int{
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    init(){
        //self like this in java
        self.identifier = Card.getUniqueIdentifier()
    }
}


