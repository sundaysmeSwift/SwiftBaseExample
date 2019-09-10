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
    
    
//    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
//
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//
//    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//       
//    }
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)!
//        fatalError("init(coder:) has not been implemented")
//
//    }

//    convenience init(){
//        var nibNameOrNil = String?("ViewController")
//        if Bundle.main.path(forResource: nibNameOrNil, ofType: "xib") == nil {
//         nibNameOrNil = nil
//          }
//       self.init(nibName:nibNameOrNil, bundle: nil)
//       
//    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let str2 = decimalString(string: "\(Myview.self)")
    
        print(str2)
        
//        setUpUI()
    }

    
}

