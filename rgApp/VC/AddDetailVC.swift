//
//  AddDetailVC.swift
//  rgApp
//
//  Created by ADMS on 16/08/21.
//

import UIKit
import Alamofire
import SwiftyJSON


class AddDetailVC: UIViewController , ActivityIndicatorPresenter{

    @IBOutlet weak var txtFirstName:UITextField!
    @IBOutlet weak var txtLastName:UITextField!
    @IBOutlet weak var txtEmail:UITextField!
    var isLoginScreen:String = ""

    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var bottomLine = CALayer()
    var bottomLine1 = CALayer()
    var bottomLine2 = CALayer()
    var mobileNum:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        txtFirstName.textColor = UIColor.darkGray
        txtFirstName.attributedPlaceholder = NSAttributedString(string: "First Name*",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])

        txtLastName.textColor = UIColor.darkGray
        txtLastName.attributedPlaceholder = NSAttributedString(string: "Last Name*",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])

        txtEmail.textColor = UIColor.darkGray
        txtEmail.attributedPlaceholder = NSAttributedString(string: "Email*",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])


        bottomLine.frame = CGRect(x: 0.0, y: txtFirstName.frame.height - 1, width: txtFirstName.frame.size.width - 40, height: 1.0)
        bottomLine.backgroundColor = UIColor(red: 81.0/255.0, green: 132.0/255.0, blue: 172.0/255.0, alpha: 1.0).cgColor
        txtFirstName.borderStyle = UITextField.BorderStyle.none
        txtFirstName.layer.addSublayer(bottomLine)

        bottomLine1.frame = CGRect(x: 0.0, y: txtLastName.frame.height - 1, width: txtLastName.frame.size.width - 40, height: 1.0)
        bottomLine1.backgroundColor = UIColor(red: 81.0/255.0, green: 132.0/255.0, blue: 172.0/255.0, alpha: 1.0).cgColor
        txtLastName.borderStyle = UITextField.BorderStyle.none
        txtLastName.layer.addSublayer(bottomLine1)

        bottomLine2.frame = CGRect(x: 0.0, y: txtEmail.frame.height - 1, width: txtEmail.frame.size.width - 40, height: 1.0)
        bottomLine2.backgroundColor = UIColor(red: 81.0/255.0, green: 132.0/255.0, blue: 172.0/255.0, alpha: 1.0).cgColor
        txtEmail.borderStyle = UITextField.BorderStyle.none
        txtEmail.layer.addSublayer(bottomLine2)


//        txtFirstName.setBottomBorderOnlyWith(color: UIColor(red: 81.0/255.0, green: 132.0/255.0, blue: 172.0/255.0, alpha: 1.0).cgColor)
//        txtLastName.setBottomBorderOnlyWith(color: UIColor(red: 81.0/255.0, green: 132.0/255.0, blue: 172.0/255.0, alpha: 1.0).cgColor)
//        txtEmail.setBottomBorderOnlyWith(color: UIColor(red: 81.0/255.0, green: 132.0/255.0, blue: 172.0/255.0, alpha: 1.0).cgColor)
    }
    @IBAction func btnBackClick(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func continueIsClicked(_ sender: Any)
    {

        if validtion() == true
        {
            bottomLine.backgroundColor = UIColor(red: 81.0/255.0, green: 132.0/255.0, blue: 172.0/255.0, alpha: 1.0).cgColor
            bottomLine1.backgroundColor = UIColor(red: 81.0/255.0, green: 132.0/255.0, blue: 172.0/255.0, alpha: 1.0).cgColor
            bottomLine2.backgroundColor = UIColor(red: 81.0/255.0, green: 132.0/255.0, blue: 172.0/255.0, alpha: 1.0).cgColor

            callApiCreateUser()

        }

//        if let firstname = txtFirstName.text,let lastName = txtLastName.text,let email = txtEmail.text {
//            // Good To Go!
//        } else {
//            myTextField.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
//        }
    }

    func validtion() -> Bool
    {
        var valid: Bool = true
        if txtFirstName.text == ""
        {
            bottomLine.backgroundColor = UIColor.red.cgColor
            bottomLine1.backgroundColor = UIColor.red.cgColor
            bottomLine2.backgroundColor = UIColor.red.cgColor
            txtFirstName.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            valid = false
        }else if txtLastName.text == ""
        {
            bottomLine.backgroundColor = UIColor(red: 81.0/255.0, green: 132.0/255.0, blue: 172.0/255.0, alpha: 1.0).cgColor

            bottomLine1.backgroundColor = UIColor.red.cgColor
            bottomLine2.backgroundColor = UIColor.red.cgColor
            txtLastName.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            valid = false
        }else if txtEmail.text == ""
        {
            bottomLine.backgroundColor = UIColor(red: 81.0/255.0, green: 132.0/255.0, blue: 172.0/255.0, alpha: 1.0).cgColor
            bottomLine1.backgroundColor = UIColor(red: 81.0/255.0, green: 132.0/255.0, blue: 172.0/255.0, alpha: 1.0).cgColor

            bottomLine2.backgroundColor = UIColor.red.cgColor
            txtEmail.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            valid = false
        }else if isValidEmail(txtEmail.text!) != true{
            bottomLine.backgroundColor = UIColor(red: 81.0/255.0, green: 132.0/255.0, blue: 172.0/255.0, alpha: 1.0).cgColor
            bottomLine1.backgroundColor = UIColor(red: 81.0/255.0, green: 132.0/255.0, blue: 172.0/255.0, alpha: 1.0).cgColor

//            bottomLine2.backgroundColor = UIColor(red: 81.0/255.0, green: 132.0/255.0, blue: 172.0/255.0, alpha: 1.0).cgColor

            txtEmail.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            valid = false
        }
        return valid
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
extension UITextField {
    func setBottomBorderOnlyWith(color: CGColor) {
        self.borderStyle = .line
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    func isError(baseColor: CGColor, numberOfShakes shakes: Float, revert: Bool) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = baseColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = 0.4
        if revert { animation.autoreverses = true } else { animation.autoreverses = false }
        self.layer.add(animation, forKey: "")

        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = shakes
        if revert { shake.autoreverses = true  } else { shake.autoreverses = false }
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(shake, forKey: "position")
    }

}

extension AddDetailVC
{
    func callApiCreateUser()
    {
        showActivityIndicator()

        guard let fname = txtFirstName.text else {
            return
        }
        guard let lname = txtLastName.text else {
            return
        }
        guard let email = txtEmail.text else {
            return
        }

        let params = ["FirstName":fname,"LastName":lname,"EmailID":email,"Mobile":mobileNum]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        // Hide
        print("API, Params: \n",API.Create_User)
        if !Connectivity.isConnectedToInternet() {
            print("The network is not reachable")
            return
        }

        Alamofire.request(API.Create_User, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
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
                        }
                        self.mobileNum = ""
                        self.txtEmail.text = ""
                        self.txtFirstName.text = ""
                        self.txtLastName.text = ""
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SuccessVC") as! SuccessVC
                    vc.isLoginScreen = self.isLoginScreen
                    self.navigationController?.pushViewController(vc, animated: false)
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
