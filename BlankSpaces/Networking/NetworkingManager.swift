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

class NetworkingManager {
    private let url = "https://mimochallenge.azurewebsites.net/api/lessons"
    
    func fetchLessons()  {
        Alamofire.request(url).responseData { response in
            guard let data = response.result.value,
                let decodedResult = self.decodeLessons(from: data) else {
                    return
                }
            
            // Convert to Lesson array
            var lessons = [Lesson]()
            decodedResult.lessons.forEach {
                lessons.append(Lesson(rawLesson: $0))
            }
        }
    }
    
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
