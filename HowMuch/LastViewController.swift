//
//  LastViewController.swift
//  HowMuch
//
//  Created by 심찬영 on 2021/11/28.
//

import UIKit

class LastViewController : UIViewController {
    
    @IBOutlet weak var curItem: UILabel!
    @IBOutlet weak var tfLength: UITextField!
    
    var selectedItem : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        curItem.text = selectedItem
        
    }
    
    @IBAction func changeFlushDate(_ sender: Any) {
        let datePickerView = sender as! UIDatePicker
        
        // DateFormatter 클래스 상수 선언
        let formatter = DateFormatter()
        
        // formatter의 dateFormat 속성을 설정
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"

        // 데이트 피커에서 선택한 날짜를 format에서 설정한 포맷대로 string 메서드를 사용하여 문자열(String)로 변환
        print("선택시간 :  + \(formatter.string(from: datePickerView.date))")
        
        
        
    }
    
    @IBAction func lengthMeasureClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "showLengthMeasure", sender: self)
    }
    
    @IBAction func priceCalClicked(_ sender: Any) {
        
        
    }
    
    // unwind segue 사용하기 위한 메소드
    @IBAction func unwindLastView(_ segue: UIStoryboardSegue) {
        
        if let from = segue.source as? ARViewController { tfLength.text = from.length }
    }
    
    // 여백 터치 시 키보드 내려가도록 하는 코드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
