
import Foundation
import UIKit



class TestModelData{
    var status:String
    var Msg:String
    var data:[arrMyFeed]

    init(status:String, Msg:String, data:[arrMyFeed]) {
        self.status = status
        self.Msg = Msg
        self.data = data
    }
}

class arrCommentList{
    var SocialMediaPostUserID:Int
    var Post_Title:String
    var Post_Image:String
    var Post_Comment:String
    var CreateDate:String
    var ProfilePhoto:String
    var UserName:String


    init(SocialMediaPostUserID:Int, Post_Title:String, Post_Image:String, Post_Comment:String, CreateDate:String,ProfilePhoto:String,UserName:String) {
        self.SocialMediaPostUserID = SocialMediaPostUserID
        self.Post_Title = Post_Title
        self.Post_Image = Post_Image
        self.Post_Comment = Post_Comment
        self.CreateDate = CreateDate
        self.ProfilePhoto = ProfilePhoto
        self.UserName = UserName

    }
}
class arrMyLike{
//    var CreateDate:String
    var Name:String
//    var IsActive:String

    init(Name:String) {
//        self.CreateDate = CreateDate
        self.Name = Name
//        self.IsActive = IsActive
    }
}

class arrMyNotification{
    var CreateDate:String
    var Title:String
    var IsActive:String

    init(CreateDate:String, Title:String, IsActive:String) {
        self.CreateDate = CreateDate
        self.Title = Title
        self.IsActive = IsActive
    }
}

class arrMyFeed{
    var SocialMediaPostUserID:Int
    var PostName:String
    var PostTitle:String
    var PostImage:String
    var PostDescription:String
    var PostCreateDate:String
    var Comment_Count:Int
    var Share_Count:Int
    var Like_Count:Int
    var Islike:Bool
    var IsShare:Bool
    var UserID:Int

    init(SocialMediaPostUserID:Int, PostName:String, PostTitle:String, PostImage:String, PostDescription:String,PostCreateDate:String,Comment_Count:Int,Share_Count:Int,Like_Count:Int,Islike:Bool,IsShare:Bool,UserID:Int) {
        self.SocialMediaPostUserID = SocialMediaPostUserID
        self.PostName = PostName
        self.PostTitle = PostTitle
        self.PostImage = PostImage
        self.PostDescription = PostDescription
        self.PostCreateDate = PostCreateDate
        self.Comment_Count = Comment_Count
        self.Share_Count = Share_Count
        self.Like_Count = Like_Count
        self.Islike = Islike
        self.IsShare = IsShare
        self.UserID = UserID
    }
}

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
