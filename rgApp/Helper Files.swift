//
//  Help Files.swift
//  Chat
//
//  Created by Bhargav on 26/04/19.
//  Copyright © 2019 ADMS. All rights reserved.
//

import UIKit
////import TransitionButton
//import SDWebImage
//////import TransitionButton
//import Alamofire
//import SwiftyJSON
////import UIDropDown
import Foundation
import WebKit;

var bundleDisplayName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as! String

var Package_placeHolder = UIImage(named: "")//"Package_image-1.png")
var Persion_placeHolder = UIImage(named: "")//"pro_pic1.png")

//onPaymentSuccess
struct API {



    static let strVersion:String  = "Ver. No.: 1.620200407"
    static let strGameID:String   = "6616E8DC-917C-473D-ACA1-4540D7AC9488"

    static let hostName:String    = "http://rgapp.admssvc.com/" //"\(bundleDisplayName == "TestCraft" ? "https://webservice.testcraft.in/" : "http://demowebservice.testcraft.in/")" //"LIVE" : "TEST"
    static let baseUrl:String     = "\(hostName)Webservice.asmx/"

    static let imageUrl:String     = "http://rgapp.admssvc.com/"

//    if let imgurl = arrMyPackageList[indexPath.row].BannerIcon {
//        cell.imgBackGround.sd_setImage(with: URL(string: API.imageUrl + imgurl))
//    }

    static let Get_Task = "\(baseUrl)Get_Task"

    static let Add_DeviceNotification = "\(baseUrl)Add_DeviceNotification"

    static let Get_Post_Comment_By_PostUserID = "\(baseUrl)Get_Post_Comment_By_PostUserID"

    static let Insert_Comment = "\(baseUrl)Insert_Comment"

    static let uploadImageUrl:String = "http://rgapp.admssvc.com/UploadImage.ashx"

    static let uploadCommentImage:String = "http://rgapp.admssvc.com/UploadTask/"

    static let Send_OTP = "\(baseUrl)Send_OTP"

    static let Create_User = "\(baseUrl)Create_User"

    static let AddPoint = "\(baseUrl)AddPoint"

    static let Get_NotficationList = "\(baseUrl)Get_NotficationList"

    static let GetLike = "\(baseUrl)GetLike"



}
// MARK: - ActivityIndicatorPresenter

public protocol ActivityIndicatorPresenter {
    
    /// The activity indicator
    var activityIndicatorView: UIView { get }
    var activityIndicator: UIActivityIndicatorView { get }
    //            var loadingView: UIView { get }
    /// Show the activity indicator in the view
    func showActivityIndicator()
    
    /// Hide the activity indicator in the view
    func hideActivityIndicator()
}

public extension ActivityIndicatorPresenter where Self: UIViewController {
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicatorView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
            self.activityIndicatorView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)  // UIColorFromHex(rgbValue: 0xffffff, alpha: 0.8) UIColor.clear//
            
            let loadingView: UIView = UIView()
            loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)//CGRectMake(0, 0, 80, 80)
            loadingView.center =  CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.height / 2)
            //uiView.center
            loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
            //                        self.loadingView.clipsToBounds = true
            loadingView.layer.cornerRadius = 10
            //            var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
            
            self.activityIndicator.style = .whiteLarge
            self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40) //or whatever size you would like
            self.activityIndicator.center = CGPoint(x: loadingView.bounds.size.width / 2, y: loadingView.bounds.height / 2)
            
            loadingView.addSubview(self.activityIndicator)
            self.view.addSubview(self.activityIndicatorView)
            self.activityIndicatorView.addSubview(loadingView)
            
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
            self.activityIndicatorView.removeFromSuperview()
            
        }
    }
    
    
}
func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
    let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
    let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
    let blue = CGFloat(rgbValue & 0xFF)/256.0
    return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
}


func isEmailValid(_ value: String) -> Bool {
    do {
        if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
            return false
        }
    } catch {
        return false
    }
    return true
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    class func rbg(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        return color
    }
    class func rbgA(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: a)
        return color
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
}
class Colors {
    var gl:CAGradientLayer!
    
    init() {
        let colorTop = UIColor(red: 192.0 / 255.0, green: 38.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 35.0 / 255.0, green: 2.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0).cgColor
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}

extension UICollectionView {

    func setEmptyMessageImg(_ message: String) {
        //        let messageLabel = UILabel(frame: CGRect(x: 20, y: 0, width: self.bounds.size.width - 40, height: self.bounds.size.height))
        //        messageLabel.text = message
        //        messageLabel.textColor = .red
        //        messageLabel.numberOfLines = 0;
        //        messageLabel.textAlignment = .center;
        //        messageLabel.font = UIFont(name: "System-Regular", size: 30)
        //        messageLabel.sizeToFit()
        let messageLabel = UIImageView(frame: CGRect(x: 20, y: 0, width: self.bounds.size.width - 40, height: self.bounds.size.height))
        messageLabel.image = UIImage(named: "no_package_found")
        //        messageLabel.text = message
        //        messageLabel.textColor = .red
        //        messageLabel.numberOfLines = 0;
        //        messageLabel.textAlignment = .center;
        //        messageLabel.font = UIFont(name: "System-Regular", size: 30)
        //        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }


    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 20, y: 0, width: self.bounds.size.width - 40, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .red
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "System-Regular", size: 30)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel;
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
extension String {
    func removeFormatAmount() -> Double {
        let formatter = NumberFormatter()
        
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.decimalSeparator = ","
        
        return formatter.number(from: self) as! Double? ?? 0
    }
}


//// MARK: - Constants
//
struct Constants {
    //
    static let storyBoard              = UIStoryboard.init(name: "Main", bundle: nil)
    static let appDelegate             = UIApplication.shared.delegate as! AppDelegate
    static let window                  = UIApplication.shared.keyWindow
    static let studentPlaceholder      = UIImage.init(named: "person_placeholder.jpg")
    //    static let dropDownPlaceholder     = "-Please Select-"
    //    static let documentsDirectoryURL   = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    //    static let FontNameArray:[String]  = ["Shruti.ttf", "Shivaji05.ttf", "Gujrati-Saral-1.ttf", "h-saral1.TTF", "h-saral2.TTF", "h-saral3.TTF", "Arvinder.ttf", "H-SARAL0.TTF", "G-SARAL2.TTF", "G-SARAL3.TTF", "G-SARAL4.TTF"]
}
extension UITableView {

