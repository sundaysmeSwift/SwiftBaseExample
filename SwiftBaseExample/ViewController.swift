//
//  ViewController.swift
//  SwiftBaseExample
//
//  Created by administrator on 2019/5/26.
//  Copyright © 2019 administrator. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let str1 = trimNumStrWithText(text: "003556.03652346")
        let str2 = decimalString(string: str1)
        let str3 = NSMutableAttributedString.getPriceAttributePriceTextDouble(priceText: "1234.11223", textFont: UIFont.systemFont(ofSize: 14), moneyFont: UIFont.systemFont(ofSize: 10), textColor: UIColor.red, moneyColor: UIColor.black)
        print(str3)
        self.label?.attributedText = str3
        print(str2)
    }


    
    
}

