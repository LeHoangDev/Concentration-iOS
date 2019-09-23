//
//  ConcentrationThemeChoserViewController.swift
//  Concentration
//
//  Created by Manh Hoang Le on 18.09.19.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

   
    let themes = [
        "Sports": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓⛷🎳⛳️",
        "Animals": "🐶🦆🐹🐸🐘🦍🐓🐩🐦🦋🐙🐏",
        "Faces": "😀😌😎🤓😠😤😭😰😱😳😜😇"
    ]
    
    
    @IBAction func changeTheme(_ sender: Any) {
        performSegue(withIdentifier: "Choose Theme", sender: sender)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
                if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                    if let cvc = segue.destination as? ConcentrationViewController {
                        cvc.theme = theme
                    }
            }
        }
    }

}
