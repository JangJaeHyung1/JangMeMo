//
//  DetailViewController.swift
//  MemoProject
//
//  Created by jh on 2021/01/16.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UITableViewDataSource, SendDataDelegate {
    func sendData(data: MemoData) {
        memo = data
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var memo: MemoData?
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .medium
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
            cell.textLabel?.text = formatter.string(for: memo?.date)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
            cell.textLabel?.text = memo?.content
            return cell
        default:
            fatalError()
        }
    }
    @IBAction func btnDelete(_ sender: UIBarButtonItem) {
        if let date = memo?.date {
            deleteMemo(date)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    fileprivate func deleteMemo(_ date: Date) {
        CoreDataManager.shared.deleteItem(date: date)  { onSuccess in
            print("deleted = \(onSuccess)")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? CreateMemoViewController {
            vc.memo = memo
            vc.delegate = self
        }
    }
    

}