    public func reloadData(_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion:{ _ in
            completion()
        })
    }

    func scroll(to: scrollsTo, animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            switch to{
            case .top:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.scrollToRow(at: indexPath, at: .top, animated: animated)
                }
                break
            case .bottom:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                    self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }
                break
            }
        }
    }

    enum scrollsTo {
        case top,bottom
    }
}
extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        //        border.layer.masksToBounds = true
        self.addSublayer(border)
        
    }
    
}

@objc protocol SuccessFailedDelegate
{
    //    @objc optional func MobileDuplicateDelegate()
    @objc optional func SuccessFailedStatus()
}

// MARK: - Error Messages

struct Message {

    // ----- Language -----
    static let Gujarati:String                             = "Gujarati".localized()
    static let English:String                              = "English".localized()

    // ----- Login -----
    static let PlaceholderPhoneNo:String                 = "Enter Your Phone No".localized()
    static let MobileNumberError:String                  = "Please enter Mobile Number.".localized()
    static let MobileRangeValidationError:String         = "Please enter 10 digit Mobile Number.".localized()
    static let Terms_Condition:String                    = "I agree to all Terms & Conditions. An SMS may be sent to authenticate your account, and message and data rates may apply.".localized()
    static let Login:String                              = "Log in".localized()
    static let VenderLogin:String                        = "Vender Log in".localized()
    static let PhoneNo:String                            = "Phone No".localized()

    //    let strTitle = NSLocalizedString("You like?", comment: "You like the result?")

    // ----- OTP -----
    static let OTP:String                           = "OTP".localized()
    static let Confirm:String                       = "Confirm".localized()
    static let PlaceholderOTP:String                = "Confirm OTP".localized()
    static let OTPError:String                      = "Please enter OTP".localized()
    static let OTPInvalidCodeError:String           = "Invalid code, Please re-enter".localized()

    // ----- User Detail -----
    static let PlaceholderFirstName:String          = "Enter First Name".localized()
    static let PlaceholderLastName:String           = "Enter Last Name".localized()
    static let PlaceholderAddress1:String           = "Enter Address Line 1".localized()
    static let PlaceholderAddress2:String           = "Enter Address Line 2".localized()
    static let PlaceholderArea:String               = "Enter your Area".localized()
    static let PlaceholderCity:String               = "Select your City".localized()
    static let PlaceholderState:String              = "Select your State".localized()
    static let PlaceholderZipCode:String            = "Enter your Zip Code".localized()
    static let PlaceholderLandmark:String           = "Enter your Landmark".localized()
    static let PlaceholderGSTNO:String              = "Enter your GSTNO".localized()

    static let FirstName:String          = "First Name".localized()
    static let LastName:String           = "Last Name".localized()
    static let Address1:String           = "Address".localized()
    static let Address2:String           = "Address".localized()
    static let Area:String               = "Area".localized()
    static let City:String               = "City".localized()
    static let State:String              = "State".localized()
    static let ZipCode:String            = "Zip Code".localized()
    static let Landmark:String           = "Landmark".localized()
    static let GSTNO:String              = "GSTNO".localized()

    static let Next:String               = "Next".localized()
    static let Update:String               = "Update".localized()

    static let PlaceholderShopName:String          = "Enter Shop Name".localized()
    static let PlaceholderBusinessName:String      = "Enter Business Name".localized()
    static let PlaceholderPassCode:String          = "Enter Pass Code".localized()
    static let PlaceholderConfirmPassCode:String   = "Enter Confirm Pass Code".localized()

    static let ShopName:String                     = "Shop Name".localized()
    static let BusinessName:String                 = "Business Name".localized()
    static let PassCode:String                     = "Pass Code".localized()
    static let PassCodeDidNotMatched:String        = "Pass Code did not matched".localized()
    static let EnterFiveDigitPasscode:String       = "Please Enter 6 digit".localized()
    static let ConfirmPassCode:String              = "Confirm Pass Code".localized()

    // ----- Home -----
    static let Search:String          = "Search".localized()
    static let Items:String           = "Items".localized()
    static let Store:String           = "Store".localized()
    static let MyItems:String         = "My Items".localized()


    static let ItemName:String       = "Item Name".localized()
    static let MRP:String               = "MRP".localized()
    static let SellingPrice:String      = "Selling Price".localized()
    static let Qty:String               = "Quantity".localized()
//    static let QtyTitle:String  = "QtyTitle".localized()
    static let ProductDetails:String    = "Product Detail".localized()
    static let Category:String          = "Category".localized()
        static let PlaceholderItemName:String       = "Enter Item Name".localized()
        static let PlaceholderMRP:String               = "Enter MRP".localized()
        static let PlaceholderSellingPrice:String      = "Enter Selling Price".localized()
        static let PlaceholderQty:String               = "Enter Quantity".localized()
  //    static let PlaceholderQtyTitle:String          = "Enter QtyTitle".localized()
        static let PlaceholderProductDetails:String    = "Enter Product Details(Optional)".localized()
        static let PlaceholderCategory:String          = "Choose Category".localized()

