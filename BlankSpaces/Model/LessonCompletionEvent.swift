//
//  LessonCompletionEvent.swift
//  BlankSpaces
//
//  Created by Jordan Pichler on 27/11/2018.
//  Copyright © 2018 Jordan A. Pichler. All rights reserved.
//

import RealmSwift

class LessonCompletionEvent: Object {
    @objc dynamic var id = 0
    @objc dynamic var startTime: Date? = nil
    @objc dynamic var endTime: Date? = nil
    
    convenience init(id: Int, startTime: Date?, endTime: Date?) {
        self.init()
        
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
    }
}
