//
//  LogProcessor.swift
//  LogPageViewer
//
//  Created by Tyler Hays on 4/26/19.
//  Copyright © 2019 Tyler Hays. All rights reserved.
//

import Foundation

class LogProcessor {
    
    
    /// Takes a log file and breaks it down into pages sets of users.
    ///
    /// - Parameter logs: logs where each entry is a single part of the array
    /// - Returns: sets of pages in order of greats to smallest
    static func processLogEntries(_ logEntries:[String]) -> [PageViewSet]{
        
        //Break the entries down to page views per user in order.
        let userPageViews = getUserPageViews(from: logEntries)
        let userList = createUsers(from: userPageViews)
        
        var tempTest: [String] = []
        
        //Create sets of 3 pages view per user
        var usersPageViewSets: [[String]] = []
        for user in userList {
            let userpageViews = user.getPageViewSets()
            usersPageViewSets.append(contentsOf: userpageViews)
            tempTest.append(contentsOf: user.pagesViews)
            
        }
  
        var viewSetCount: [PageViewSet] = []
        
        //takes the master list of pagesets and breaks them down into set with count of how many times it appears. 
        let pageCount = usersPageViewSets.reduce(into: [:]) { counts, pageSets in counts[pageSets, default: 0] += 1 }
        for count in pageCount {
            let pages = count.key
            let pageSet = PageViewSet.init(page1: pages[0], page2: pages[1], page3: pages[2], setCount: count.value)
            viewSetCount.append(pageSet)
        }
        let sortedPage = viewSetCount.sorted{$0.setCount > $1.setCount}
        
        return sortedPage
    }
    
   static func getUserPageViews(from logs: [String]) -> [UserPageView] {
        var userPageViews: [UserPageView] = []
        for log in logs {
            let userPage = getUserAndPage(log: log)
            let userPageView = UserPageView(user: userPage.user, pageView: userPage.pageVisited)
            userPageViews.append(userPageView)
        }
        
        return userPageViews
    }
    
    static func createUsers(from usersPagesViews: [UserPageView]) -> [User] {
        var users: [User] = []
        let userIds: Set<String> = Set(usersPagesViews.map{$0.user})
        for userId in userIds {
            let filterPageViews = usersPagesViews.filter{$0.user == userId}
            let pageViews: [String] = filterPageViews.map{$0.pageView}
            
            let user = User(userName: userId, pagesViews: pageViews)
            users.append(user)
        }
        
        return users
    }
    
    //My gut is telling me there is a better way of doing this other than brute force
   static func getUserAndPage(log: String) -> (user: String, pageVisited:String) {
        let splitLog = log.components(separatedBy: " - - ")
        let user = splitLog[0]
        let pageName = getPageVisited(log: log)
        return (user, pageName)
    }
    
    private static func getPageVisited(log: String) -> String {
        let splitLog = log.components(separatedBy: " - - ")
        guard splitLog.count > 1 else {
            return ""
        }
        
        let logSplit2 = splitLog[1].components(separatedBy: " \"GET ")
        guard logSplit2.count > 1 else {
            return ""
        }
        let finalSplit = logSplit2[1].components(separatedBy: " HTTP")
        return finalSplit[0]
    }
}
