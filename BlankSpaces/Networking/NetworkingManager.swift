//
//  NetworkingManager.swift
//  BlankSpaces
//
//  Fetches lesson data from a server and parses the response to Lesson objects.
//
//  Created by Jordan Pichler on 21/11/2018.
//  Copyright © 2018 Jordan A. Pichler. All rights reserved.
//

import Alamofire

typealias CompletionHandler = ([Lesson]) -> Void

class NetworkingManager {
    private let url = "https://mimochallenge.azurewebsites.net/api/lessons"
    
    /// Downloads all lessons from Server and calls completion handler with results
    func fetchLessons(completion: @escaping CompletionHandler)  {
        Alamofire.request(url).responseData { response in
            var lessons = [Lesson]()
            if let data = response.result.value,
                let decodedResult = self.decodeLessons(from: data) {
                    // Convert raw server data to more usable Lesson array
                    decodedResult.lessons.forEach {
                        lessons.append(Lesson(rawLesson: $0))
                    }
                }
            completion(lessons)
        }
    }
    
    /// Parses to the 1:1 Server Model natively
    fileprivate func decodeLessons(from data: Data) -> RawServerResponse? {
        var rawObject: RawServerResponse?
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            rawObject = try decoder.decode(RawServerResponse.self, from: data)
        } catch let error {
            print(error)
        }
        
        return rawObject
    }
}
