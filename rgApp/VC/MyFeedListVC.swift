//
//  MyFeedListVC.swift
//  rgApp
//
//  Created by ADMS on 28/07/21.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON
import AVFoundation
import AVKit
import FBSDKShareKit
import TwitterCore
import TwitterKit

class MyFeedListVC: UIViewController , ActivityIndicatorPresenter{

    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()


    @IBOutlet weak var tblFeed:UITableView!
    @IBOutlet weak var btnBack:UIButton!
    @IBOutlet weak var lblTitle:UILabel!


    @IBOutlet weak var btnFacebook:UIButton!
    @IBOutlet weak var btnWhatsApp:UIButton!
    @IBOutlet weak var btnTwitter:UIButton!
    @IBOutlet weak var btnAll:UIButton!

    @IBOutlet weak var vwShareSocial:UIView!

    var documentIC:UIDocumentInteractionController!

    var isLoginScreen:String = ""


    var objectsToShare:UIImage!
    var shareTitle:String!
    var shareAll:Array<Any>!

    var strTitle   = ""
    var strLoadUrl   = ""
    var isBackShow   = ""

    var shareIndexPath:Int = -1

    var arrMyFeedList = [arrMyFeed]()

    //    let arrTitle = ["Karyakartas  throughout Delhi are now using the NaMo App to share, connect & grow the #NaMoAppAbhiyan","Karyakartas  throughout Delhi are now using","Karyakartas  throughout Delhi are now using the NaMo App to share, connect"]


    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)


        lblTitle.text = "\(strTitle)"
        tblFeed.register(UINib(nibName: "RGPostCell", bundle: nil), forCellReuseIdentifier: "RGPostCell")

        // self.tblFeed.backgroundColor = .lightGray

        self.tblFeed.estimatedRowHeight = 369.0
        self.tblFeed.rowHeight = UITableView.automaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        callApiMyFeed()
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.vwShareSocial.isHidden = true
    }

    @IBAction func btnClickFacebook(_sender:UIButton)
    {
        self.vwShareSocial.isHidden = true
        shareTextOnFaceBook()
    }
    @IBAction func btnClickWhatsapp(_sender:UIButton)
    {

        self.vwShareSocial.isHidden = true

        let urlWhats = "whatsapp://app"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL) {

                    if let image = objectsToShare {
                        if let imageData = image.jpegData(compressionQuality: 1.0) {
                            let tempFile = NSURL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/whatsAppTmp.wai")
                            do {
                                try imageData.write(to: tempFile!, options: .atomic)

                                self.documentIC = UIDocumentInteractionController(url: tempFile!)
                                self.documentIC.uti = "net.whatsapp.image"
                                self.documentIC.presentOpenInMenu(from: CGRect.zero, in: self.view, animated: true)

                                let indexpath = IndexPath(row: shareIndexPath, section: 0)

                                print("share post id",arrMyFeedList[indexpath.row].SocialMediaPostUserID)
                                print("share indexpath",indexpath)

                                callShareApi(index: indexpath, postID: arrMyFeedList[indexpath.row].SocialMediaPostUserID)

                            }
                            catch {
                                print(error)
                            }
                        }
                    }

                } else {
                    // Cannot open whatsapp
                }
            }
        }

    }
    @IBAction func btnClickTwitter(_sender:UIButton)
    {
        self.vwShareSocial.isHidden = true

        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter)
        {

            let indexpath = IndexPath(row: shareIndexPath, section: 0)

            print("share post id",arrMyFeedList[indexpath.row].SocialMediaPostUserID)
            print("share indexpath",indexpath)

            callShareApi(index: indexpath, postID: arrMyFeedList[indexpath.row].SocialMediaPostUserID)


            self.vwShareSocial.isHidden = true
            let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            vc?.setInitialText(shareTitle!)
            vc?.add(objectsToShare)
            present(vc!, animated: true, completion: nil)

        } else {
            let alert = UIAlertController(title: "", message: "No app found", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    @IBAction func btnClickAll(_sender:UIButton)
    {
        self.vwShareSocial.isHidden = true

        let activityViewController = UIActivityViewController(activityItems:shareAll
                                                              , applicationActivities: nil)
        //        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.postToTwitter]

        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: {
            self.vwShareSocial.isHidden = true
        })

    }
    @IBAction func btnClickBack(_sender:UIButton)
    {

        if isLoginScreen == "MyFeedListVC"
        {
            self.navigationController?.popToRootViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }

    }
}

