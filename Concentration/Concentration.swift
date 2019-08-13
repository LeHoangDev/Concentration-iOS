//
//  Concentration.swift
//  Concentration Model
//
//  Created by Manh Hoang Le on 22.07.19.
//

import Foundation

class Concentration{
    
    
    //Alternative var cars = [Card]
    var cards = Array<Card>()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int){
        print("Card Identifier: ", cards[index].identifier)
        //Ignore Matched Cards
        if !cards[index].isMatched{
            //If there is on card faceup and not the same as index
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //either no cards or 2 cards are face up
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    //Constructor
    init(numberOfPairsOfCards: Int){
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            //Card is Struct because of that a copy will be passed
            //Have same identifier
            //cards.append(card)
            //cards.append(card)
            cards += [card, card]
        }
        cards.shuffle();
        // TODO: Shuffle the cards
    }
}
