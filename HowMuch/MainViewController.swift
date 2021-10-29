//
//  MainViewController.swift
//  HowMuch
//
//  Created by 심찬영 on 2021/10/19.
//

import UIKit

class MainViewController : UIViewController {
    // 검색 버튼
    @IBOutlet weak var btnImageSearch: UIButton!
    @IBOutlet weak var btnVoiceSearch: UIButton!
    
    // 품목 버튼
    @IBOutlet weak var btnFurniture: UIButton!
    @IBOutlet weak var btnKitchen: UIButton!
    @IBOutlet weak var btnLife: UIButton!
    @IBOutlet weak var btnAir: UIButton!
    @IBOutlet weak var btnWorkout: UIButton!
    @IBOutlet weak var btnBaby: UIButton!
    @IBOutlet weak var btnElectonic: UIButton!
    @IBOutlet weak var btnETC: UIButton!
    
    
    
    override func viewDidLoad() {
        // 내비게이션 백버튼 숨김
        navigationItem.hidesBackButton = true
  
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "pwd")
        
        print("로그아웃 되었습니다.")
        print("UserDefault Account Data Removed!!!")
    }
    
}