    //    static let userNameError:String             = "Please enter username"
    //    static let passwordError:String             = "Please enter password"
    //    static let passwordValidationError:String   = "Password must be 3-12 characters."
    //    static let userError:String                 = "Invalid username/password"
    //
    //    // ----- Profile -----
    //
    //    static let currentPwdError:String           = "Please enter current password"
    //    static let currentPwdNotMatchError:String   = "Current password doesn't match."
    //    static let newPwdError:String               = "Please enter new password"
    //    static let newCPwdError:String              = "Please enter confirm new password"
    //    static let newCCPwdError:String             = "Confirm password should be same as new password"
    //
    //    // ----- Request -----
    //
    //    static let subjectError:String              = "Please enter subject"
    //    static let descriptionError:String          = "Please enter description"
    //
    //    // ----- Marks -----
    //
    //    static let sectionError:String              = "Please select section"
    //    static let testError:String                 = "Please select subject"
    //
    //    // ----- Leave -----
    //
    //    static let leaveDaysError:String            = "Please select leave days"
    //    static let headNameError:String             = "Please select head"
    //    static let reasonError:String               = "Please enter valid reason"
    //
    //    // ----- Add TimeTable -----
    //
    //    static let standardError:String             = "Please choose grade"
    //    static let classError:String                = "Please choose sections"
    //    static let subjectIdError:String            = "Please choose subject"
    //    static let startTimeHourError:String        = "Please choose start time hour"
    //    static let startTimeMinuteError:String      = "Please choose start time minute"
    //    static let endTimeHourError:String          = "Please choose end time hour"
    //    static let endTimeMinuteError:String        = "Please choose end time minute"
    //
    //    // ----- Api Success Message -----
    //
    //    static let attendenceAddSuccess:String         = "Attendance added successfully."
    //    static let attendenceUpdateSuccess:String      = "Attendance updated successfully."
    //    static let subjectAddSuccess:String            = "Subjects added successfully."
    //    static let testAddSuccess:String               = "Test added successfully."
    //    static let testUpdateSuccess:String            = "Test updated successfully."
    //    static let requestSentSuccess:String           = "Request sent successfully."
    //    static let homeworkStatusAddSuccess:String     = "HomeWork status added successfully."
    //    static let homeworkStatusUpdateSuccess:String  = "HomeWork status updated successfully."
    //    static let leaveDeleteSuccess:String           = "Leave deleted successfully."
    //    static let hwCwSuccess:String                  = "HomeWork/ClassWork added successfully."
    //
    //    // ----- Api Failure Message -----
    //
    //    static let timeOutError:String                 = "Please try again later."
    //    static let internetFailure:String              = "Network unavailable. \(timeOutError)"
    //    static let serverError:String                  = "Oops, Skool360 Bhadaj server is down keep calm and try after sometime. Thank you!"
    //    static let failure:String                      = "Something went wrong."
    //    static let noRecordFound:String                = "No records are found."
    //    static let noClassDetailFound:String           = "No class details are found."
    //    static let noHWFound:String                    = "Please add home work then update status."
    //    static let cwNotFound:String                   = "Please add classwork"
    //    static let noSectionSelect:String              = "Please select any one section"
    //    static let noGradeSelect:String                = "Please select any grade"
    //    static let noSubjectSelect:String              = "Please select any subject"
    //
    //    // ----- Updation Message -----
    //
    static let appUpdateTitle:String               = "Update Available"
    static let appUpdateMsg:String                 = "A new version of {} is available. Please update to version () now."
    //
    //    // ----- Logout Message -----
    //
    //    static let logOutMsg:String                    = "Are you sure you want to logout?"
    //    static let statusUpdate:String                 = "Are you sure you want to update status?"
    //    static let deleteLeave:String                  = "Are you sure you want to delete leave?"
    //}

    //struct FontType {
    //
    //    static let regularFont:UIFont      = FontHelper.regular(size: DeviceType.isIpad ? 16 : 13)
    //    static let mediumFont:UIFont       = FontHelper.medium(size: DeviceType.isIpad ? 16 : 13)
    //    static let boldFont:UIFont         = FontHelper.bold(size: DeviceType.isIpad ? 16 : 13)
    //}
    //
    //struct DeviceType {
    //
    //    static let isIphone5:Bool          = { return UIScreen.main.bounds.size.width <= 320 }()
    //    static let isIpad                  = UIDevice.current.userInterfaceIdiom == .pad
}
//
struct GetColor {
    static var tfPlacholderColor:UIColor              = UIColor(rgb: 0x55540B)
    static var tfTitleColor:UIColor                   = UIColor(rgb: 0x000001)
    static var tfTitleBackgroundColor:UIColor         = UIColor(rgb: 0xFDF18A)
    static var darkGreen:UIColor                      = UIColor(rgb: 0x326304)
    static var CGdarkGreen:CGColor                    = UIColor(rgb: 0x326304).cgColor
    static var TabbarGreen:UIColor                      = UIColor(rgb: 0x3E3C05)
    static var DarkBlue:UIColor                      = UIColor(rgb: 0x08539D)

