//
//  ViewController.swift
//  Concentration
//
//  Created by Manh Hoang Le on 15.07.19.
//

import UIKit

class ViewController: UIViewController {

    //If all propertys are initialized there is a init()
    //lazy: it initialize when someone use ist
    //lazy: has not didSet...
    lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count / 2)
    
    //Alternative var flipCount = 0
    var flipCount: Int = 0 {
        //Property Observer
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    //Outlet Instant Variable
    // !
    @IBOutlet weak var flipCountLabel: UILabel!
    
    //[UIButton] == Array<UIButton>
    @IBOutlet var cardButtons: [UIButton]!
    
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        //let sind Constant var normale Variablen
        //cardButtons.firstIndex(of: sender) gibt Optional zurueck
        // ! assume Optional is set and take the number
        // nil == Optional not set
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            print("cardNumber = \(cardNumber)")
        } else {
            print("Chosen card was not in cardButton")
        }
        
    }
    
    func updateViewFromModel(){
        //for button in 0..<cardButtons.count
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        
        }
    }
    //Alternative var emojiChoices = ["👻","🎃","👻","🎃"]
    var emojiChoices: [String] = ["👻","🎃","🎉","🎊","😎","👽","👺","💀","☠️","💩","👹"]
    var emoji = Dictionary<Int, String>()
    //Alternative var emoji = [Int, String]()
    
    func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
        /*
        if emoji[card.identifier] == nil {
        if emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
 
        }
        */
        return emoji[card.identifier] ?? "?"
        
        /*Alternative
         if emoji[card.identifier] != nil {
            return emoji[card.identifier]
        } else {
            return "?"
        }*/
    }
    
    
    

    /**
    func flipCard(withEmoji emoji: String, on button: UIButton){
        if(button.currentTitle == emoji){
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }*/
}


