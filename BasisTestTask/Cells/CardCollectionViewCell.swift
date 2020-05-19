//
//  CardCollectionViewCell.swift
//  BasisTestTask
//
//  Created by Himanshu Chaurasiya on 19/05/20.
//  Copyright © 2020 Himanshu Chaurasiya. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet var textLabel: UILabel!
    
    var text : String?{
        didSet{
            if let text = text{
                textLabel.text = text
            }
        }
    }
    
}
