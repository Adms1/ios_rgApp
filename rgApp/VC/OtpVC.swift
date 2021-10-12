//
//  OtpVC.swift
//  rgApp
//
//  Created by ADMS on 03/08/21.
//

import UIKit
import Toast_Swift
import SwiftyJSON
import Alamofire

class OtpVC: UIViewController,UITextFieldDelegate , ActivityIndicatorPresenter{

    @IBOutlet weak var btnVerifyCode:UIButton!
    @IBOutlet weak var btnResend:UIButton!
    @IBOutlet weak var lblNumber:UILabel!
    var isLoginScreen:String = ""

    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()

    @IBOutlet weak var txtfirst:UITextField!
    @IBOutlet weak var txtsecond:UITextField!
    @IBOutlet weak var txtthird:UITextField!
    @IBOutlet weak var txtfourth:UITextField!

    var VerifyOTP:Int = -1
    var mobileNum:String = ""

    var UserStatus:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        lblNumber.text = "Sent to +91 \(mobileNum)"

        if #available(iOS 12.0, *) {
            txtfirst.textContentType = .oneTimeCode
        }
        self.txtfirst.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.txtfirst.becomeFirstResponder()


        btnVerifyCode.layer.cornerRadius = 5
        btnVerifyCode.layer.masksToBounds = true

        txtfirst.layer.cornerRadius = 5
        txtfirst.layer.masksToBounds = true

        txtsecond.layer.cornerRadius = 5
        txtsecond.layer.masksToBounds = true

        txtthird.layer.cornerRadius = 5
        txtthird.layer.masksToBounds = true

        txtfourth.layer.cornerRadius = 5
        txtfourth.layer.masksToBounds = true


        txtfirst.keyboardType = .numberPad
        txtsecond.keyboardType = .numberPad
        txtthird.keyboardType = .numberPad
        txtfourth.keyboardType = .numberPad


 //       txtfirst.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
//        txtsecond.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
//        txtthird.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
//        txtfourth.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)

    }
//    @objc func textFieldDidChange(textField: UITextField){
//
//    textField.text = "\(VerifyOTP)"
//        if #available(iOS 12.0, *) {
//            if textField.textContentType == UITextContentType.oneTimeCode{
//
//                //here split the text to your four text fields
//
//                if let otpCode = textField.text, otpCode.count > 3{
//
//                    txtfirst.text = String(otpCode[otpCode.startIndex])
//                    txtsecond.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 1)])
//                    txtthird.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 2)])
//                    txtfourth.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 3)])
//                }
//            }
//        } else {
//        }
//    }


    @objc func textFieldDidChange(_ textField: UITextField) {
      if #available(iOS 12.0, *) {
          if textField.textContentType == UITextContentType.oneTimeCode{
              //here split the text to your four text fields
              if let otpCode = textField.text, otpCode.count > 3{
                txtfirst.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 0)])
                txtsecond.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 1)])
                txtthird.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 2)])
                txtfourth.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 3)])
              }
          }
       }
    }

    @IBAction func btnClickResend()
    {
        self.view.makeToast("OTP has been sent to your registered mobile number", duration: 3.0, position: .bottom)
        callApiAddMobileNumber()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

          if (string.count == 1){
              if textField == txtfirst {
                  txtsecond?.becomeFirstResponder()
              }
              if textField == txtsecond {
                  txtthird?.becomeFirstResponder()
              }
              if textField == txtthird {
                  txtfourth?.becomeFirstResponder()
              }
              if textField == txtfourth {
                  txtfourth?.resignFirstResponder()
                  textField.text? = string
                   //APICall Verify OTP
                  //Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.VerifyOTPAPI), userInfo: nil, repeats: false)
              }
              textField.text? = string
              return false
          }else{
              if textField == txtfirst {
                  txtfirst?.becomeFirstResponder()
              }
              if textField == txtsecond {
                txtsecond?.becomeFirstResponder()
              }
              if textField == txtthird {
                txtthird?.becomeFirstResponder()
              }
              if textField == txtfourth {
                txtfourth?.becomeFirstResponder()
              }
              textField.text? = string
              return false
          }

      }




    @IBAction func btnclickBack(_sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnClickVerifyCode(_sender:UIButton)
    {
        var otpString:String = ""
        if let firstTest = txtfirst.text , let secondText = txtsecond.text , let thirdText = txtthird.text ,let fourText = txtfourth.text
        {
            otpString = "\(firstTest)\(secondText)\(thirdText)\(fourText)"
            print("finalotpString",otpString)

            if otpString == "\(VerifyOTP)"
            {
                if UserStatus == true
                {

                    if isLoginScreen == "MyFeedListVC"
                    {
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyFeedListVC") as! MyFeedListVC
                        vc.isLoginScreen = "MyFeedListVC"
                        vc.strTitle = "MY TASK"
                        self.navigationController?.pushViewController(vc, animated: false)

                    }else{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                        self.navigationController?.pushViewController(vc, animated: false)

                    }

                }else{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddDetailVC") as! AddDetailVC
                    vc.mobileNum = mobileNum
                    vc.isLoginScreen = isLoginScreen
                    self.navigationController?.pushViewController(vc, animated: false)
                }
            }else{
                self.view.makeToast("OTP does not match.", duration: 3.0, position: .bottom)
                //self.view.makeToast("OTP does not match.")
              //  print("otp does not match")
            }

        }
    }
    
}
extension OtpVC
{
    func callApiAddMobileNumber()
    {
        showActivityIndicator()

//        guard let mobilenum = mobileNum else {
//            return
//        }


        let params = ["Mobile":mobileNum]
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
                            self.VerifyOTP = otp.intValue
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
