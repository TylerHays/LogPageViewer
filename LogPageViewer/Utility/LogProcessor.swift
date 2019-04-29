//
//  LogProcessor.swift
//  LogPageViewer
//
//  Created by Tyler Hays on 4/26/19.
//  Copyright © 2019 Tyler Hays. All rights reserved.
//

import Foundation

class LogProcessor {
    
    
    static func processLogs(_ logs:String) -> [PageViewSet]{
        
        //Break the entries down to page views per user in order.
        let entries = seperatedLogFileInMultipleLogs(logs)
        let userPageViews = getUserPageViews(from: entries)
        let userList = createUsers(from: userPageViews)
        
        //Create sets of 3 pages view per user
        var usersPageViewSets: [[String]] = []
        for user in userList {
            let userpageViews = user.getPageViewSets()
            usersPageViewSets.append(contentsOf: userpageViews)
        }
        
        
        var viewSetCount: [PageViewSet] = []
        let pageCount = usersPageViewSets.reduce(into: [:]) { counts, pageSets in counts[pageSets, default: 0] += 1 }
        for count in pageCount {
            let pageSet = PageViewSet(pagesViews: count.key, startingCount: count.value)
            viewSetCount.append(pageSet)
        }
        let sortedPage = viewSetCount.sorted{$0.count > $1.count}
        return sortedPage
    }

    static func seperatedLogFileInMultipleLogs(_ logs: String) -> [String] {
        let logList = logs.components(separatedBy: "\n")
        return logList.filter({!$0.isEmpty})
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
