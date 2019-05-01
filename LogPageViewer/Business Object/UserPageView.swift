//
//  UserPageView.swift
//  LogPageViewer
//
//  Created by Tyler Hays on 4/26/19.
//  Copyright © 2019 Tyler Hays. All rights reserved.
//

import UIKit


/// User page view pairing
class UserPageView {
    var user: String
    var pageView: String
    
    
    /// creates the pair of a user and a page view
    ///
    /// - Parameters:
    ///   - user: user id
    ///   - pageView: page being viewed.
    init(user: String, pageView: String){
        self.user = user
        self.pageView = pageView
    }
}
