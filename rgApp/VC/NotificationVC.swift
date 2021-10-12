//
//  NotificationVC.swift
//  rgApp
//
//  Created by ADMS on 17/08/21.
//

import UIKit
import SwiftyJSON
import Alamofire

class NotificationVC: UIViewController  , ActivityIndicatorPresenter{

    @IBOutlet weak var tblNotification:UITableView!

    var arrNotificationList = [arrMyNotification]()


    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()


    override func viewDidLoad() {
        super.viewDidLoad()

        callApiMyFeed()

//        tblNotification.backgroundColor = .clear

        tblNotification.delegate = self
        tblNotification.dataSource = self

        tblNotification.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")

        // self.tblFeed.backgroundColor = .lightGray

        self.tblNotification.estimatedRowHeight = 76.0
        self.tblNotification.rowHeight = UITableView.automaticDimension

    }

    @IBAction func btnClickBack()
    {
        self.navigationController?.popViewController(animated: true)
    }

}
extension NotificationVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNotificationList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        cell.lblTitle.text = arrNotificationList[indexPath.row].Title
        cell.lblDate.text = arrNotificationList[indexPath.row].CreateDate

        cell.selectionStyle = .none
        
        cell.vwNotification.layer.cornerRadius = 5
        cell.vwNotification.layer.masksToBounds = true
        
        return cell

    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension NotificationVC
{
    func callApiMyFeed()
    {
        showActivityIndicator()
        arrNotificationList.removeAll()

        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        // Hide
        print("API, Params: \n",API.Get_NotficationList)
        if !Connectivity.isConnectedToInternet() {
            //  self.AlertPopupInternet()

            // show Alert
            //  self.hideActivityIndicator()
            print("The network is not reachable")
            self.tblNotification.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.Get_NotficationList, method: .get, parameters: nil, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //Bhargav Hide
                print("mmp responce",json)

                if(json["status"] == "true") {
                    let arrData = json["data"].array
                    for value in arrData! {
                        let pckgDetModel:arrMyNotification = arrMyNotification.init(CreateDate: value["CreateDate"].stringValue, Title: value["Title"].stringValue, IsActive: value["IsActive"].stringValue)
                        self.arrNotificationList.append(pckgDetModel)
                    }
                    DispatchQueue.main.async {
                        self.tblNotification.reloadData()
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
