//
//  BookItem.swift
//  RealmDemo
//
//  Created by Trinh Nguyen on 2024/06/17.
//

import Foundation
import RealmSwift

@objcMembers class BookItem: Object {
    enum Property: String {
        case id, name, isCompleted
    }
    
    dynamic var id = UUID().uuidString
    dynamic var name = ""
    dynamic var isCompleted = false
    
    override static func primaryKey() -> String? {
        return BookItem.Property.id.rawValue
    }
    
    convenience init(_ name: String) {
        self.init()
        self.name = name
    }
    
    static func getAll(in realm: Realm = try! Realm()) -> Results<BookItem> {
        return realm.objects(BookItem.self)
            .sorted(byKeyPath: BookItem.Property.isCompleted.rawValue)
    }
    
    func delete() {
        guard let realm = realm else { return }
        try! realm.write {
            realm.delete(self)
        }
    }
    
    func toggleCompleted() {
        guard let realm = realm else { return }
        try! realm.write {
            isCompleted = !isCompleted
        }
    }
}

extension BookItem {
    static func add(name: String, in realm: Realm = try! Realm()) -> BookItem {
        let book = BookItem(name)
        try! realm.write {
            realm.add(book)
        }
        return book
    }
}
