//
//  Concentration.swift
//  Concentration Model
//
//  Created by Manh Hoang Le on 22.07.19.
//

import Foundation

struct Concentration{
    
    
    //Alternative var cars = [Card]
    private(set) var cards = Array<Card>()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            /* Alternative
            let faceUpCardIndices = cards.indices.filter {
                cards[$0].isFaceUp
            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            }*/
            
            //Mit Extension
            return cards.indices.filter {
                cards[$0].isFaceUp
                }.oneAndOnly
            
//
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp{
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set(newValue){
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentrstion.chooserCard(at: \(index)): chosen index not in the cards")
        //Ignore Matched Cards
        if !cards[index].isMatched{
            //If there is on card faceup and not the same as index
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //check if cards match
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
                
                if (indexOfOneAndOnlyFaceUpCard != nil) {
                    
                }
            }
        }
    }
    
    //Constructor
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentrstion.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
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

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first: nil
    }
}
