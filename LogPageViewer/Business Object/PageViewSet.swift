//
//  PageViewSet.swift
//  LogPageViewer
//
//  Created by Tyler Hays on 4/26/19.
//  Copyright © 2019 Tyler Hays. All rights reserved.
//

import Foundation

class PageViewSet {
    
    let setCount: Int
    
    let page1: String
    let page2: String
    let page3: String

    
    /// page set is consider 3 pages
    ///
    /// - Parameters:
    ///   - page1: first page
    ///   - page2: second page
    ///   - page3: third page
    ///   - setCount: number of times this page set appeared
    init(page1: String, page2: String, page3:String , setCount: Int) {
        self.page1 = page1
        self.page2 = page2
        self.page3 = page3
        self.setCount = setCount
    }
}


