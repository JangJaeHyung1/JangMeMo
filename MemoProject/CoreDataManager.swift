//
//  CoreDataManager.swift
//  MemoProject
//
//  Created by jh on 2021/01/17.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager{
    static let shared: CoreDataManager = CoreDataManager()
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "MemoData"
    
    func getItems(ascending: Bool = false) ->[MemoData]{
        var models: [MemoData] = [MemoData]()
        
        if let context = context{
            let dateSort: NSSortDescriptor = NSSortDescriptor(key:"date", ascending: ascending)
            let fetchRequset: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: modelName)
            fetchRequset.sortDescriptors = [dateSort]
            
            do{
                if let fetchResult:[MemoData] = try context.fetch(fetchRequset) as? [MemoData] {
                    models = fetchResult
                }
            }catch let error as NSError{
                print("Could not fetch: \(error), \(error.userInfo)")
            }
        }
        return models
    }
    
    func saveItem(content: String, date: Date, onSuccess: @escaping ((Bool) -> Void) ){
        if let context = context,
           let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: modelName, in: context){
            if let memo:MemoData = NSManagedObject(entity: entity, insertInto: context) as? MemoData {
                memo.content = content
                memo.date = date
                
                contextSave { success in
                    onSuccess(success)
                }
            }
        }
    }
    
    func deleteItem(content: String, onSuccess: @escaping ((Bool) -> Void) ){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest(content: content)
        
        do{
            if let results:[MemoData] = try context?.fetch(fetchRequest) as? [MemoData] {
                if results.count != 0{
                    context?.delete(results[0])
                }
            }
        }catch let error as NSError {
            print("Could not fatch: \(error), \(error.userInfo)")
            onSuccess(false)
        }
        
        contextSave { success in
            onSuccess(success)
        }
    }
}



extension CoreDataManager {
    fileprivate func filteredRequest(content: String) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
            = NSFetchRequest<NSFetchRequestResult>(entityName: modelName)
        fetchRequest.predicate = NSPredicate(format: "content = %@", NSString(string: content))
        return fetchRequest
    }
    
    fileprivate func contextSave(onSuccess: ((Bool) -> Void)) {
        do {
            try context?.save()
            onSuccess(true)
        } catch let error as NSError {
            print("Could not save: \(error), \(error.userInfo)")
            onSuccess(false)
        }
    }
}
