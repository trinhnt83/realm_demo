//
//  BookTableViewCell.swift
//  RealmDemo
//
//  Created by Trinh Nguyen on 2024/06/17.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    private var onToggleCompleted: ((BookItem) -> Void)?
    private var book: BookItem?

    // Show book detail on cell
    func configureWith(_ book: BookItem, onToggleCompleted: ((BookItem) -> Void)? = nil) {
        self.book = book
        self.onToggleCompleted = onToggleCompleted
        self.textLabel?.text = book.name
        self.accessoryType = book.isCompleted ? .checkmark : .none
    }
    
    func toggleCompleted() {
        guard let book = book else { fatalError("Book not found") }
        
        onToggleCompleted?(book)
    }
}
