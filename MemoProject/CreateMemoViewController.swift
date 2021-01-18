//
//  CreateMemoViewController.swift
//  MemoProject
//
//  Created by jh on 2021/01/16.
//

import UIKit
import CoreData


protocol SendDataDelegate {
    func sendData(data: MemoData)
}

class CreateMemoViewController: UIViewController {
    var delegate: SendDataDelegate?
    var memo: MemoData?
    var getDate: Date?
    var flag = 0
    @IBOutlet weak var memoContent: UITextView!
    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func Save(_ sender: UIBarButtonItem) {
        let content = memoContent.text
        let newMemo = Memo.init(content: content ?? " ")
        if flag == 0 {
            saveNewMemo(newMemo.content, date: newMemo.insertDate)
        }else{
            if let date = memo?.date {
                deleteMemo(date)
            }
            saveNewMemo(newMemo.content, date: newMemo.insertDate)
            getDate = newMemo.insertDate
            delegate?.sendData(data: CoreDataManager.shared.getItem(date: newMemo.insertDate))
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flag = 0
        if let item = memo {
            memoContent.text = item.content
            flag = 1
        }
        // Do any additional setup after loading the view.
    }
    
    
    fileprivate func deleteMemo(_ date: Date) {
        CoreDataManager.shared.deleteItem(date: date)  { onSuccess in
            print("deleted = \(onSuccess)")
        }
    }
    
    fileprivate func saveNewMemo(_ content:String, date:Date){
        CoreDataManager.shared.saveItem(content: content, date: date) { onSuccess in
            print("saved = \(onSuccess)")
            
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
