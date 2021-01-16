//
//  CreateMemoViewController.swift
//  MemoProject
//
//  Created by jh on 2021/01/16.
//

import UIKit

class CreateMemoViewController: UIViewController {
    @IBOutlet weak var memoContent: UITextView!
    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func Save(_ sender: UIBarButtonItem) {
        let memo = memoContent.text
        let newMemo = Memo.init(content: memo ?? " ")
        Memo.dummyMemoList.append(newMemo)
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
