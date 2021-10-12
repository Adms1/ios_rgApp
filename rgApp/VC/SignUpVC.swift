//
//  SignUpVC.swift
//  rgApp
//
//  Created by ADMS on 03/08/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpVC: UIViewController , ActivityIndicatorPresenter,UITextFieldDelegate{

    @IBOutlet weak var txtMobileNumber:UITextField!
    @IBOutlet weak var btnProceed:UIButton!

    var isLoginScreen:String = ""

    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        txtMobileNumber.delegate = self
        txtMobileNumber.textColor = UIColor.darkGray
        txtMobileNumber.attributedPlaceholder = NSAttributedString(string: "Mobile Number",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])

        txtMobileNumber.keyboardType = .numberPad

        btnProceed.layer.cornerRadius = 5
        btnProceed.layer.masksToBounds = true
    }

    @IBAction func btnclickBack(_sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let charsLimit = 10

        let startingLength = textField.text?.count ?? 0
        let lengthToAdd = string.count
        let lengthToReplace =  range.length
        let newLength = startingLength + lengthToAdd - lengthToReplace

        return newLength <= charsLimit
    }


    @IBAction func btnClickProceed(_sender:UIButton)
    {
       // self.view.endEditing(true)
        if txtMobileNumber.text!.isEmpty
        {
            self.view.makeToast("Please enter Mobile number", duration: 3.0, position: .bottom)
            return
        }else if txtMobileNumber.text?.isValidContact == false
        {
            self.view.makeToast("Please enter valid mobile number", duration: 3.0, position: .bottom)
            return
        }else{
            callApiAddMobileNumber()
        }

//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
//        self.navigationController?.pushViewController(vc, animated: false)

    }
}

extension SignUpVC
{
    func callApiAddMobileNumber()
    {
        showActivityIndicator()

        guard let mobilenum = txtMobileNumber.text else {
            return
        }


        let params = ["Mobile":mobilenum]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        // Hide
        print("API, Params: \n",API.Send_OTP)
        if !Connectivity.isConnectedToInternet() {
            print("The network is not reachable")
            return
        }

        Alamofire.request(API.Send_OTP, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //Bhargav Hide
                print("mmp responce",json)

                if(json["status"] == "true") {
                let dict = json["data"].dictionary

                    if let newDict = dict
                    {

                        if let UserStatus = newDict["UserStatus"]
                        {
                            if UserStatus == true
                            {
                                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                                UserDefaults.standard.set(json["data"].dictionaryObject!, forKey: "logindata")
                            }
                        }
                        if let otp = newDict["VerifyOTP"]
                        {
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                            vc.VerifyOTP = otp.intValue
                            vc.mobileNum = mobilenum
                            vc.isLoginScreen = self.isLoginScreen
                            if let UserStatus = newDict["UserStatus"]
                            {
//                                if UserStatus == false
//                                {
                                    vc.UserStatus = UserStatus.boolValue
                                //}
                            }

                            self.navigationController?.pushViewController(vc, animated: false)
                        }
                    }
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
