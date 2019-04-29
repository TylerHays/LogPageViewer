//
//  PageViewSet.swift
//  LogPageViewer
//
//  Created by Tyler Hays on 4/26/19.
//  Copyright © 2019 Tyler Hays. All rights reserved.
//

import Foundation

class PageViewSet {
    
    let pagesViews: [String]
    
    var count: Int = 0
    
    init(pagesViews: [String], startingCount: Int) {
        self.pagesViews = pagesViews
        self.count = startingCount
    }
}


