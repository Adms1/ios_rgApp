//
//  WebViewController.swift
//  rgApp
//
//  Created by ADMS on 01/02/21.
//

import UIKit
import WebKit;

class WebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var webview: WKWebView!
    @IBOutlet var lblTitle : UILabel!
    @IBOutlet var btnBack : UIButton!
    var strTitle   = ""
    var strLoadUrl   = ""
    var isBackShow   = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

//        if isBackShow == "1"
//        {
//            btnBack.isHidden = false
//        }
//        else
//        {
//            btnBack.isHidden = true
//        }
        lblTitle.text = strTitle
        webview.navigationDelegate = self

        urlLoad()
    }

    func urlLoad() {
        let request = NSMutableURLRequest(url: NSURL(string: strLoadUrl)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        btnBack.addShadowWithRadius(0,25,0,color: UIColor.darkGray)
        btnBack.backgroundColor = UIColor.clear

        //Bhargav Hide
        print("Load URL:",strLoadUrl)
//        webview.
        webview.load(request as URLRequest)

    }
    @IBAction func Back_Clicked(_ sender: UIButton)
    {
        if isBackShow == "2"
        {
        urlLoad()
        }else{
//        btnBack.isHidden = true
//        webview.reload()
        navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func Menu_Back_Clicked(_ sender: UIButton)
    {
        navigationController?.popViewController(animated: false)
    }

    //MARK: WEBVIEW DELEGATE


    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
//        self.hideActivityIndicator()
    }

    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
//        self.hideActivityIndicator()

    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
           if navigationAction.navigationType == WKNavigationType.linkActivated {
               print("link")
            
//            btnBack.isHidden = false
            isBackShow = "2"
            decisionHandler(WKNavigationActionPolicy.allow)
               return
           }
           print("no link")
        isBackShow = ""

//        btnBack.isHidden = true
        decisionHandler(WKNavigationActionPolicy.allow)
    }

}
