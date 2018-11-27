//
//  RealmManager.swift
//  BlankSpaces
//
//  Created by Jordan Pichler on 27/11/2018.
//  Copyright © 2018 Jordan A. Pichler. All rights reserved.
//

import RealmSwift

class RealmManager {
    let realm = try! Realm()
    
    func save(_ event: LessonCompletionEvent) {
        try! realm.write {
            realm.add(event)
        }
    }
    
    func retrieveAll() -> [LessonCompletionEvent] {
        let results = realm.objects(LessonCompletionEvent.self)
        return Array(results)
    }
}
