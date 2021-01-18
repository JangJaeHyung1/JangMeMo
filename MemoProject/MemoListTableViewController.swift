//
//  MemoListTableViewController.swift
//  MemoProject
//
//  Created by jh on 2021/01/16.
//

import UIKit
import CoreData

class MemoListTableViewController: UITableViewController {

    private var memos = [MemoData]()
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .none
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell){
            let target = memos[indexPath.row]
            
            if let vc = segue.destination as? DetailViewController{
                vc.memo = target
            }
        }
    }
    
    // MARK: - Core Data Manage

    fileprivate func getAllMemos(){
        memos = CoreDataManager.shared.getItems()

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllMemos()
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return Memo.dummyMemoList.count
        return memos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

//        let target = Memo.dummyMemoList[indexPath.row]
        let target = memos[indexPath.row]
        cell.textLabel?.text = target.content
        cell.detailTextLabel?.text = formatter.string(for: target.date)

        return cell
    }
    

}
