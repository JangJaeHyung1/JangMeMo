//
//  Model.swift
//  MemoProject
//
//  Created by jh on 2021/01/16.
//

import Foundation

class Memo{
    var content: String
    var insertDate: Date
    
    init(content: String) {
        self.content = content
        insertDate = Date()
    }
    static var dummyMemoList = [
        Memo(content: "Lorem Ipsum"),
        Memo(content: "Dolar Amet")
    ]
}
