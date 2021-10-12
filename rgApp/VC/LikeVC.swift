//
//  NotificationVC.swift
//  rgApp
//
//  Created by ADMS on 17/08/21.
//

import UIKit
import SwiftyJSON
import Alamofire

class LikeVC: UIViewController, ActivityIndicatorPresenter{

    @IBOutlet weak var tblLike:UITableView!

    var arrLikeList = [arrMyLike]()
    var SocialMediaPostUserID:Int = -1


    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()


    override func viewDidLoad() {
        super.viewDidLoad()

        callApiMyLike()


//        tblNotification.backgroundColor = .clear

        tblLike.delegate = self
        tblLike.dataSource = self

        tblLike.register(UINib(nibName: "LikeCell", bundle: nil), forCellReuseIdentifier: "LikeCell")

        // self.tblFeed.backgroundColor = .lightGray

//        self.tblNotification.estimatedRowHeight = 76.0
//        self.tblNotification.rowHeight = UITableView.automaticDimension

    }

    @IBAction func btnClickBack()
    {
        self.dismiss(animated: true, completion: nil)
    }

}
extension LikeVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLikeList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikeCell", for: indexPath) as! LikeCell
//        cell.lblName.text = arrLikeList[indexPath.row].Name
        let strFirstLetter = arrLikeList[indexPath.row].Name.uppercased()
       // arrCommList[indexPath.row].UserName
        let index = strFirstLetter.index(strFirstLetter.startIndex, offsetBy: 0)

        cell.lblName.text = String(strFirstLetter[index])

        cell.lblUserName.text = arrLikeList[indexPath.row].Name

        cell.lblName.layer.cornerRadius = cell.lblName.layer.frame.height/2
        cell.lblName.layer.masksToBounds = true

        cell.selectionStyle = .none

        cell.vwNotification.layer.cornerRadius = 5
        cell.vwNotification.layer.masksToBounds = true

        return cell

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }


}
extension LikeVC
{
    func callApiMyLike()
    {
      //  showActivityIndicator()
        arrLikeList.removeAll()

        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        // Hide
        print("API, Params: \n",API.GetLike)
        if !Connectivity.isConnectedToInternet() {
            //  self.AlertPopupInternet()

            // show Alert
            //  self.hideActivityIndicator()
            print("The network is not reachable")
            self.tblLike.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.GetLike, method: .get, parameters: ["SocialMediaPostUserID":SocialMediaPostUserID], headers: headers).validate().responseJSON { response in
         //   self.hideActivityIndicator()

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //Bhargav Hide
                print("mmp responce",json)

                if(json["status"] == "true") {
                    let arrData = json["data"].array
                    for value in arrData! {
                        let pckgDetModel:arrMyLike = arrMyLike.init(Name: value["Name"].stringValue)
                        self.arrLikeList.append(pckgDetModel)
                    }
                    DispatchQueue.main.async {
                        self.tblLike.reloadData()
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
}

