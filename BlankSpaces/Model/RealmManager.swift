//
//  RealmManager.swift
//  BlankSpaces
//
//  Created by Jordan Pichler on 27/11/2018.
//  Copyright © 2018 Jordan A. Pichler. All rights reserved.
//

import RealmSwift

class RealmManager {
    
    static let sharedInstance = RealmManager()
    private let realm = try! Realm()
    
    /// Saves the given LessonCompletionEvent to the Realm DB
    func save(_ event: LessonCompletionEvent) {
        try! realm.write {
            realm.add(event)
        }
    }
    
    /// Retrieves all stored LessonCompletionEvents stored 
    func retrieveAll() -> [LessonCompletionEvent] {
        let results = realm.objects(LessonCompletionEvent.self)
        return Array(results)
    }
}
