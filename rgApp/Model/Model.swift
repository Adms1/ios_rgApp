
import Foundation
import UIKit

class DashboardModel: Decodable {
	let id : String?
	let title : String?
	let image : String?
    let menu_link : String?

    init(id:String, title:String,image:String, menu_link:String)
    {
        self.id = id
        self.title = title
        self.image = image
        self.menu_link = menu_link
    }

}
class DashboardListResultsModel: Decodable {
    var results = [DashboardModel]()
    init(results: [DashboardModel]) {
        self.results = results
    }
}

class CommentModel: Decodable {
    let id : String?
    let title : String?
    let image : String?
    let commentedBy : String?
    let date : String?
    var documents = [DocumentCommentModel]()

    init(id:String, title:String,image:String, commentedBy:String, date:String, documents : [DocumentCommentModel])
    {
        self.id = id
        self.title = title
        self.image = image
        self.commentedBy = commentedBy
        self.date = date
        self.documents = documents
    }
}

class CommentListResultsModel: Decodable {
    var results = [CommentModel]()
    init(results: [CommentModel]) {
        self.results = results
    }
}

class DocumentCommentModel: Decodable {
    let documentURL : String?
    let documentType : String?
    let documentTitle : String?
    var isAdded : String?

    init(documentURL:String, documentType:String, documentTitle:String, isAdded:String)
    {
        self.documentURL = documentURL
        self.documentType = documentType
        self.documentTitle = documentTitle
        self.isAdded = isAdded
    }
}
