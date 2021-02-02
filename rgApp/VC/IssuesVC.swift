//
//  LaunchScreenVC.swift
//  rgApp
//
//  Created by ADMS on 07/01/21.
//

import UIKit
import SDWebImage

class IssuesVC: UIViewController {
//    @IBOutlet var img:UIImageView!
    var arr_banner = [DashboardViewModel]()
    @IBOutlet var tblList:UITableView!
    @IBOutlet var lblTitle : UILabel!
    @IBOutlet var btnBack : UIButton!
    @IBOutlet var imgHeader : UIImageView!
    var strTitle   = ""

    @IBOutlet var collectionView_Banner:UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var thisWidth:CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        collectionView_Banner.register(UINib(nibName: "BennerCollectionViewCell", bundle: nil), forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "BennerCollectionViewCell")
        thisWidth = CGFloat(self.collectionView_Banner.frame.width)
        lblTitle.text = strTitle
        //"Jobs and MSME", "Agriculture", "Land Acquisition Bill", "Women Empowerment, Right to Information Act", "Net Neutrality", "Adivasi Rights", "National Rural Employment Guarantee Act", "Goods and Services Tax", "Decentralisation of Power", "Democratisation of IYC/NSUI"
//        http://rgapp.admssvc.com/media.rahulgandhi.in/banners/issue_banner.jpg
        let arrImages = ["Jobs and MSME", "Agriculture", "Land Acquisition Bill", "Women Empowerment, Right to Information Act", "Net Neutrality", "Adivasi Rights", "National Rural Employment Guarantee Act", "Goods and Services Tax", "Decentralisation of Power", "Democratisation of IYC/NSUI"]
        let arrIsue = ["Jobs and MSME", "Agriculture", "Land Acquisition Bill", "Women Empowerment, Right to Information Act", "Net Neutrality", "Adivasi Rights", "National Rural Employment Guarantee Act", "Goods and Services Tax", "Decentralisation of Power", "Democratisation of IYC/NSUI"]
        let arrIsueLink = ["Jobs and MSME", "Agriculture", "Land Acquisition Bill", "Women Empowerment, Right to Information Act", "Net Neutrality", "Adivasi Rights", "National Rural Employment Guarantee Act", "Goods and Services Tax", "Decentralisation of Power", "Democratisation of IYC/NSUI"]

        var arrTemp = [DashboardModel]()
        for i in 0..<arrIsue.count {
            let Model:DashboardModel = DashboardModel.init(id: "", title: "\(arrIsue[i])", image: "\(arrImages[i])", menu_link: "\(arrIsueLink[i])")
            arrTemp.append(Model)
        }
        imgHeader.sd_setShowActivityIndicatorView(true)
        imgHeader.sd_setIndicatorStyle(.gray)
        let url = URL.init(string:"http://rgapp.admssvc.com/media.rahulgandhi.in/banners/issue_banner.jpg".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)

//        imgHeader.addShadowWithRadius(0,cell.imgIcon.frame.width/2,0,color: UIColor.darkGray)
        imgHeader.sd_setImage(with: url, placeholderImage: nil, options: .transformAnimatedImage){ (fetchedImage, error, cacheType, url) in
            if error != nil {
                //Bhargav Hide
                ////print("Error loading Image from URL: \(String(describing: url))\n(error?.localizedDescription)")
                return
            }
            self.imgHeader.image = fetchedImage
        }

        self.arr_banner = arrTemp.map({ return DashboardViewModel(Item: $0) })
        DispatchQueue.main.async { self.tblList.reloadData() }
//        pageControl?.numberOfPages = arr_banner.count

        collectionView_Banner.isHidden = true
        pageControl.isHidden = true
//
//        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
//
//               // HERE
//            self.img.transform = CGAffineTransform.identity.scaledBy(x: 2, y: 2) // Scale your image
//
//         }) { (finished) in
//             UIView.animate(withDuration: 5, animations: {
//
//                self.img.transform = CGAffineTransform.identity // undo in 1 seconds
//
//           })
//        }
    }
    
    @IBAction func Back_Clicked(_ sender: UIButton)
    {
        navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension IssuesVC:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    // MARK: - UICollectionViewDataSource protocol
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 0 //arr_banner.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell:BennerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BennerCollectionViewCell", for: indexPath) as! BennerCollectionViewCell
            cell.lblTitle.text = "\(arr_banner[indexPath.item].title ?? "")"
        cell.imgBanner.image = UIImage(named: "\(arr_banner[indexPath.item].image ?? "")")
        cell.btnReadMore.addShadowWithRadius(0,6,0,color: GetColor.tfPlacholderColor)
        cell.btnReadMore.tag = indexPath.row
        cell.btnReadMore.addTarget(self, action: #selector(JoinIssueCliked(sender:)), for: .touchUpInside)

//            let url = URL.init(string: "\(arr_banner[indexPath.item].image ?? "")".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
//            cell.imgBanner.sd_setImage(with: url, placeholderImage: nil, options: .transformAnimatedImage){ (fetchedImage, error, cacheType, url) in
//                if error != nil {return}
//                cell.imgBanner.image = fetchedImage
//            }
            return cell

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width-CGFloat((arr_banner.count)))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        thisWidth = CGFloat(self.collectionView_Banner.frame.width)
        return CGSize(width: thisWidth, height: self.collectionView_Banner.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.item
    }

    @IBAction func JoinIssueCliked(sender:UIButton)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterVolunteerVC") as! RegisterVolunteerVC
        self.navigationController?.pushViewController(vc, animated: false)

    }

}
extension IssuesVC:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_banner.count
    }
    //My heightForRowAtIndexPath method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension//indexPath.section == selectedIndex ? UITableViewAutomaticDimension : 0

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = "ListTableViewCell"
        var cell: ListTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? ListTableViewCell
        if cell == nil {
            tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ListTableViewCell
        }
        cell.lblTitle.text = "\(arr_banner[indexPath.item].title ?? "")"

//        cell.topbgView1.addShadowWithRadius(0,8,0,color: UIColor.lightGray)
        return cell


    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