    //    static var headerColor:UIColor              = UIColor.rbg(r: 248, g: 150, b: 36)
    static var shadowColor:UIColor              = UIColor.clear.withAlphaComponent(0.2)
    //    static var blue:UIColor                     = UIColor.rbg(r: 23, g: 145, b: 216)
    //    static var green:UIColor                    = UIColor.rbg(r: 107, g: 174, b: 24)
    static var red:UIColor                      = UIColor.rbg(r: 255, g: 0, b: 0)
    //    static var orange:UIColor                   = GetColor.headerColor
    //    static var yellow:UIColor                   = UIColor.rbg(r: 216, g: 184, b: 52)
    //    static var pink:UIColor                     = UIColor.rbg(r: 246, g: 68, b: 141)
        static var seaGreen:UIColor                 = UIColor(rgb: 0x00B7C5) //UIColor.rbg(r: 246, g: 68, b: 141)
    //    static var themeBlueColor:UIColor           = UIColor(rgb: 0x3EA7E0)
    //    static var blueHeaderText:UIColor           = UIColor(rgb: 0x0077DF) // Blue
    //    static var blueHeaderBg:UIColor             = UIColor(rgb: 0xF7FCFF)
    //    static var signInText:UIColor               = GetColor.themeBlueColor//UIColor(rgb: 0x82C0E5)
    //    static var lightGray:UIColor                = UIColor(rgb: 0xA3A3A3)
    //    static var SagmentDefaultColor:UIColor      = UIColor(rgb: 0x464A59)
        static var darkGray:UIColor                 = UIColor(rgb: 0x585858)
    //    static var darkGreen:UIColor                = UIColor(rgb: 0x009115)//00FF00)
    //    static var tomatoRed:UIColor                = UIColor(rgb: 0xff5546)
    //
    //    static var dotColorCurrent:UIColor          = UIColor(rgb: 0x3EA7E0)
    //    static var dotColorAnswered:UIColor         = UIColor(rgb: 0x81A817)//.rbg(r: 216, g: 184, b: 52) // 81A817
    //    static var dotColorUnAnswered:UIColor       = UIColor(rgb: 0xEE6B60)//.rbg(r: 255, g: 0, b: 0) // EE6B60
    //    static var dotColorReviewLater:UIColor      = UIColor(rgb: 0xDFCB58)//UIColor(rgb: 0x61D397)//.rbg(r: 107, g: 174, b: 24) // 61D397
    //    static var dotColorNotVisited:UIColor       = UIColor(rgb: 0xEAEAEA)
    //    static var dotColorGray:UIColor             = UIColor(rgb: 0x5C5C5C)
    //    static var dotColorWhite:UIColor            = UIColor(rgb: 0xFFFFFF)
    //    static var ColorGrayF5F5F5:UIColor          = UIColor(rgb: 0xF5F5F5)
    //
    //    static var successPopupGreenColor:UIColor   = UIColor(rgb: 0x4C721D)
    //    static var successPopupPinkColor:UIColor    = UIColor(rgb: 0xF53F85)
    //    static var dark_green:UIColor               = UIColor(rgb: 0x47841F)
    static var LightYellowColor:UIColor               = UIColor(rgb: 0xFDFCDC)
    static var whiteColor:UIColor                     = UIColor(rgb: 0xFFFFFE)
    static var blackColor:UIColor                     = UIColor(rgb: 0x000001)
    //    static var SectionColor:UIColor             = UIColor(rgb: 0xEFEFEF)

    static var NewOrder         :UIColor                       = UIColor(rgb: 0x054bf9)
    static var Gettingready     :UIColor                       = UIColor(rgb: 0x9601f9)
    static var OutForDelivery   :UIColor                       = UIColor(rgb: 0x007701)
    static var ReadyForPickup   :UIColor                       = UIColor(rgb: 0x21c008)
    static var CancelOrder      :UIColor                       = UIColor(rgb: 0xfd0003)

}
func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text

    label.sizeToFit()
    return label.frame.height
}
extension String {
    func localized() ->String {

        if let _ = UserDefaults.standard.string(forKey: "i18n_language") { } else {
            // we set a default, just in case
            UserDefaults.standard.set("en", forKey: "i18n_language")
            UserDefaults.standard.synchronize()
        }

        let lang = UserDefaults.standard.string(forKey: "i18n_language")
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        print("bundle lang changes...")
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }}


extension UITextField {

    enum Direction {
        case Left
        case Right
    }

    // add image to textfield
    func withImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor){
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 45))
        mainView.layer.cornerRadius = 5

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = CGFloat(0.5)
        view.layer.borderColor = colorBorder.cgColor
        mainView.addSubview(view)

        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 12.0, y: 10.0, width: 20.0, height: 24.0)
        view.addSubview(imageView)

        let seperatorView = UIView()
        seperatorView.backgroundColor = colorSeparator
        mainView.addSubview(seperatorView)

        if(Direction.Left == direction){ // image left
            seperatorView.frame = CGRect(x: 45, y: 0, width: 5, height: 45)
            self.leftViewMode = .always
            self.leftView = mainView
        } else { // image right
            seperatorView.frame = CGRect(x: 0, y: 0, width: 5, height: 45)
            self.rightViewMode = .always
            self.rightView = mainView
        }

        self.layer.borderColor = colorBorder.cgColor
        self.layer.borderWidth = CGFloat(0.5)
        self.layer.cornerRadius = 5
    }

}


import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

//struct FontHelper {
//    static func regular(size: CGFloat) -> UIFont {
//        return UIFont(name: "HelveticaNeue", size: size)!
//    }
//
//    static func medium(size: CGFloat) -> UIFont {
//        return UIFont(name: "HelveticaNeue-Medium", size: size)!
//    }
//
//    static func bold(size: CGFloat) -> UIFont {
//        return UIFont(name: "HelveticaNeue-Bold", size: size)!
//    }
//}

//// MARK: - Store Data
//
//var staffID: String?
//{
//    get {
//        if let returnValue = UserDefaults.standard
//            .object(forKey: "StaffID") as? String {
//            return returnValue
//        } else {
//            return nil //Default value
//        }
//    }
//    set {
//        UserDefaults.standard.set(newValue, forKey: "StaffID")
//        UserDefaults.standard.synchronize()
//    }
//}
//
//var newHostUrl: String?
//{
//    get {
//        if let returnValue = UserDefaults.standard
//            .object(forKey: "HostUrl") as? String {
//            return returnValue
//        } else {
//            return nil //Default value
//        }
//    }
//    set {
//        UserDefaults.standard.set(newValue, forKey: "HostUrl")
//        UserDefaults.standard.synchronize()
//    }
//}
//
//var locationID: String?
//{
//    get {
//        if let returnValue = UserDefaults.standard
//            .object(forKey: "LocationID") as? String {
//            return returnValue
//        } else {
//            return nil //Default value
//        }
//    }
//    set {
//        UserDefaults.standard.set(newValue, forKey: "LocationID")
//        UserDefaults.standard.synchronize()
//    }
//}
//
//var birthDate: String?
//{
//    get {
//        if let returnValue = UserDefaults.standard
//            .object(forKey: "DOB") as? String {
//            return returnValue
//        } else {
//            return nil //Default value
//        }
//    }
//    set {
//        UserDefaults.standard.set(newValue, forKey: "DOB")
//        UserDefaults.standard.synchronize()
//    }
//}
//
//var birthdayWiseDone: Bool?
//{
//    get {
//        if let returnValue = UserDefaults.standard
//            .object(forKey: "BirthdayWish") as? Bool {
//            return returnValue
//        } else {
//            return nil //Default value
//        }
//    }
//    set {
//        UserDefaults.standard.set(newValue, forKey: "BirthdayWish")
//        UserDefaults.standard.synchronize()
//    }
//}
//
//var deviceToken: String?
//{
//    get {
//        if let returnValue = UserDefaults.standard
//            .object(forKey: "DeviceToken") as? String {
//            return returnValue
//        } else {
//            return nil //Default value
//        }
//    }
//    set {
//        UserDefaults.standard.set(newValue, forKey: "DeviceToken")
//        UserDefaults.standard.synchronize()
//    }
//}
//
//// MARK: - Functions
//
//func addBorder(_ obj:AnyObject)
//{
//    obj.layer.cornerRadius = 5.0
//    obj.layer.borderColor  = GetColor.blue.cgColor
//    obj.layer.borderWidth  = 0.5
//}
//
func add(asChildViewController viewController: UIViewController, _ selfVC:UIViewController) {
    
    selfVC.addChild(viewController)
    selfVC.view.addSubview(viewController.view)
    viewController.view.frame = selfVC.view.bounds
    viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    viewController.didMove(toParent: selfVC)
}
//var isGotoDashBoard = ""

