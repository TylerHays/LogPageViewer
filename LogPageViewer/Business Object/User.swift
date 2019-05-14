//
//  User.swift
//  LogPageViewer
//
//  Created by Tyler Hays on 4/26/19.
//  Copyright © 2019 Tyler Hays. All rights reserved.
//

import UIKit

class User: NSObject {
    let userName: String
    let pagesViews: [String]
    
    
    /// creates a user with all of their pages that they viewed in order
    ///
    /// - Parameters:
    ///   - userName: user id
    ///   - pagesViews: lets of pages view by user in order
    init (userName: String, pagesViews:[String]) {
        self.userName = userName
        self.pagesViews = pagesViews
    }
    
    
    /// creates an array of sets of 3 of the pages a user viewed If there are no sets of three an empty array is returned
    ///
    /// - Returns: sets of 3 that the user view
    func getPageViewSets() -> [[String]] {
        var workingPageViewSet: [String] = []
        var setsOfPageViews: [[String]] = []
        
        for pageView in self.pagesViews {
            workingPageViewSet.append(pageView)
            if workingPageViewSet.count < 3 {
                continue
            }
            
             while workingPageViewSet.count > 3 {
                  workingPageViewSet.removeFirst()
            }
            
            setsOfPageViews.append(workingPageViewSet)
        }
        return setsOfPageViews
    }
}

extension User {
    static func createUserFromLogs(user:String, userPageView: [UserPageView]) -> User {
        let filterPageViews = userPageView.filter{$0.user == user}
        let pageViews: [String] = filterPageViews.map{$0.pageView}
        
        return User(userName: user, pagesViews: pageViews)
    }
}
