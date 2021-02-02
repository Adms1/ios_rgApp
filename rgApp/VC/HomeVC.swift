//
//  ViewController.swift
//  rgApp
//
//  Created by ADMS on 06/01/21.
//

import UIKit
import AVFoundation

class HomeVC: UIViewController {

    var arr_Item = [String]()
    var arr_Item_Name = [String]()
    @IBOutlet var collectionView_Item_1:UICollectionView!
    @IBOutlet var view_bg:UIView!

    var player: AVPlayer!
    var PlayerLayer: AVPlayerLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        playBackgoundVideo()
        SetLayout()
        //        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "CoverPage")!, iconInitialSize: CGSize(width: self.view.frame.width, height: self.view.frame.height), backgroundImage: UIImage(named: "CoverPage")!)
        //        self.view.addSubview(revealingSplashView)
        //        revealingSplashView.duration = 4.0
        //        revealingSplashView.iconColor = UIColor.red
        //        revealingSplashView.useCustomIconColor = false
        //        revealingSplashView.animationType = SplashAnimationType.twitter
        //        revealingSplashView.startAnimation(){
        //            self.setNeedsStatusBarAppearanceUpdate()
        //            print("Completed")
        //        }

    }
    @objc func willResignActive(_ notification: Notification) {
        // code to execute
        print("backmode")
        if #available(iOS 10.0, *) {
            if player.timeControlStatus == .paused{
                player.play()
            }
        } else {
            //            if player.isPlaying == false{
            //                player.play()
            //            }
        }

    }
    deinit {
        if #available(iOS 13.0, *) {
            NotificationCenter.default.removeObserver(self, name:
                                                        NSNotification.Name(rawValue: UIScene.didActivateNotification.rawValue), object: nil)
        } else {
            // Fallback on earlier versions
            NotificationCenter.default.removeObserver(self, name:
                                                        NSNotification.Name(rawValue: UIApplication.didBecomeActiveNotification.rawValue), object: nil)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 13.0, *) {
            NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIScene.didActivateNotification, object: nil)
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        }
    }
    private func playBackgoundVideo() {
        if let filePath = Bundle.main.path(forResource: "bgvideo", ofType:"mp4") {
            let filePathUrl = NSURL.fileURL(withPath: filePath)
            player = AVPlayer(url: filePathUrl)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.view.bounds
            playerLayer.videoGravity = AVLayerVideoGravity.resize
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: nil) { (_) in
                self.player?.seek(to: CMTime.zero)
                self.player?.play()
            }
            self.view_bg.layer.addSublayer(playerLayer)
            player?.play()
        }
    }

    func SetLayout() {
        collectionView_Item_1.register(UINib(nibName: "Item1CollectionViewCell", bundle: nil), forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Item1CollectionViewCell")

        arr_Item = ["Issue", "AboutRG", "PhotoGallery", "Speeches", "media", "Constitiency", "live", "contactus", "registor"]
        arr_Item_Name = ["ISSUES", "ABOUT RAHUL GANDHI", "GALLERY", "SPEECHES", "MEDIA", "CONSTITUENCY", "LIVE", "CONTACT", "REGISTER TO BECOME A VOLUNREER"]
    }
}

extension HomeVC:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    // MARK: - UICollectionViewDataSource protocol

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView_Item_1.frame.size.width/3, height: collectionView_Item_1.frame.size.width/2.6);
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr_Item.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell:Item1CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item1CollectionViewCell", for: indexPath) as! Item1CollectionViewCell
        cell.lblTitle.text = "\(arr_Item_Name[indexPath.item])"
        cell.imgBanner.image = UIImage(named: "\(arr_Item[indexPath.item])")

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
//        ["ISSUES", "ABOUT RAHUL GANDHI", "GALLERY", "SPEECHES", "MEDIA", "CONSTITUENCY", "LIVE", "CONTACT", "REGISTER TO BECOME A VOLUNREER"]
        if arr_Item_Name[indexPath.item] == "ISSUES"{

//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IssuesVC") as! IssuesVC
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            vc.strLoadUrl = "http://rgapp.admssvc.com/issue.html"
            vc.isBackShow = ""
            vc.strTitle = "\(arr_Item_Name[indexPath.item])"
            self.navigationController?.pushViewController(vc, animated: false)
        }
        else if arr_Item_Name[indexPath.item] == "ABOUT RAHUL GANDHI"
        {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            vc.strLoadUrl = "http://rgapp.admssvc.com/about.html"
            vc.isBackShow = ""
            vc.strTitle = "\(arr_Item_Name[indexPath.item])"
            self.navigationController?.pushViewController(vc, animated: false)
        }
        else if arr_Item_Name[indexPath.item] == "REGISTER TO BECOME A VOLUNREER"
        {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterVolunteerVC") as! RegisterVolunteerVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
        else if arr_Item_Name[indexPath.item] == "GALLERY"
        {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            vc.strLoadUrl = "http://rgapp.admssvc.com/Images.html"
            vc.isBackShow = ""
            vc.strTitle = "\(arr_Item_Name[indexPath.item])"
            self.navigationController?.pushViewController(vc, animated: false)
        }
        else if arr_Item_Name[indexPath.item] == "MEDIA"
        {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            vc.strLoadUrl = "http://rgapp.admssvc.com/gallery.html"
            vc.isBackShow = ""
            vc.strTitle = "\(arr_Item_Name[indexPath.item])"
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}

