//
//  Help Files.swift
//  Chat
//
//  Created by Bhargav on 03/12/20.
//  Copyright © 2019 BHARGAV. All rights reserved.
//

import UIKit

class DashboardViewModel: NSObject {
    let id : String?
    let title : String?
    let image : String?
    let menu_link : String?

    init(Item:DashboardModel){
        self.id = Item.id
        self.title = Item.title
        self.image = Item.image
        self.menu_link = Item.menu_link
    }
}
class CommentViewModel: NSObject {
    let id : String?
    let title : String?
    let image : String?
    let commentedBy : String?
    let date : String?
    var documents = [DocumentCommentModel]()

    init(Item:CommentModel){
        self.id = Item.id
        self.title = Item.title
        self.image = Item.image
        self.commentedBy = Item.commentedBy
        self.date = Item.date
        self.documents = Item.documents
    }
}