extension MyFeedListVC:SharingDelegate
{
    func shareTextOnFaceBook() {
        // Same as previous session
        // let image = UIImage(named: "AppIcon")!
        let photo = SharePhoto(image: objectsToShare, userGenerated: true)
        let photoContent = SharePhotoContent()
        photoContent.photos = [photo]
        //  photoContent.hashtag = Hashtag("#fooHashTag")

        // Share the content (photo) as a dialog with News Feed / Story
        let sharingDialog = ShareDialog(fromViewController: self, content: photoContent, delegate: self)
        sharingDialog.show()

    }

    func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
        self.vwShareSocial.isHidden = true
        let indexpath = IndexPath(row: shareIndexPath, section: 0)

        print("share post id",arrMyFeedList[indexpath.row].SocialMediaPostUserID)
        print("share indexpath",indexpath)

        callShareApi(index: indexpath, postID: arrMyFeedList[indexpath.row].SocialMediaPostUserID)
    }
    func sharer(_ sharer: Sharing, didFailWithError error: Error) {
        print("Share: Fail")
    }
    func sharerDidCancel(_ sharer: Sharing) {
        print("Share: Cancel")
    }


}
extension MyFeedListVC:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMyFeedList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RGPostCell", for: indexPath) as! RGPostCell

        // cell.contentView.backgroundColor = .lightGray
        cell.selectionStyle = .none
        cell.lblTitle.text = arrMyFeedList[indexPath.row].PostTitle
        cell.lblDesc.text = arrMyFeedList[indexPath.row].PostDescription
        cell.lblDate.text = arrMyFeedList[indexPath.row].PostCreateDate
        cell.lblLikeCount.text = "\(arrMyFeedList[indexPath.row].Like_Count)"
        cell.lblshareCount.text = "\(arrMyFeedList[indexPath.row].Share_Count)"



        cell.lblComment.text  = "\(arrMyFeedList[indexPath.row].Comment_Count)"
        cell.feedImg.sd_setImage(with: URL(string: API.imageUrl + arrMyFeedList[indexPath.row].PostImage))
        cell.myFeedVw.layer.cornerRadius = 6.0
        cell.myFeedVw.layer.masksToBounds = true

        cell.myFeedVw.backgroundColor = .white
        //        cardView.layer.cornerRadius = 10.0
        cell.myFeedVw.layer.shadowColor = UIColor.gray.cgColor
        cell.myFeedVw.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cell.myFeedVw.layer.shadowRadius = 6.0
        cell.myFeedVw.layer.shadowOpacity = 0.7

        cell.btnShare.tag = indexPath.row
        cell.btnLike.tag = indexPath.row
        cell.btnComment.tag = indexPath.row
        cell.btnLikeList.tag = indexPath.row
        cell.btnLike.addTarget(self, action: #selector(likeBtnClick), for: .touchUpInside)
        cell.btnLikeList.addTarget(self, action: #selector(likeBtnListClick), for: .touchUpInside)

        cell.btnShare.addTarget(self, action: #selector(shareBtnClick), for: .touchUpInside)
        cell.btnComment.addTarget(self, action: #selector(commentBtnClick), for: .touchUpInside)

        //        if arrMyFeedList[indexPath.row].Islike == true
        //        {
        //            cell.imageLike.image = UIImage(named: "likeee.png")
        //        }else{
        //            cell.imageLike.image  = UIImage(named: "like.png")
        //        }

        if arrMyFeedList[indexPath.row].Islike == true
        {
            cell.btnLike.setImage(UIImage(named: "likeee.png"), for: .normal)
        }else{
            cell.btnLike.setImage(UIImage(named: "like.png"), for: .normal)
        }


        //        let fileExtension = URL(string: API.imageUrl + arrMyFeedList[indexPath.row].PostImage)?.pathExtension
        //
        //        if fileExtension == "mp4"
        //        {
        //            cell.videoImg.isHidden = false
        //
        //            let url = URL(string: API.imageUrl + arrMyFeedList[indexPath.row].PostImage)!
        //
        //            if let thumbnailImage = getThumbnailImage(forUrl: url) {
        //                cell.feedImg.image = thumbnailImage
        //            }
        //        }else{
        //            cell.videoImg.isHidden = true
        //
        //
        //        }




        //        cell.middleLabel.text = items[indexPath.row]
        //        cell.leftLabel.text = items[indexPath.row]
        //        cell.rightLabel.text = items[indexPath.row]

        return cell

    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)

        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }

        return nil
    }

    @objc func commentBtnClick(sender:UIButton)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CommentVC") as! CommentVC
        vc.SocialMediaPostUserID = arrMyFeedList[sender.tag].SocialMediaPostUserID
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    @objc func likeBtnListClick(sender:UIButton)
    {

        if UserDefaults.standard.bool(forKey: "isUserLoggedIn") == true
        {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LikeVC") as! LikeVC
            vc.SocialMediaPostUserID = arrMyFeedList[sender.tag].SocialMediaPostUserID
            self.navigationController?.present(vc, animated: true, completion: nil)

        }else{

            let alertController = UIAlertController(title: "", message: "Do you want to login ?", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction!) in
                print("Ok button tapped");
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
                vc.isLoginScreen = "MyFeedListVC"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            alertController.addAction(OKAction)

            // Create Cancel button
            let cancelAction = UIAlertAction(title: "No", style: .cancel) { (action:UIAlertAction!) in
                print("Cancel button tapped");
            }
            alertController.addAction(cancelAction)

            // Present Dialog message
            self.present(alertController, animated: true, completion:nil)

            //            let alert = UIAlertController(title: "", message: "User does not logged in...", preferredStyle: UIAlertController.Style.alert)
            //            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            //            self.present(alert, animated: true, completion: nil)

        }


    }

    @objc func likeBtnClick(sender:UIButton)
    {
        if UserDefaults.standard.bool(forKey: "isUserLoggedIn") == true
        {
            let buttonPosition = sender.convert(CGPoint.zero, to: self.tblFeed)
            let indexPath = self.tblFeed.indexPathForRow(at:buttonPosition)

            callApiLike(index:indexPath!,postID: arrMyFeedList[indexPath!.row].SocialMediaPostUserID)

        }else{

            let alertController = UIAlertController(title: "", message: "Do you want to login ?", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction!) in
                print("Ok button tapped");
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
                vc.isLoginScreen = "MyFeedListVC"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            alertController.addAction(OKAction)

            // Create Cancel button
            let cancelAction = UIAlertAction(title: "No", style: .cancel) { (action:UIAlertAction!) in
                print("Cancel button tapped");
            }
            alertController.addAction(cancelAction)

            // Present Dialog message
            self.present(alertController, animated: true, completion:nil)

            //            let alert = UIAlertController(title: "", message: "User does not logged in...", preferredStyle: UIAlertController.Style.alert)
            //            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            //            self.present(alert, animated: true, completion: nil)

        }

        //

        // self.tblFeed.reloadRows(at: [indexPath!], with: .none)

    }


    @objc func shareBtnClick(sender:UIButton)
    {
        //        if arrMyFeedList[sender.tag].IsShare == false
        //        {

        if UserDefaults.standard.bool(forKey: "isUserLoggedIn") == true
        {
            let buttonPosition = sender.convert(CGPoint.zero, to: self.tblFeed)
            let indexPath = self.tblFeed.indexPathForRow(at:buttonPosition)

            if let indexpath = indexPath?.row {
                shareIndexPath = indexpath
            }


            let cell = self.tblFeed.cellForRow(at: indexPath!) as! RGPostCell

            cell.myFeedVw.frame = CGRect(x: cell.myFeedVw.frame.origin.x, y: cell.myFeedVw.frame.origin.y, width: cell.myFeedVw.frame.size.width, height: cell.myFeedVw.frame.size.height-32)


            UIGraphicsBeginImageContextWithOptions(cell.myFeedVw.bounds.size, false, UIScreen.main.scale)
            cell.myFeedVw.drawHierarchy(in: cell.myFeedVw.bounds, afterScreenUpdates: true)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            shareTitle = self.arrMyFeedList[sender.tag].PostTitle
            objectsToShare = cell.feedImg.image!

            //  let image = UIImage(contentsOfFile: "\(arrMyFeedList[sender.tag].PostImage)")
            shareAll = [image ?? objectsToShare] as [Any]

            self.tblFeed.reloadRows(at: [indexPath!], with: .none)

            DispatchQueue.main.async {
                self.vwShareSocial.isHidden = false
            }
        }else
        {

            let alertController = UIAlertController(title: "", message: "Do you want to login ?", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction!) in
                print("Ok button tapped");
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
                //  vc.SocialMediaPostUserID = arrMyFeedList[sender.tag].SocialMediaPostUserID
                vc.isLoginScreen = "MyFeedListVC"
                self.navigationController?.pushViewController(vc, animated: true)

            }
            alertController.addAction(OKAction)

            // Create Cancel button
            let cancelAction = UIAlertAction(title: "No", style: .cancel) { (action:UIAlertAction!) in
                print("Cancel button tapped");
            }
            alertController.addAction(cancelAction)

            // Present Dialog message
            self.present(alertController, animated: true, completion:nil)

            //            let alert = UIAlertController(title: "", message: "User does not logged in...", preferredStyle: UIAlertController.Style.alert)
            //            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            //            self.present(alert, animated: true, completion: nil)
        }
        //        }else{
        //            let alert = UIAlertController(title: "", message: "You have already share this post on social media platform", preferredStyle: UIAlertController.Style.alert)
        //            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        //            self.present(alert, animated: true, completion: nil)
        //
        //        }
    }
}

