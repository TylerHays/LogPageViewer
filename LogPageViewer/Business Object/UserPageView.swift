//
//  UserPageView.swift
//  LogPageViewer
//
//  Created by Tyler Hays on 4/26/19.
//  Copyright © 2019 Tyler Hays. All rights reserved.
//

import UIKit

class UserPageView: NSObject {
    var user: String
    var pageView: String
    
    init(user: String, pageView: String){
        self.user = user
        self.pageView = pageView
        super.init()
    }
}
