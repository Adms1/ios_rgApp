//
//  RegisterVolunteerVC.swift
//  rgApp
//
//  Created by ADMS on 08/01/21.
//

import UIKit

class RegisterVolunteerVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet var scrlView: UIScrollView!

    @IBOutlet var txtFirstName:UITextField! //KOTextField!
    @IBOutlet var txtLastName:UITextField!
    @IBOutlet var txtEmail:UITextField!
    @IBOutlet var txtMobileNum:UITextField!
    @IBOutlet var txtviewRemark:UITextView!
    @IBOutlet var imgRemark:UIImageView!

    @IBOutlet var btnTerms:UIButton!
    @IBOutlet var btnCheckedTerms:UIButton!

    var strTermsSelected = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addDoneButtonOnKeyboard(txt: txtviewRemark)

        let contentInset:UIEdgeInsets = self.scrlView.contentInset
        scrlView.contentInset = contentInset

        self.txtFirstName.delegate = self
        self.txtLastName.delegate = self
        self.txtEmail.delegate = self
        self.txtMobileNum.delegate = self
        self.txtviewRemark.delegate = self

        btnCheckedTerms.setBackgroundImage(UIImage(named: "select_box"), for: .normal)
        btnCheckedTerms.isSelected = false;
        strTermsSelected = "0"

        imgRemark.addShadowWithRadius(0,6,0,color: GetColor.tfPlacholderColor)

        txtviewRemark.text = "Enter Remark"
        txtviewRemark.textColor = UIColor.lightGray
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Keyboard Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification)
    {
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrlView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 70
        scrlView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification: NSNotification)
    {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrlView.contentInset = contentInset
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtviewRemark.textColor == UIColor.lightGray {
            txtviewRemark.text = nil
            txtviewRemark.textColor = UIColor.black
            let scrollPoint : CGPoint = CGPoint.init(x:0, y:self.txtviewRemark.frame.origin.y-230)
            self.scrlView.setContentOffset(scrollPoint, animated: true)
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if txtviewRemark.text.isEmpty {
            txtviewRemark.text = "Enter Remark"
            txtviewRemark.textColor = UIColor.lightGray
            self.scrlView.setContentOffset(CGPoint.zero, animated: true)

        }
    }

    @IBAction func TermsCondition_Clicked(_ sender: UIButton) {
        self.view.endEditing(true)
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InvoiceListVC") as? InvoiceListVC
//        vc?.strTitle = "Terms & Condition"
//        vc?.strLoadUrl = API.TermsCondition
//        self.navigationController?.pushViewController(vc!, animated: true)

    }
    func addDoneButtonOnKeyboard(txt:UITextView){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        txt.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        self.view.endEditing(true)
//        if validated() == true
//        {
//            apiSignUp()
//        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        switch textField
        {
        case self.txtFirstName:
            self.txtLastName.becomeFirstResponder()
            break
        case self.txtLastName:
            self.txtEmail.becomeFirstResponder()
            break
        case self.txtEmail:
            self.txtMobileNum.becomeFirstResponder()
            break
        case self.txtMobileNum:
            self.txtviewRemark.becomeFirstResponder()
            break
        default:
            textField.resignFirstResponder()
        }
        return true
}
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var result = true
        if range.location == 0 && string == " " { result = false }

        if txtMobileNum == textField {
            if (string).count > 0 {
                let disallowedCharacterSet = NSCharacterSet(charactersIn: "0123456789").inverted
                let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
                if textField.text!.count == 10
                {
                    result = false
                }
                else
                {
                    result = replacementStringIsLegal
                }
            }
        }

        return result
    }

    @IBAction func Submit_Clicked(_ sender: UIButton) {
        self.view.endEditing(true)
//        if validated() == true
//        {
//            apiSignUp()
//
//        }
    }
    @IBAction func btn_box(sender: UIButton) {
       if (btnCheckedTerms.isSelected == true)
       {
           btnCheckedTerms.setBackgroundImage(UIImage(named: "select_box"), for: .normal)
           btnCheckedTerms.isSelected = false;
           strTermsSelected = "0"
       }
       else
       {
           btnCheckedTerms.setBackgroundImage(UIImage(named: "selected_box"), for: .normal)
           btnCheckedTerms.isSelected = true;
           strTermsSelected = "1"
       }
   }

    @IBAction func Back_Clicked(_ sender: UIButton)
    {
        navigationController?.popViewController(animated: false)
    }
}
