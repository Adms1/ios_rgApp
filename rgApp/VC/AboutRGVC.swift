//
//  AboutRGVC.swift
//  rgApp
//
//  Created by ADMS on 08/01/21.
//

import UIKit

class AboutRGVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Back_Clicked(_ sender: UIButton)
    {
        navigationController?.popViewController(animated: true)
    }
}