//func BackToDashbord(VC: UIViewController){
//    isGotoDashBoard = ""
//    for controller in VC.navigationController!.viewControllers as Array {
//        //Bhargav Hide
//////print(controller)
//        if controller.isKind(of: DashboardVC.self) {
//            VC.navigationController!.popToViewController(controller, animated: false)
////            break
//        }
//    }
//}

//
//// MARK: - Class
//
//class CustomButton: UIButton {
//
//    @IBInspectable open var strImageName: String = "" {
//        didSet {
//            self.loadIconsFromLocal(strImageName)
//        }
//    }
//}
//
//class SquareButton: UIButton {
//
//    override func awakeFromNib() {
//        addBorder(self)
//    }
//}
//
//class ShadowButton: UIButton {
//
//    @IBInspectable open var strImageName: String = "" {
//        didSet {
//            self.loadIconsFromLocal(strImageName)
//        }
//    }
//
//    override func awakeFromNib() {
//        self.addShadowWithRadiusForButton(3, 0)
//    }
//}
//
//class AnimatedButton: TransitionButton {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor = GetColor.blue
//        self.setTitle("LOGIN", for: .normal)
//        self.setTitleColor(.white, for: .normal)
//        self.titleLabel?.font = FontHelper.bold(size: 16)
//        self.cornerRadius = 5.0
//        self.spinnerColor = .white
//    }
//
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//class CustomImageView: UIImageView {
//
//    @IBInspectable open var strImageName: String = "" {
//        didSet {
//            self.loadIconsFromLocal(strImageName)
//        }
//    }
//}
//
//class PlaceHolderImageView: UIImageView {
//
//    @IBInspectable open var strImageName: String!
//
//    override func awakeFromNib() {
//        self.image = UIImage.init(named: strImageName)?.withRenderingMode(.alwaysTemplate)
//    }
//}
//
//class RoundedImageView: UIImageView {
//
//    @IBInspectable open var borderColor: UIColor = UIColor.white {
//        didSet {
//            self.layer.borderColor  = borderColor.cgColor
//        }
//    }
//
//    @IBInspectable open var strImageName: String = "" {
//        didSet {
//            self.loadIconsFromLocal(strImageName)
//        }
//    }
//
//    override func awakeFromNib() {
//        self.layer.cornerRadius = self.frame.size.width/2
//        self.clipsToBounds      = true
//        self.layer.borderWidth  = 2.0
//    }
//}
//
//class CustomTextView: UITextView {
//
//    override func awakeFromNib() {
//        addBorder(self)
//    }
//}
//
//class CustomTextField: UITextField {
//
//    override func awakeFromNib() {
//        addBorder(self)
//    }
//}
//
//class ErrorVC: UIViewController {
//
//    override func viewDidLoad() {
//
//    }
//}

//class CustomLable: UILabel {
//
//    @IBInspectable var topInset: CGFloat = 5.0
//    @IBInspectable var bottomInset: CGFloat = 5.0
//    @IBInspectable var leftInset: CGFloat = 5.0
//    @IBInspectable var rightInset: CGFloat = 5.0
//
//    override func drawText(in rect: CGRect) {
//        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
//        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
//    }
//
//    override var intrinsicContentSize: CGSize {
//        get {
//            var contentSize = super.intrinsicContentSize
//            contentSize.height += topInset + bottomInset
//            contentSize.width += leftInset + rightInset
//            return contentSize
//        }
//    }
//
//    override func awakeFromNib() {
//        self.layer.cornerRadius = 3.0
//        self.clipsToBounds      = true
//
//        self.layer.borderColor  = UIColor.lightGray.withAlphaComponent(0.5).cgColor
//        self.layer.borderWidth  = 0.5
//    }
//}
//
//class HeaderView: UIView {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubview(loadViewFromNib())
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        addSubview(loadViewFromNib())
//    }
//
//    private func loadViewFromNib() -> UIView {
//        let headerView:UIView = UINib(nibName: "HeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
//        headerView.frame = self.bounds
//        headerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        headerView.addShadowWithRadius(2, 0)
//        return headerView
//    }
//}

