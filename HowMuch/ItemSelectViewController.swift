//
//  ItemSelectViewController.swift
//  HowMuch
//
//  Created by 심찬영 on 2021/11/09.
//

import UIKit

class ItemSelectViewController : UIViewController {
    @IBOutlet weak var tfItemSearch: UITextField!
    
    var willSearchItem : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tfItemSearch.text = willSearchItem
    }
}
