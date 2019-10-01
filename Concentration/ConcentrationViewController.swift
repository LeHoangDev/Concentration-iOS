//
//  ViewController.swift
//  Concentration
//
//  Created by Manh Hoang Le on 15.07.19.
//

import UIKit

class ConcentrationViewController: VCLLoggingViewController {

    //If all propertys are initialized there is a init()
    //lazy: it initialize when someone use ist
    //lazy: has not didSet...
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairOfCards)
    
    /*
    override var vclLoggingName: String {
        return "Game"
    }
    */
    
    var numberOfPairOfCards : Int {
        return ((visibleCardButtons.count+1) / 2)
    }
    
    //Alternative var flipCount = 0
    private(set) var flipCount: Int = 0 {
        //Property Observer
        didSet{
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(
            string: traitCollection.verticalSizeClass == .compact ? "Flips\n\(flipCount)" : "Flips: \(flipCount)",
            attributes: attributes
        )
        //flipCountLabel.text = "Flips: \(flipCount)"
        flipCountLabel.attributedText = attributedString
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateFlipCountLabel()
    }
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    //Alternative var emojiChoices = ["👻","🎃","👻","🎃"]
    //private var emojiChoices: [String] = ["👻","🎃","🎉","🎊","😎","👽","👺","💀","👹","💩","☠️","🙈"]
    private var emojiChoices = "👻🎃🎉🎊😎👽👺💀👹💩☠️🙈"
    private var emoji = Dictionary<Card, String>()
    //Alternative var emoji = [Card, String]()
    
    //Outlet Instant Variable
    // ! means "I know this optional variable definitely has a value, so let me use it directly."
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    //[UIButton] == Array<UIButton>
    /// Contains all Buttons from View
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var visibleCardButtons: [UIButton]! {
        return cardButtons?.filter { !$0.superview!.isHidden }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    
    @IBAction private func NewGame(_ sender: Any) {
        emoji = [:]
        emojiChoices = theme ?? "👻🎃🎉🎊😎👽👺💀👹💩☠️🙈"
        flipCount = 0
        game = Concentration(numberOfPairsOfCards: (visibleCardButtons.count+1) / 2)
        //emoji = Dictionary<Card, String>();
        
        //emojiChoices = ["👻","🎃","🎉","🎊","😎","👽","👺","💀","👹","💩","☠️","🙈"]
        
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        //let sind Constant var normale Variablen
        //cardButtons.firstIndex(of: sender) gibt Optional zurueck
        // ! assume Optional is set and take the number
        // nil == Optional not set
        if let cardNumber = visibleCardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            print("cardNumber = \(cardNumber)")
        } else {
            print("Chosen card was not in cardButton")
        }
        
    }
    
    
    
    /// Updates View From Model Data
    private func updateViewFromModel(){
        //for button in 0..<visibeCardButtons.count
        if visibleCardButtons != nil {
            for index in visibleCardButtons.indices{
                let button = visibleCardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                } else{
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
                }
            
            }
        }
    }
    
    /// Get Emoji or assigns an emojis to cards
    /// - Parameter card: Card
    /// - Returns: Emoji for that card
    private func emoji(for card: Card) -> String{
        //if there is no emoji for that card and there are still emojis remaining
        if emoji[card] == nil, emojiChoices.count > 0 {
            //choosen one random emoji and assign in into the dictionary
            let radomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: radomStringIndex))
            //emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        /*
        if emoji[card.identifier] == nil {
        if emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
 
        }
        */
        
        //If there's no emoji for that card return "?"
        return emoji[card] ?? "?"
        
        /*Alternative
         if emoji[card.identifier] != nil {
            return emoji[card.identifier]
        } else {
            return "?"
        }*/
    }
}

extension Int{
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}


