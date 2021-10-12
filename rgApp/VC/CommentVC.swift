//
//  CommentVC.swift
//  rgApp
//
//  Created by ADMS on 03/08/21.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON
import AVFoundation
import AVKit


class CommentVC: UIViewController , ActivityIndicatorPresenter{


    var SocialMediaPostUserID:Int = -1

    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var image_name:String = ""
    @IBOutlet weak var tblComment:UITableView!
    @IBOutlet weak var imgCollectionView:UICollectionView!

    var placeholderLabel : UILabel!


    @IBOutlet weak var txtComment:UITextView!
    @IBOutlet weak var btnCamera:UIButton!
    @IBOutlet weak var btnSendComment:UIButton!
    @IBOutlet weak var vwImgCollection:UIView!

    @IBOutlet weak var txtCommentHeight:NSLayoutConstraint!

    var picker = UIImagePickerController()
    var arrComment = [arrCommentList]()
    var arrCommList = [arrCommentList]()

   // var arr_Item = [URL]()
    var arr_Item = [UIImage]()


    override func viewDidLoad() {
        super.viewDidLoad()

        btnCamera.isHidden = true


        txtComment.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "Enter some text..."
//        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (txtComment.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        txtComment.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (txtComment.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !txtComment.text.isEmpty


        callApiMyCommentList()

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: 70, height: 70)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        imgCollectionView!.collectionViewLayout = layout

        imgCollectionView.isScrollEnabled = false
        tblComment.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")


        self.tblComment.estimatedRowHeight = 150.0
        self.tblComment.rowHeight = UITableView.automaticDimension

