//
//  LastViewController.swift
//  HowMuch
//
//  Created by 심찬영 on 2021/11/28.
//

import UIKit

class LastViewController : UIViewController {
    
    @IBOutlet weak var curItem: UILabel!
    
    var selectedItem : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        curItem.text = selectedItem
        
    }
}