//var isFromPTM:Bool = false
//class CustomViewController: UIViewController {
//    var arrStandards:[String] = []
////    var strStdID:String!
//    let dicStandards:NSMutableDictionary = [:]
//
//    var selectedIndex:NSInteger = -1
//    var btnDate:UIButton!
//    var finishedLoadingInitialTableCells = false
//
//    override func viewDidAppear(_ animated: Bool) {
//        isFromPTM = false
//        self.initalization()
//    }
//
//    func initalization()
//    {
//        if(!(self is DeshboardVC)) {
//            (self.view.subviews[0].subviews[0].subviews[0] as! UIButton).setTitle(self.title?.uppercased(), for: .normal)
//            (self.view.subviews[0].subviews[0].subviews[1] as! UIButton).addTarget(self, action: #selector(logOut), for: .touchUpInside)
//            (self.view.subviews[0].subviews[0].subviews[2] as! UIButton).addTarget(self, action: #selector(back), for: .touchUpInside)
//        }
//    }
//
//    @IBAction func logOut()
//    {
//        Functions.showCustomAlert("Logout", Message.logOutMsg) { (_) in
//            let params = ["StaffID" : staffID!,
//                          "DeviceID" : UIDevice.current.identifierForVendor!.uuidString]
//
//            Functions.callApi(vc: self, api: API.deleteDeviceDetailStaffApi, params: params) { (json,error) in
//                if(json != nil){
//                    Constants.appDelegate.registerForPushNotification(false)
//                    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
//                    Constants.appDelegate.rootViewController("ViewController")
//                }
//            }
//        }
//    }
//
//    //    @objc(tableView:willDisplayCell:forRowAtIndexPath:) func tableView(_ tableView: UITableView, willDisplay cell:
//    //        UITableViewCell, forRowAt indexPath: IndexPath) {
//    //        let rotationAngleInRadians = 360.0 * CGFloat(M_PI/360.0)
//    //        let rotationTransform = CATransform3DMakeRotation(rotationAngleInRadians, -500, 100, 0)
//    ////        let rotationTransform = CATransform3DMakeRotation(rotationAngleInRadians, 0, 0, 1)
//    //        cell.layer.transform = rotationTransform
//    //        UIView.animate(withDuration: 1.0, animations: {cell.layer.transform = CATransform3DIdentity})
//    //    }
//
//    //    @objc(tableView:willDisplayCell:forRowAtIndexPath:) func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
//    //    {
//    //        //1. Setup the CATransform3D structure
//    //        var rotation = CATransform3DMakeRotation( CGFloat((90.0 * M_PI)/180), 0.0, 0.7, 0.4);
//    //        rotation.m34 = 1.0 / -600
//    //
//    //
//    //        //2. Define the initial state (Before the animation)
//    //        cell.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
//    //        cell.alpha = 0;
//    //
//    //        cell.layer.transform = rotation;
//    //        cell.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
//    //
//    //
//    //        //3. Define the final state (After the animation) and commit the animation
//    //        cell.layer.transform = rotation
//    //        UIView.animate(withDuration: 0.8, animations:{cell.layer.transform = CATransform3DIdentity})
//    //        cell.alpha = 1
//    //        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
//    //        UIView.commitAnimations()
//    //
//    //    }
//
//    //    @objc(tableView:willDisplayCell:forRowAtIndexPath:) func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//    //        //if (shownIndexes.contains(indexPath) == false) {
//    //            //shownIndexes.append(indexPath)
//    //
//    ////            cell.transform = CGAffineTransform(translationX: 0, y: 0)
//    ////            cell.layer.shadowColor = UIColor.black.cgColor
//    ////            cell.layer.shadowOffset = CGSize(width: 10, height: 10)
//    ////            cell.alpha = 0
//    ////
//    ////            UIView.beginAnimations("rotation", context: nil)
//    ////            UIView.setAnimationDuration(0.5)
//    ////            cell.transform = CGAffineTransform(translationX: 0, y: 0)
//    ////            cell.alpha = 1
//    ////            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
//    ////            UIView.commitAnimations()
//    //        //}
//    //
//    //        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
//    //        UIView.animate(withDuration: 0.3, animations: {
//    //            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
//    //        },completion: { finished in
//    //            UIView.animate(withDuration: 0.1, animations: {
//    //                cell.layer.transform = CATransform3DMakeScale(1,1,1)
//    //            })
//    //        })
//    //    }
//
//    @IBAction func back()
//    {
//        if (self is AddDailyWorkVC)
//        {
//////                self.navigationController?.pushPopTransition(controller,false)
//////                self.navigationController?.pushPopTransition(Constants.storyBoard.instantiateViewController(withIdentifier: "DailyWorkVC"),true)
////                self.performSegue(withIdentifier: "DailyWorkVC", sender: self)
////
//////                break
////            var viewController:DailyWorkVC = Constants.storyBoard.instantiateViewController(withIdentifier: "DailyWorkVC") as! DailyWorkVC
////            viewController.title = "Daily Work"
////
////            add(asChildViewController: viewController, self)
////            return viewController
//            guard parent != nil else { return }
//
//            willMove(toParentViewController: nil)
//            removeFromParentViewController()
//            view.removeFromSuperview()
//
//            }
//            else
//            {
//                self.dismiss(animated: true, completion: nil)
//            }
//        }
////    }
//}

