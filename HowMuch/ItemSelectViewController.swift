//
//  ItemSelectViewController.swift
//  HowMuch
//
//  Created by 심찬영 on 2021/11/09.
//

import UIKit

class ItemSelectViewController : UIViewController {
    @IBOutlet weak var tfItemSearch: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var list = ["1", "2", "3", "4" ,"5", "6", "7", "8", "9", "10"]
    
    var willSearchItem : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tfItemSearch.text = willSearchItem
    }
    
}

// cell data
extension ItemSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CSCollectionViewCell
        
        cell.backgroundColor = .lightGray
        cell.lbl.text = list[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(String( list[indexPath.item] ) + " 클릭됨")
    }
}

// cell layout
extension ItemSelectViewController: UICollectionViewDelegateFlowLayout {

    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width / 4 - 5 ///  3등분하여 배치, 옆 간격이 1이므로 1을 빼줌
        print("collectionView width=\(collectionView.frame.width)")
        print("cell하나당 width=\(width)")
        print("root view width = \(self.view.frame.width)")

        let size = CGSize(width: width, height: width)
        return size
    }
}

// custom cell
class CSCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet var lbl: UILabel!
}
