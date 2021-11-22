//
//  MainViewController.swift
//  HowMuch
//
//  Created by 심찬영 on 2021/10/19.
//

import UIKit
import Alamofire

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
    
    var curType : String = ""
    
    
    override func viewDidLoad() {
        // 내비게이션 백버튼 숨김
        navigationItem.hidesBackButton = true

        self.navigationItem.title = "강원도 원주시"
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: nil, action: nil)
    }
    
    
    @IBAction func imageSearchClicked(_ sender: Any) {
//        performSegue(withIdentifier: "showCamera", sender: self)
        performSegue(withIdentifier: "showImageRecognize", sender: self)
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "pwd")
        
        print("로그아웃 되었습니다.")
        print("UserDefault Account Data Removed!!!")
    }

    @IBAction func funitureClicked(_ sender: Any) {
        curType = (btnFurniture.titleLabel?.text)!
        performSegue(withIdentifier: "showItemSelect", sender: self)
    }
    
    @IBAction func kitchenClicked(_ sender: Any) {
        curType = (btnKitchen.titleLabel?.text)!
        performSegue(withIdentifier: "showItemSelect", sender: self)
    }
    
    @IBAction func lifeClicked(_ sender: Any) {
        curType = (btnLife.titleLabel?.text)!
        performSegue(withIdentifier: "showItemSelect", sender: self)
    }
    
    @IBAction func airClicked(_ sender: Any) {
        curType = (btnAir.titleLabel?.text)!
        performSegue(withIdentifier: "showItemSelect", sender: self)
    }
    
    @IBAction func etcClicked(_ sender: Any) {
        curType = (btnETC.titleLabel?.text)!
        performSegue(withIdentifier: "showItemSelect", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        guard let nextViewController : ItemSelectViewController = segue.destination as? ItemSelectViewController else {
            print("1")
            return
        }
        
        guard let sender = sender as? MainViewController else {
            print("2")
            return
        }

        nextViewController.curKind = sender.curType
    }
    
}