//// MARK: - Extensions
//
//extension String {
//    func isValidEmail() -> Bool {
//        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
//        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: characters.count)) != nil
//    }
//
//    func toDate( dateFormat format  : String) -> Date
//    {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format
//        if let date = dateFormatter.date(from: self)
//        {
//            return date
//        }
//        return Date()
//    }
//
//    func removeHtmlFromString(inPutString: String) -> String{
//        var str:String = inPutString
//        str = str.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
//        str = str.replacingOccurrences(of: "&nbsp;", with: "")
//        return str.components(separatedBy: .whitespacesAndNewlines).joined()
//    }
//
//    func stringFromHTML(_ string: String?) -> NSAttributedString?
//    {
//        guard let data = data(using: .utf8) else { return NSAttributedString() }
//        do{
//            let attrStr:NSAttributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
//
//            let newStr:NSMutableAttributedString = attrStr.mutableCopy() as! NSMutableAttributedString
//
//            var range:NSRange = (newStr.string as NSString).rangeOfCharacter(from: .whitespacesAndNewlines)
//
//            // Trim leading characters from character set.
//            while range.length != 0 && range.location == 0 {
//                newStr.replaceCharacters(in: range, with: "")
//                range = (newStr.string as NSString).rangeOfCharacter(from: .whitespacesAndNewlines)
//            }
//
//            // Trim trailing characters from character set.
//            range = (newStr.string as NSString).rangeOfCharacter(from: .whitespacesAndNewlines, options: .backwards)
//            while range.length != 0 && NSMaxRange(range) == newStr.length {
//                newStr.replaceCharacters(in: range, with: "")
//                range = (newStr.string as NSString).rangeOfCharacter(from: .whitespacesAndNewlines, options: .backwards)
//            }
//            return NSAttributedString.init(attributedString: newStr)
//        } catch
//        {
//            //Bhargav Hide
////print("html error\n",error)
//        }
//        return nil
//    }
//}
//
//extension NSMutableDictionary {
//    func sortedDictionary(_ dict:NSMutableDictionary)->([String],[String]) {
//
//        let values = (dict.allKeys as! [String]).sorted {
//            (s1, s2) -> Bool in return s1.localizedStandardCompare(s2) == .orderedAscending
//        }
//
//        var sortedArray:[String] = []
//        for item in values {
//            sortedArray.append(item.components(separatedBy: "-").last!)
//        }
//        return (values, sortedArray)
//    }
//
//    func keyedOrValueExist(key: Key) -> Value? {
//        return self[key] ?? nil
//    }
//}
//
//extension Date {
//    func toString( dateFormat format  : String ) -> String
//    {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format
//        return dateFormatter.string(from: self)
//    }
//}
//
//extension UIColor {
//    class func rbg(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
//        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
//        return color
//    }
//}
//
extension String {
    var withoutHtmlTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options:
            .regularExpression, range: nil).replacingOccurrences(of: "&[^;]+;", with:
                "", options:.regularExpression, range: nil)
    }
}
//extension UIView {
//    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//
//        self.layer.mask = mask
//    }
//}

extension UIView {
    //    func shake() {
    //        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
    //        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    //        animation.duration = 0.6
    //        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
    //        layer.add(animation, forKey: "shake")
    //    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func addShadowWithRadius(_ sRadius:CGFloat, _ cRadius:CGFloat, _ bRadius:CGFloat, color: UIColor)
    {
        if cRadius > 0 {
            self.layer.cornerRadius = cRadius
        }
        if bRadius > 0 {
            //            self.layer.borderColor  = UIColor.lightGray.cgColor
            self.layer.borderColor  = color.cgColor
            
            self.layer.borderWidth  = bRadius
        }
        
        self.layer.shadowColor = GetColor.shadowColor.cgColor
        self.layer.shadowRadius = sRadius
        self.layer.shadowOffset = CGSize(width:0.0,height:sRadius)
        self.layer.shadowOpacity = 1.0
    }
    
    func addGradiantColor( first_color: UIColor, color: UIColor)
    {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = [first_color.cgColor, first_color.cgColor]
        
        self.layer.insertSublayer(gradient, at: 0)
    }
    //
    //}
    //
    //extension UIView {
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }

    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
}

//
extension UIButton {
    func makeSemiCircle(){
        let circlePath = UIBezierPath.init(arcCenter: CGPoint(x:self.bounds.size.width / 2, y:0), radius: self.bounds.size.height, startAngle: 0.0, endAngle: 180, clockwise: true)
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath.cgPath
        self.layer.mask = circleShape
    }
    
    //    func addShadowWithRadiusForButton(_ qty:CGFloat, _ radius:CGFloat, color: UIColor)
    //    {
    //        self.addShadowWithRadius(qty, radius, <#CGFloat#>, color: color)
    //    }
    
    //    func loadIconsFromLocal(_ iconName:String)
    //    {
    //        let fileURL = Constants.documentsDirectoryURL.appendingPathComponent("\(iconName).png")
    //
    //        if FileManager.default.fileExists(atPath: fileURL.path) {
    //            self.setImage(UIImage.init(contentsOfFile: fileURL.path), for: .normal)
    //            return
    //        }
    //
    //        let url:URL = URL.init(string: "\(API.iconsLinkUrl)\(iconName).png")!
    //
    //        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
    //
    //        Alamofire.download(
    //            url,
    //            method: .get,
    //            parameters: nil,
    //            encoding: JSONEncoding.default,
    //            headers: nil,
    //            to: destination).downloadProgress(closure: { (progress) in
    //
    //            }).response { response in
    //
    //                if let localURL = response.destinationURL {
    //                    //Bhargav Hide
    ////print(localURL)
    //                    self.setImage(UIImage.init(contentsOfFile: localURL.path), for: .normal)
    //                }
    //        }
    //    }
}
//
//extension UIImageView {
//    public func setImageWithFadeFromURL(url: URL, placeholderImage placeholder: UIImage? = nil, animationDuration: Double = 0.3, finish:@escaping ()->Void) {
//
//        self.sd_setImage(with: url, placeholderImage: placeholder, options: .transformAnimatedImage){ (fetchedImage, error, cacheType, url) in
//            if error != nil {
//                //Bhargav Hide
//////print("Error loading Image from URL: \(String(describing: url))\n(error?.localizedDescription)")
//                self.image = placeholder
//                return
//            }
//            self.alpha = 0
//            self.image = fetchedImage
//            UIView.transition(with: self, duration: (cacheType == .none ? animationDuration : 0), options: .transitionCrossDissolve, animations: { () -> Void in
//                self.alpha = 1
//            }, completion: { (finished: Bool) in
//                //                finish
//            })
//        }
//    }
//
//    public func cancelImageLoad() {
//        self.sd_cancelCurrentImageLoad()
//    }
//
//    //    func getImagesfromLocal(_ strImageName:String)
//    //    {
//    //        let strNewImageName:String = "\(strImageName.replacingOccurrences(of: "/", with: "_")).png"
//    //
//    //        let fileURL = Constants.documentsDirectoryURL.appendingPathComponent("\(strNewImageName)")
//    //
//    //        if FileManager.default.fileExists(atPath: fileURL.path) {
//    //            //Bhargav Hide
//////print("Image Is there")
//    //            self.image = UIImage.init(contentsOfFile: fileURL.path)
//    //        }else{
//    //            self.storeImages(fileURL,strNewImageName)
//    //        }
//    //    }
//    //
//    //    func storeImages(_ imageUrl:URL ,_ imageName:String)
//    //    {
//    //        let strImageLink:String = "\(API.imagesLinkUrl)\(imageName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
//    //
//    //        self.sd_setImage(with: URL.init(string: strImageLink), completed: { (fetchedImage, error, _, _) in
//    //
//    //            if(error != nil){
//    //                return
//    //            }
//    //
//    //            do {
//    //                try UIImagePNGRepresentation(fetchedImage!)!.write(to: imageUrl)
//    //                //Bhargav Hide
//////print("Image added successfully")
//    //            } catch {
//    //                //Bhargav Hide
//////print(error)
//    //            }
//    //        })
//    //    }
//
//    //    func loadIconsFromLocal(_ iconName:String)
//    //    {
//    //        let fileURL = Constants.documentsDirectoryURL.appendingPathComponent("\(iconName).png")
//    //
//    //        if FileManager.default.fileExists(atPath: fileURL.path) {
//    //            self.image = UIImage.init(contentsOfFile: fileURL.path)
//    //            return
//    //        }
//    //
//    //        let url:URL = URL.init(string: "\(API.iconsLinkUrl)\(iconName).png")!
//    //
//    //        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
//    //
//    //        Alamofire.download(
//    //            url,
//    //            method: .get,
//    //            parameters: nil,
//    //            encoding: JSONEncoding.default,
//    //            headers: nil,
//    //            to: destination).downloadProgress(closure: { (progress) in
//    //
//    //            }).response { response in
//    //
//    //                if let localURL = response.destinationURL {
//    //                    //Bhargav Hide
//////print(localURL)
//    //                    self.image = UIImage.init(contentsOfFile: localURL.path)
//    //                }
//    //        }
//    //    }
//}
//import CoreTelephony
enum VersionError: Error {
    case invalidResponse, invalidBundleInfo
}

