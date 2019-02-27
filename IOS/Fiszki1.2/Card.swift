//
//  Card.swift
//  Fiszki1.2
//
//  Created by xxx on 18/02/2019.
//  Copyright © 2019 xxx. All rights reserved.
//

import UIKit

class Card {
    
    var idCard: Int
    var statuteOfKnowledge: Int
    var textOnFrontSideCard: String
    var textOnBackSideCard: String
    
    
    init(idCard: Int, statuteOfKnowledge: Int, textOnFrontSideCard: String, textOnBackSideCard: String) {
        self.idCard = idCard
        self.statuteOfKnowledge = statuteOfKnowledge
        self.textOnFrontSideCard = textOnFrontSideCard
        self.textOnBackSideCard = textOnBackSideCard
    }
    
}
