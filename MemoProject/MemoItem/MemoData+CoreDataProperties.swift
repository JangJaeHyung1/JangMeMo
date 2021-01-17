//
//  MemoData+CoreDataProperties.swift
//  MemoProject
//
//  Created by jh on 2021/01/17.
//
//

import Foundation
import CoreData


extension MemoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoData> {
        return NSFetchRequest<MemoData>(entityName: "MemoData")
    }

    @NSManaged public var content: String?
    @NSManaged public var date: Date?

}

extension MemoData : Identifiable {

}