extension MyFeedListVC{
    func callApiMyFeed()
    {
        showActivityIndicator()
        arrMyFeedList.removeAll()
        //        let params = ["BoardID":strCategoryID1,"StandardID":"9","CourseTypeID": strCategoryID,"SubjectID":"1"]
        //      var params = ["":""]
        //        var result:[String:String] = [:]
        //       if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
        //       {
        //            result = UserDefaults.standard.value(forKey: "logindata") as! [String : String] //as! NSMutableDictionary
        //        }
        //       let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //
        //       params = ["StudentID":"\(result["StudentID"] ?? "")",
        //           "SubjectID":"","isCompetitive":"", "StandardID":"", "BoardID":"", "CourseID":""]
        //       }

        var params = [String:Any]()


        if UserDefaults.standard.value(forKey: "logindata") != nil
        {
            let dict = UserDefaults.standard.value(forKey: "logindata") as! [String : Any]

            if let userId = dict["UserID"]
            {
                print("login user",userId)
                params = ["UserID": userId]
            }

        }else
        {
            params = ["UserID": 0]
        }

        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        // Hide
        print("API, Params: \n",API.Get_Task)
        if !Connectivity.isConnectedToInternet() {
            //  self.AlertPopupInternet()

            // show Alert
            //  self.hideActivityIndicator()
            print("The network is not reachable")
            self.tblFeed.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.Get_Task, method: .get, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //Bhargav Hide
                print("mmp responce",json)

                if(json["status"] == "true") {
                    let arrData = json["data"].array
                    for value in arrData! {
                        let pckgDetModel:arrMyFeed = arrMyFeed.init(SocialMediaPostUserID: value["SocialMediaPostUserID"].intValue, PostName: value["PostName"].stringValue, PostTitle: value["PostTitle"].stringValue, PostImage: value["PostImage"].stringValue, PostDescription: value["PostDescription"].stringValue, PostCreateDate: value["PostCreateDate"].stringValue, Comment_Count: value["Comment_Count"].intValue,Share_Count: value["Share_Count"].intValue,Like_Count: value["Like_Count"].intValue,Islike: value["Islike"].boolValue,IsShare: value["IsShare"].boolValue,UserID: value["UserID"].intValue)
                        self.arrMyFeedList.append(pckgDetModel)
                    }
                    DispatchQueue.main.async {
                        self.tblFeed.reloadData()
                    }

                }
            case .failure(let error):
                self.hideActivityIndicator()

                if !Connectivity.isConnectedToInternet() {
                    //                   self.AlertPopupInternet()
                    //
                    //                   // show Alert
                    print("The network is not reachable")
                    // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
                    return
                }
                //  self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)

                //Bhargav Hide
                print(error)
            }
        }
    }




    func callApiLike(index:IndexPath,postID:Int)
    {
        // showActivityIndicator()
        var params = [String:Any]()

        if UserDefaults.standard.value(forKey: "logindata") != nil
        {
            let dict = UserDefaults.standard.value(forKey: "logindata") as! [String : Any]

            if let userId = dict["UserID"]
            {
                print("login user",userId)
                params = ["SocialMediaPostUserID":postID,"SocialMediaTypeID":1,"UserID": userId ,"ActionID":1,"Comments":""]
            }

        }

        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        // Hide
        print("API, Params: \n",API.AddPoint)
        if !Connectivity.isConnectedToInternet() {
            //  self.AlertPopupInternet()

            // show Alert
            //  self.hideActivityIndicator()
            print("The network is not reachable")
            self.tblFeed.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.AddPoint, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            //self.hideActivityIndicator()

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //Bhargav Hide
                print("mmp responce",json)

                if(json["status"] == "true") {

                    //                   let arrData = json["data"].array
                    //                    for value in arrData! {
                    //                        let pckgDetModel:arrMyFeed = arrMyFeed.init(SocialMediaPostUserID: value["SocialMediaPostUserID"].intValue, PostName: value["PostName"].stringValue, PostTitle: value["PostTitle"].stringValue, PostImage: value["PostImage"].stringValue, PostDescription: value["PostDescription"].stringValue, PostCreateDate: value["PostCreateDate"].stringValue, Comment_Count: value["Comment_Count"].intValue,Share_Count: value["Share_Count"].intValue,Like_Count: value["Like_Count"].intValue,Islike: value["Islike"].boolValue,IsShare: value["IsShare"].boolValue,UserID: value["UserID"].intValue)
                    //                        self.arrMyFeedList.append(pckgDetModel)
                    //                    }
                    let cell = self.tblFeed.cellForRow(at: index) as! RGPostCell

                    if self.arrMyFeedList[index.row].Islike == true
                    {
                        self.arrMyFeedList[index.row].Islike = false
                        self.arrMyFeedList[index.row].Like_Count = self.arrMyFeedList[index.row].Like_Count - 1
                        //                        cell.imageLike.image = UIImage(named: "like.png")
                        cell.btnLike.setImage(UIImage(named: "like.png"), for: .normal)


                    }else{
                        self.arrMyFeedList[index.row].Like_Count = self.arrMyFeedList[index.row].Like_Count + 1

                        self.arrMyFeedList[index.row].Islike = true
                        //                        cell.imageLike.image = UIImage(named: "likeee.png")
                        cell.btnLike.setImage(UIImage(named: "likeee.png"), for: .normal)

                    }
                    cell.lblLikeCount.text = "\(self.arrMyFeedList[index.row].Like_Count)"
                    //                    DispatchQueue.main.async {
                    //                        self.tblFeed.beginUpdates()
                    //                     //   self.tblFeed.reloadRows(at: [index], with: .none)
                    //                      //  self.view.layoutIfNeeded()
                    //                        self.tblFeed.endUpdates()
                    //
                    //                    }

                }
            case .failure(let error):
                if !Connectivity.isConnectedToInternet() {
                    print("The network is not reachable")
                    return
                }
                print(error)
            }
        }
    }


    func callShareApi(index:IndexPath,postID:Int)
    {
        // showActivityIndicator()
        var params = [String:Any]()

        if UserDefaults.standard.value(forKey: "logindata") != nil
        {
            let dict = UserDefaults.standard.value(forKey: "logindata") as! [String : Any]

            if let userId = dict["UserID"]
            {
                print("login user",userId)
                params = ["SocialMediaPostUserID":postID,"SocialMediaTypeID":1,"UserID": userId ,"ActionID":2,"Comments":""]
            }

        }

        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        // Hide
        print("API, Params: \n",API.AddPoint)
        if !Connectivity.isConnectedToInternet() {
            print("The network is not reachable")
            self.tblFeed.reloadData()
            return
        }

        Alamofire.request(API.AddPoint, method: .post, parameters: params, headers: headers).validate().responseJSON { response in

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //Bhargav Hide
                print("mmp responce",json)

                if(json["status"] == "true") {
                    let cell = self.tblFeed.cellForRow(at: index) as! RGPostCell

                    if self.arrMyFeedList[index.row].IsShare == true
                    {
                        self.arrMyFeedList[index.row].IsShare = false
                        //                        self.arrMyFeedList[index.row].Share_Count = self.arrMyFeedList[index.row].Share_Count - 1
                    }else{
                        self.arrMyFeedList[index.row].Share_Count = self.arrMyFeedList[index.row].Share_Count + 1

                        self.arrMyFeedList[index.row].IsShare = true
                    }
                    cell.lblshareCount.text = "\(self.arrMyFeedList[index.row].Share_Count)"
                    //                    DispatchQueue.main.async {
                    //                        self.tblFeed.reloadRows(at: [index], with: .none)
                    //                    }
                }
            case .failure(let error):
                if !Connectivity.isConnectedToInternet() {
                    print("The network is not reachable")
                    return
                }
                print(error)
            }
        }
    }

}
