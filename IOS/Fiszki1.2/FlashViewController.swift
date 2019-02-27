//
//  FlashViewController.swift
//  Fiszki1.2
//
//  Created by xxx on 18/02/2019.
//  Copyright © 2019 xxx. All rights reserved.
//

import UIKit

class FlashViewController: UIViewController {


    @IBOutlet weak var dontKnowButton: UIButton!
    @IBOutlet weak var associateButton: UIButton!
    @IBOutlet weak var rememberButton: UIButton!
    @IBOutlet weak var knowItButton: UIButton!
    @IBOutlet weak var flipCardButton: UIButton!
    @IBOutlet weak var cardView: UIImageView!
    @IBOutlet weak var cardTextView: UITextView!
    @IBOutlet weak var numberOfCards: UINavigationItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var addTextField: UITextField!
    @IBOutlet weak var addTextField2: UITextField!
    @IBOutlet weak var myNavBar: UINavigationBar!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var obverseLabel: UILabel!
    @IBOutlet weak var reverseLabel: UILabel!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    
    var isCardFliped = false
    var counter = 0
    var cards = [Card]()
    var card1 = Card.init(idCard: 1, statuteOfKnowledge: 0, textOnFrontSideCard: "Apple", textOnBackSideCard: "Jabłko")
    var card2 = Card.init(idCard: 2, statuteOfKnowledge: 0, textOnFrontSideCard: "Banana", textOnBackSideCard: "Banan")
    var card3 = Card.init(idCard: 3, statuteOfKnowledge: 0, textOnFrontSideCard: "Strawberry", textOnBackSideCard: "Truskawka")
    var card4 = Card.init(idCard: 4, statuteOfKnowledge: 0, textOnFrontSideCard: "Pear", textOnBackSideCard: "Gruszka")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cards.append(card1)
        cards.append(card2)
        cards.append(card3)
        cards.append(card4)
        numberOfCards.title = String(cards[counter].idCard)+"/"+String(cards.count)
        cardTextView.text = cards[counter].textOnFrontSideCard
        setButtonStatuses(cards: cards)
        addTextField.isHidden = true
        addTextField2.isHidden = true
        saveButton.isEnabled = false
        obverseLabel.isHidden = true
        reverseLabel.isHidden = true
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
            view.endEditing(true)
        if !(addTextField.text?.isEmpty)! && !(addTextField2.text?.isEmpty)! {
            createNewCard(firstSide: addTextField.text!, secoundSide: addTextField2.text!)
            addTextField.isHidden = true
            addTextField2.isHidden = true
            cardTextView.isHidden = false
            setButtonStatuses(cards: cards)
            numberOfCards.title = String(cards[counter].idCard)+"/"+String(cards.count)
            saveButton.isEnabled = false
            addButton.isEnabled = true
            obverseLabel.isHidden = true
            reverseLabel.isHidden = true
            
        }else {
            print("you need to fill in")
        }
    }
    
    @IBAction func deleteCard(_ sender: Any) {
        if cards.count == 1 {
            createNewCard(firstSide: "", secoundSide: "")
            decreaseIdCard(cards: cards)
            setButtonStatuses(cards: cards)
            
            cards.remove(at: cards[counter].idCard - 1)
            setButtonStatuses(cards: cards)
            if counter != 0 {
                counter = counter - 1
            }
            numberOfCards.title = String(cards[counter].idCard)+"/"+String(cards.count)
            cardTextView.text = cards[counter].textOnFrontSideCard
        }else {
            decreaseIdCard(cards: cards)
            setButtonStatuses(cards: cards)
            print(cards.count, counter)
                
                cards.remove(at: cards[counter].idCard - 1)
                setButtonStatuses(cards: cards)
                if counter != 0 {
                    counter = counter - 1
                }
                numberOfCards.title = String(cards[counter].idCard)+"/"+String(cards.count)
                cardTextView.text = cards[counter].textOnFrontSideCard
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
    }
    @IBAction func addButtonTapped(_ sender: Any) {
        cardTextView.isHidden = true
        addTextField.isHidden = false
        addTextField2.isHidden = false
        saveButton.isEnabled = true
        addButton.isEnabled = false
        obverseLabel.isHidden = false
        reverseLabel.isHidden = false
    }

    func createNewCard(firstSide: String, secoundSide: String) {
        let newCard = Card.init(idCard: cards.count + 1, statuteOfKnowledge: 0, textOnFrontSideCard: firstSide, textOnBackSideCard: secoundSide)
        cards.append(newCard)
    }
    
    func loop(counter: Int) -> Int {
        var counter = self.counter
        if counter == cards.count {
            counter = 0
        }
        return counter
    }
    
    func decreaseIdCard(cards: [Card]) {
        for card in cards {
            if card.idCard > cards[counter].idCard {
                card.idCard = card.idCard - 1
            }
        }
    }
    
    func setButtonStatuses(cards: [Card]) {
        var numberOfStatuses: [Int] = [0, 0, 0, 0]
        if cards.isEmpty {
            let defaultNumber = "0"
            dontKnowButton.setTitle(defaultNumber, for: .normal)
            associateButton.setTitle(defaultNumber, for: .normal)
            rememberButton.setTitle(defaultNumber, for: .normal)
            knowItButton.setTitle(defaultNumber, for: .normal)
        }else {
            for card in cards {
                switch card.statuteOfKnowledge {
                case 0:
                    numberOfStatuses[0] = numberOfStatuses[0] + 1
                case 1:
                    numberOfStatuses[1] = numberOfStatuses[1] + 1
                case 2:
                    numberOfStatuses[2] = numberOfStatuses[2] + 1
                case 3:
                    numberOfStatuses[3] = numberOfStatuses[3] + 1
                default:
                    print("Error in set statuses")
                }
            }
        }
        dontKnowButton.setTitle(String(numberOfStatuses[0]), for: .normal)
        associateButton.setTitle(String(numberOfStatuses[1]), for: .normal)
        rememberButton.setTitle(String(numberOfStatuses[2]), for: .normal)
        knowItButton.setTitle(String(numberOfStatuses[3]), for: .normal)
    }
    
    @IBAction func dontKnowButtonTapped(_ sender: Any) {
        cards[counter].statuteOfKnowledge = 0
        counter = counter + 1
        counter = loop(counter: counter)
        cardTextView.text = cards[counter].textOnFrontSideCard
        isCardFliped = false
        setButtonStatuses(cards: cards)
        numberOfCards.title = String(cards[counter].idCard)+"/"+String(cards.count)
    }
    
    @IBAction func associateButtonTapped(_ sender: Any) {
        cards[counter].statuteOfKnowledge = 1
        counter = counter + 1
        counter = loop(counter: counter)
        cardTextView.text = cards[counter].textOnFrontSideCard
        isCardFliped = false
        setButtonStatuses(cards: cards)
        numberOfCards.title = String(cards[counter].idCard)+"/"+String(cards.count)
    }
    
    @IBAction func rememberButtonTapped(_ sender: Any) {
        cards[counter].statuteOfKnowledge = 2
        counter = counter + 1
        counter = loop(counter: counter)
        cardTextView.text = cards[counter].textOnFrontSideCard
        isCardFliped = false
        setButtonStatuses(cards: cards)
        numberOfCards.title = String(cards[counter].idCard)+"/"+String(cards.count)
    }

    @IBAction func knowItButtonTapped(_ sender: Any) {
        cards[counter].statuteOfKnowledge = 3
        counter = counter + 1
        counter = loop(counter: counter)
        cardTextView.text = cards[counter].textOnFrontSideCard
        isCardFliped = false
        setButtonStatuses(cards: cards)
        numberOfCards.title = String(cards[counter].idCard)+"/"+String(cards.count)
    }
    
    func flipCardFunc() {
        UIView.transition(from: cardView, to: cardView, duration: 0.5, options: [.transitionFlipFromRight, .showHideTransitionViews])
        
        if isCardFliped == false {
            cardTextView.text = cards[counter].textOnBackSideCard
            isCardFliped = true
        } else {
            cardTextView.text = cards[counter].textOnFrontSideCard
            isCardFliped = false
        }
    }
    
    @IBAction func flipCard(_ sender: UIButton) {
        flipCardFunc()
    }

    

    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