import CoreTelephony

//class NetworkManager {
//
//    //shared instance
//    static let shared = NetworkManager()
//    var strStatus = ""
//    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
//    var window: UIWindow?
//    var strMsgDisplay = ""
//
//    func startNetworkReachabilityObserver() {
//        self.checkNetworkTimer.invalidate()
//
//        reachabilityManager?.listener = { status in
//            switch status {
//            case .notReachable:
//                print("The network is not reachable")
//                self.strStatus = "notReachable"
//                if self.strMsgDisplay == "no"
//                {
//                }else{
//                    let alert = UIAlertController(title: "Alert", message: "The network is not reachable", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//                        switch action.style{
//                        case .default:
//                            print("default")
//
//                        case .cancel:
//                            print("cancel")
//
//                        case .destructive:
//                            print("destructive")
//
//                            //                @unknown default:
//                            //                    print("destructive")
//                        }}))
//                    //                self.navigationController.present(alert, animated: true, completion: nil)
//                    self.window?.rootViewController?.present(alert, animated: true, completion: nil)
//                }
//            case .unknown :
//                print("It is unknown whether the network is reachable")
//                self.strStatus = "notReachable"
//
//            case .reachable(.ethernetOrWiFi):
//                print("The network is reachable over the WiFi connection")
//                self.strStatus = "ethernetOrWiFi"
//
//            case .reachable(.wwan):
//                print("The network is reachable over the WWAN connection")
//                self.strStatus = "wwan"
//                self.checkNetworkTimer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(self.checkNetwork), userInfo: nil, repeats: true)
//                //            activeTimer = Timer.scheduledTimer(timeInterval: durationTime, target: self, selector: #selector(self.slideImage), userInfo: nil, repeats: true)
//
//                //Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: Selector(("checkNetwork")), userInfo: nil, repeats: true)
//                //{
//                //
//                //}
//            }
//        }
//
//        // start listening
//        reachabilityManager?.startListening()
//    }
//    var checkNetworkTimer = Timer()
//
//
//    @objc func checkNetwork()
//    {
//        NSLog("Celluler Network Metho Start....")
//        let networkInfo = CTTelephonyNetworkInfo()
//        let networkString = networkInfo.currentRadioAccessTechnology ?? ""
//        //        let tecnology = RadioAccessTechnology(rawValue: networkString)
//        //        print("strStatus...........................................",tecnology?.description ?? "")
//        //        print(tecnology?.description ?? "")
//        //        if tecnology?.description == strcellulerNetworkGloble//strSelectedNetwork == NetworkManager.shared.strStatus
//        //        {}
//        //        else
//        //        {
//        //            if tecnology?.description == "2G"
//        //            {
//        //                strcellulerNetworkGloble = "2G"
//        //                // timer.invalidate()
//        //                self.window?.rootViewController?.view.makeToast("The internet connection is very poor..", duration: 3.0, position: .bottom)
//        //            }
//        //            else if tecnology?.description == "3G"
//        //            {
//        //                strcellulerNetworkGloble = "3G"
//        //                // timer.invalidate()
//        //                self.window?.rootViewController?.view.makeToast("The internet connection is slow.. ", duration: 3.0, position: .bottom)
//        //            }
//        //            else if tecnology?.description == "4G"
//        //            {
//        //                strcellulerNetworkGloble = "4G"
//        //            }
//        //            else
//        //            {
//        //                strcellulerNetworkGloble = ""
//        //            }
//        //        }
//    }
//}

extension UINavigationController {
    func pushPopTransition(_ pushPopVC:UIViewController, _ isPush:Bool) {
        let transition = CATransition()
        transition.duration = 0.5
        //        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        //        transition.type = kCATransitionMoveIn
        //        switch arc4random()%4 {
        //        case 0:
        //            transition.subtype = kCATransitionFromTop
        //        case 1:
        //            transition.subtype = kCATransitionFromBottom
        //        case 2:
        //        default:
        //        }
        if isPush {
            //            transition.subtype = kCATransitionFromLeft
            self.view.layer.add(transition, forKey: nil)
            self.pushViewController(pushPopVC, animated: false)
        }else{
            //            transition.subtype = kCATransitionFromRight
            self.view.layer.add(transition, forKey: nil)
            self.popToViewController(pushPopVC, animated: false)
        }
    }
}
extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