        // Do any additional setup after loading the view.
    }
    @IBAction func btnClickBack(_sender:UIButton)
    {
        // self.navigationController?.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }

//    func textViewDidChange(_ textView: UITextView) {
//    }

    @IBAction func btnClickCamera(_sender:UIButton)
    {
        // vwImgCollection.isHidden = false

        if arr_Item.count == 1
        {

        }else{
            let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
            let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default)
            {
                UIAlertAction in
                self.openCamera()
            }
            let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertAction.Style.default)
            {
                UIAlertAction in
                self.openGallary()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            {
                UIAlertAction in
            }

            // Add the actions
            picker.delegate = self
            alert.addAction(cameraAction)
            alert.addAction(gallaryAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)

        }
    }

    @IBAction func btnClickSendComment(_sender:UIButton)
    {
        if UserDefaults.standard.bool(forKey: "isUserLoggedIn") == true
        {
            let trimmed = txtComment.text.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.count != 0
            {
                if arr_Item.count == 0
                {
                    self.uploadCommentDataApi(filename: "")
                }else{
                    uploadCommentApi()
                }
            }else
            {
                txtComment.text = ""
            }
        }else{
            let alert = UIAlertController(title: "", message: "User does not logged in...", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
    }


    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            picker.sourceType = .camera
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }
        else
        {
            // Create the alert controller
            let alertController = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)

            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                //  NSLog("OK Pressed")
            }


            // Add the actions
            alertController.addAction(okAction)

            // Present the controller
            self.present(alertController, animated: true, completion: nil)


        }
    }
    func openGallary()
    {
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }

    
}
extension CommentVC:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCommList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell

       // arrCommList.reversed()
        cell.lblComment.text = arrCommList[indexPath.row].Post_Comment
        cell.lblDate.text = arrCommList[indexPath.row].CreateDate
        cell.lblTitle.text = arrCommList[indexPath.row].UserName
        let strFirstLetter = arrCommList[indexPath.row].UserName.uppercased()
       // arrCommList[indexPath.row].UserName
        let index = strFirstLetter.index(strFirstLetter.startIndex, offsetBy: 0)

        cell.lblFirstLater.text = String(strFirstLetter[index])

        // cell.contentView.backgroundColor = .lightGray
        cell.selectionStyle = .none

        cell.feedImg.layer.cornerRadius = cell.feedImg.frame.size.height / 2

        //        cell.feedImg.sd_setImage(with: URL(string: API.imageUrl + arrMyFeedList[indexPath.row].PostImage))

        cell.myFeedVw.layer.cornerRadius = 6.0
        cell.myFeedVw.layer.masksToBounds = true

        cell.myFeedVw.backgroundColor = .white
        //        cardView.layer.cornerRadius = 10.0
        cell.myFeedVw.layer.shadowColor = UIColor.gray.cgColor
        cell.myFeedVw.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cell.myFeedVw.layer.shadowRadius = 6.0
        cell.myFeedVw.layer.shadowOpacity = 0.7
        cell.uploadCommentImg.contentMode = .scaleToFill
        cell.uploadCommentImg.sd_setImage(with: URL(string: API.uploadCommentImage + arrCommList[indexPath.row].Post_Image))

        if arrCommList[indexPath.row].Post_Image != ""
        {
//            let ratio = cell.uploadCommentImg.frame.size.width / cell.uploadCommentImg.frame.size.height
//            let newHeight = cell.uploadCommentImg.frame.width * ratio
            cell.commentImageHeight.constant = 300

        }else{
            cell.commentImageHeight.constant = 0

        }


       // cell.btnShare.tag = indexPath.row
      //  cell.btnShare.addTarget(self, action: #selector(shareBtnClick), for: .touchUpInside)


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


    @objc func imagecommentBtnClick(sender:UIButton)
    {
        self.btnCamera.isEnabled = true
        arr_Item.removeAll()

        //        let buttonPosition = sender.convert(CGPoint.zero, to: self.imgCollectionView)
        //        let indexPath = self.imgCollectionView.indexPathForItem(at: buttonPosition)

        // arr_Item.remove(at: indexPath?.row ?? 0)
        //  let cell = self.imgCollectionView.cellForItem(at: indexPath!) as! imageCollectionCell

        DispatchQueue.main.async {
            self.imgCollectionView.reloadData()
            self.vwImgCollection.isHidden = true
        }



    }
    @objc func shareBtnClick(sender:UIButton)
    {

        //
        //
        //
        //        let alert = UIAlertController(title: "Title", message: "Please Select an Option", preferredStyle: .actionSheet)
        //
        //        alert.addAction(UIAlertAction(title: "WhatsApp", style: .default , handler:{ (UIAlertAction)in
        //            print("User click Approve button")
        //        }))
        //
        //        alert.addAction(UIAlertAction(title: "More", style: .default , handler:{ (UIAlertAction)in
        //            print("User click More button")


        let buttonPosition = sender.convert(CGPoint.zero, to: self.tblComment)
        let indexPath = self.tblComment.indexPathForRow(at:buttonPosition)

        let cell = self.tblComment.cellForRow(at: indexPath!) as! CommentCell

        cell.myFeedVw.frame = CGRect(x: cell.myFeedVw.frame.origin.x, y: cell.myFeedVw.frame.origin.y, width: cell.myFeedVw.frame.size.width, height: cell.myFeedVw.frame.size.height-32)


        UIGraphicsBeginImageContextWithOptions(cell.myFeedVw.bounds.size, false, UIScreen.main.scale)
        cell.myFeedVw.drawHierarchy(in: cell.myFeedVw.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let title = self.arrCommList[sender.tag]
        let objectsToShare:UIImage = cell.feedImg.image!

        //  let image = UIImage(contentsOfFile: "\(arrMyFeedList[sender.tag].PostImage)")
        let shareAll:Array = [image ?? objectsToShare] as [Any]
        let activityViewController = UIActivityViewController(activityItems:shareAll
                                                              , applicationActivities: nil)
        //        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.postToTwitter]

        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)

        self.tblComment.reloadRows(at: [indexPath!], with: .none)


        //  }))


        //        self.present(alert, animated: true, completion: {
        //            print("completion block")
        //        })






    }
}
extension CommentVC:UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    //PickerView Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        self.btnCamera.isEnabled = false
        vwImgCollection.isHidden = false
        let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        arr_Item.append(pickedImage)
        DispatchQueue.main.async {
            self.imgCollectionView.reloadData()
        }


//        if let pickedImage1 = info[UIImagePickerController.InfoKey.imageURL] as? URL {
//                           arr_Item.append(pickedImage1)
//                           vwImgCollection.isHidden = false
//                           DispatchQueue.main.async {
//                               self.imgCollectionView.reloadData()
//                           }
//                       }


        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
}
extension CommentVC:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    // MARK: - UICollectionViewDataSource protocol

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 70, height: 70);
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr_Item.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionCell", for: indexPath) as! imageCollectionCell
      //  cell.imgComment.sd_setImage(with:arr_Item[indexPath.row])
        cell.sizeToFit()
        cell.imgComment.image = arr_Item[indexPath.row]
      //  cell.imgComment.contentMode = .scaleAspectFit
        cell.btnImageDelete.isHidden = false


        cell.imgComment.layer.cornerRadius = 5
        cell.imgComment.layer.masksToBounds = true

        cell.btnImageDelete.addTarget(self, action: #selector(imagecommentBtnClick), for: .touchUpInside)
        return cell
    }
}
extension CommentVC:UITextViewDelegate
{
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty

        txtComment.translatesAutoresizingMaskIntoConstraints = true
        txtComment.sizeToFit()
        txtComment.isScrollEnabled = false

        let calHeight = txtComment.frame.size.height

        if calHeight <= 50
        {
            txtComment.isScrollEnabled = false
            txtCommentHeight.constant = 50
            txtComment.frame = CGRect(x: txtComment.frame.origin.x, y: txtComment.frame.origin.y, width: self.view.frame.size.width - 90, height: 50)
        }else if calHeight >= 80
        {
            txtComment.isScrollEnabled = true
            txtCommentHeight.constant = 100
            txtComment.frame = CGRect(x: txtComment.frame.origin.x, y: txtComment.frame.origin.y, width: self.view.frame.size.width - 90, height: 80)

        }
        else{
            txtComment.isScrollEnabled = false
            txtCommentHeight.constant = calHeight
            txtComment.frame = CGRect(x: txtComment.frame.origin.x, y: txtComment.frame.origin.y, width: self.view.frame.size.width - 90, height: calHeight)
        }

    }


}
extension CommentVC{
    func callApiMyCommentList()
    {
        arrComment.removeAll()
        showActivityIndicator()
        arrCommList.removeAll()
        let params = ["SocialMediaPostUserID":SocialMediaPostUserID]
       // let params = ["SocialMediaPostUserID":30]

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
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        // Hide
        print("API, Params: \n",API.Get_Post_Comment_By_PostUserID)
        if !Connectivity.isConnectedToInternet() {
            //  self.AlertPopupInternet()

            // show Alert
            //  self.hideActivityIndicator()
            print("The network is not reachable")
            self.tblComment.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.Get_Post_Comment_By_PostUserID, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //Bhargav Hide
                print("mmp responce",json)

                if(json["status"] == "true") {


                  //  self.arrComment.re
                    let arrData = json["data"].array
                    for value in arrData! {
                        let pckgDetModel:arrCommentList = arrCommentList.init(SocialMediaPostUserID: value["SocialMediaPostUserID"].intValue, Post_Title: value["Post_Title"].stringValue, Post_Image: value["Post_Image"].stringValue, Post_Comment: value["Post_Comment"].stringValue, CreateDate: value["CreateDate"].stringValue,ProfilePhoto: value["ProfilePhoto"].stringValue,UserName: value["UserName"].stringValue)
                        self.arrComment.append(pckgDetModel)

                      //  self.arrCommList.reversed()
                    }
                    self.arrCommList = self.arrComment.reversed()
                    DispatchQueue.main.async {
                        self.tblComment.reloadData()
                    }

                }
            case .failure(let error):
                if !Connectivity.isConnectedToInternet() {
                    //                   self.AlertPopupInternet()
                    //
                    //                   // show Alert
                    //                   self.hideActivityIndicator()
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

    func uploadCommentDataApi(filename:String)
    {
        self.view.endEditing(true)
        showActivityIndicator()
        arrCommList.removeAll()
        var parameters = [String:Any]()



        if filename == ""
        {
            if UserDefaults.standard.value(forKey: "logindata") != nil
            {
                let dict = UserDefaults.standard.value(forKey: "logindata") as! [String : Any]

                if let userId = dict["UserID"]
                {
                    print("login user",userId)
                    parameters = ["SocialMediaPostUserID": SocialMediaPostUserID,"UserMasterID":userId,"Post_Title":""
                               ,"Post_Image":"","Post_URL":"","Post_Description":"fdsfsd","Comment":txtComment.text ?? ""]

                }

            }


        }else{
            if UserDefaults.standard.value(forKey: "logindata") != nil
            {
                let dict = UserDefaults.standard.value(forKey: "logindata") as! [String : Any]

                if let userId = dict["UserID"]
                {
                    print("login user",userId)
                    parameters = ["SocialMediaPostUserID": SocialMediaPostUserID,"UserMasterID":userId,"Post_Title":""
                                      ,"Post_Image":self.image_name,"Post_URL":"","Post_Description":"fdsfsd","Comment":txtComment.text ?? ""]

                }

            }

        }


        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        // Hide
        print("API, Params: \n",API.Get_Post_Comment_By_PostUserID)
        if !Connectivity.isConnectedToInternet() {
            //  self.AlertPopupInternet()

            // show Alert
            //  self.hideActivityIndicator()
            print("The network is not reachable")
            self.tblComment.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.Insert_Comment, method: .post, parameters: parameters, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //Bhargav Hide
                print("mmp responce",json)
                self.vwImgCollection.isHidden = true
                self.arr_Item.removeAll()
                self.txtComment.text = ""
                self.btnCamera.isEnabled = true
                self.image_name = ""
                self.callApiMyCommentList()
//                if(json["status"] == "true") {
//
//
//                }
            case .failure(let error):
                if !Connectivity.isConnectedToInternet() {
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

    func uploadCommentApi()
    {
        showActivityIndicator()

        let image:UIImage = arr_Item[0]
      //  let imagesData = image.jpegData(compressionQuality: 0.4)!
        let imagesData = image.pngData()!

        let urlString = API.uploadImageUrl
        //var urlRequest = URLRequest(url: URL(string: urlString)!)


      // let image_name = "comment" + UUID().uuidString + ".jpg"




        //            let image_name = "iOS_\(Date().).jpeg"
        let date :NSDate = NSDate()
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "yyyy-MM-dd'_'HH:mm:ss"
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        image_name = "iOS_\(dateFormatter.string(from: date as Date)).png"
       // urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        Alamofire.upload(multipartFormData: { multipartFormData in
            // import image to request
           // for imageData in imagesData {
            multipartFormData.append(imagesData, withName: "files", fileName: self.image_name, mimeType: "image/png")
           // }
             //   append(imageData, withName:"files", fileName: image_name, mimeType: "image/jpeg")
            print(multipartFormData)
            print(self.image_name)
            //            for (key, value) in parameters {
            //                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            //            }
        }, to: urlString,

           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                upload.responseJSON{ response in
                    self.hideActivityIndicator()
                    print("data value__:",response.result.value as Any)


                    print("Succesfully uploaded  = \(response)")
//                    if let err = response.error{
//
//                        print(err)
//                        return
//                    }
                    self.uploadCommentDataApi(filename:self.image_name)

                }
            case .failure(let error):
                print(error)
            }
        })







     //   let headers: HTTPHeaders = [
                    /* "Authorization": "your_access_token",  in case you need authorization header */
                //    "Content-type": "multipart/form-data"
             //   ]
//        var parameters = [String:Any]()
//        parameters = ["SocialMediaPostUserID": SocialMediaPostUserID,"UserMasterID":"1","Post_Title":"fdsfsdfs"
//                          ,"Post_Image":"fsdfdsf","Post_URL":"fsdfds","Post_Description":"fdsfsd","Comment":txtComment.text ?? ""]
        //Optional for extra parameter


      //  print("parameters",parameters)

//       Alamofire.upload(multipartFormData: { multipartFormData in
//               multipartFormData.append(imgData, withName: "image",fileName:"testing.jpg", mimeType: "image/jpg")
//               for (key, value) in parameters {
//                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
//                   } //Optional for extra parameters
//           },
//       to:API.Insert_Comment,headers: headers)
//       { (result) in
//        self.hideActivityIndicator()
//           switch result {
//           case .success(let upload, _, _):
//
//            self.vwImgCollection.isHidden = true
//            self.arr_Item.removeAll()
//            self.txtComment.text = ""
//
////               upload.uploadProgress(closure: { (progress) in
////                   print("Upload Progress: \(progress.fractionCompleted)")
////               })
//
//               upload.responseJSON { response in
//                    print(response.result.value)
//               }
//
//           case .failure(let encodingError):
//            print(encodingError.localizedDescription)
//           }
//       }



//        Alamofire.upload(multipartFormData: { (multipartFormData) in
////                 for (key, value) in parameters {
////                     multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
////                 }
//
////                 if let data = imgData{
//                     multipartFormData.append(imgData, withName: "file", fileName: fileName, mimeType: "image/jpg")
//                // }
//
//        }, usingThreshold: UInt64.init(), to: URL(string: API.uploadImageUrl)!, method: .post) { (result) in
//            self.hideActivityIndicator()
//                 switch result{
//                 case .success(let upload, _, _):
//                     upload.responseJSON { response in
//                         print("Succesfully uploaded  = \(response)")
//                         if let err = response.error{
//
//                             print(err)
//                             return
//                         }
//                        self.uploadCommentDataApi()
//
//                     }
//                 case .failure(let error):
//                     print("Error in upload: \(error.localizedDescription)")
//
//                 }
//             }
    }
}
