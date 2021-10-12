//
//  ProfileDetailVC.swift
//  rgApp
//
//  Created by ADMS on 02/09/21.
//

import UIKit

class ProfileDetailVC: UIViewController {

    @IBOutlet weak var scrollview:UIScrollView!
    @IBOutlet weak var btnImgProfile:UIButton!
    @IBOutlet weak var collectionVw:UICollectionView!
    //    @IBOutlet weak var collviewHeight:NSLayoutConstraint!
    @IBOutlet weak var lblUserName:UILabel!
    @IBOutlet weak var collviewHeight:NSLayoutConstraint!
    @IBOutlet weak var collView:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

       // collectionVw.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 0.5)

        collectionVw.delegate = self
        collectionVw.dataSource = self


        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: collectionVw.frame.size.width/2, height: 201)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        collectionVw!.collectionViewLayout = layout


        btnImgProfile.layer.cornerRadius = btnImgProfile.frame.height/2.0
        btnImgProfile.layer.masksToBounds = true

    }

    @IBAction func btnBackClick()
    {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        scrollview.isScrollEnabled = true
        // Do any additional setup after loading the view
        scrollview.contentSize = CGSize(width: self.view.frame.width, height: self.collviewHeight.constant + 369)

    }
    
}
extension ProfileDetailVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    // MARK: - UICollectionViewDataSource protocol

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionVw.frame.size.width/2-20, height: 201);
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileDetailCell", for: indexPath) as! ProfileDetailCell


        if 10 >= 1
        {
            self.collviewHeight.constant = self.collectionVw.contentSize.height

        }else{
            self.collviewHeight.constant = self.collectionVw.frame.height
        }

        cell.backgroundColor = UIColor.white

       // cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.borderWidth = 0.2
        cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
      //  cell.contentView.layer.masksToBounds = true

        cell.layer.shadowColor = UIColor.white.cgColor
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
//        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath

//        cell.layer.backgroundColor = UIColor.white.cgColor
//        cell.layer.shadowColor = UIColor.lightGray.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)//CGSizeMake(0, 2.0);
//        cell.layer.shadowRadius = 2.0
//        cell.layer.shadowOpacity = 0.5
//        cell.layer.masksToBounds = false


//        cell.layer.borderColor = UIColor.black.cgColor
//        cell.layer.borderWidth = 1.0

       // cell.backgroundColor = UIColor.clear

        cell.sizeToFit()
        return cell
    }
}

