//
//  SuccessVC.swift
//  rgApp
//
//  Created by ADMS on 03/08/21.
//

import UIKit

class SuccessVC: UIViewController {

    @IBOutlet weak var btnDashbord:UIButton!
    var isLoginScreen:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        btnDashbord.layer.cornerRadius = 5
        btnDashbord.layer.masksToBounds = true
    }

    @IBAction func btnClickDashboard(_sender:UIButton)
    {
        if isLoginScreen == "MyFeedListVC"
        {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyFeedListVC") as! MyFeedListVC
            vc.strTitle = "MY TASK"
            vc.isLoginScreen = "MyFeedListVC"
            self.navigationController?.pushViewController(vc, animated: false)

        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            self.navigationController?.pushViewController(vc, animated: false)

        }
    }
    @IBAction func btnclickBack(_sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
