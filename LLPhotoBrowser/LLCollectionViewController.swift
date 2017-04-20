//
//  LLCollectionViewController.swift
//  LLPhotoBrowser
//
//  Created by LvJianfeng on 2017/4/14.
//  Copyright © 2017年 LvJianfeng. All rights reserved.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "LLCollectionViewCell"

class LLCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    /// 1.0.0 数据源
    let bigUrlArray1_0_0  = [ "http://car0.autoimg.cn/upload/spec/5900/1024x0_1_q87_2011071303265437981.jpg",
                        "http://car0.autoimg.cn/upload/spec/5900/1024x0_1_q87_2011071303245992681.jpg",
                        "http://car1.autoimg.cn/upload/spec/8550/1024x0_1_q87_20110604123334815123.jpg",
                        "http://car0.autoimg.cn/upload/spec/6032/1024x0_1_q87_20101125144828435240.jpg",
                        "http://car1.autoimg.cn/upload/spec/6032/1024x0_1_q87_20101125144819544240.jpg",
                        "http://img.bizhi.sogou.com/images/2015/05/25/1181600.jpg",
                        "http://img.bizhi.sogou.com/images/2014/10/17/921510.jpg",
                        "http://img1b.xgo-img.com.cn/pics/2130/b2129617.jpg",
                        "http://img1a.xgo-img.com.cn/pics/2153/b2152556.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/140826/3-140R6142K1.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/140825/3-140R5163J8.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/140825/3-140R5143303.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/140825/3-140R5142J3.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/140825/3-140R5115546.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/140823/3-140R3143405.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/140823/3-140R3141504.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/140823/3-140R3105544.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/140823/4-140R3103I0.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141104/3-141104100544.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141103/3-141103113411.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141103/3-141103102347.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141103/3-141103094202.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141103/3-141103102212.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141103/3-141103095639.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141031/4-141031144339.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141031/4-141031144104.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141031/4-141031141938.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141031/1-141031112U4.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141030/3-141030104145.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141027/3-14102F95609.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141024/3-141024105111.jpg"]
    
    /// 1.0.1 数据源
    let bigUrlArray1_0_1: [Any?] = [ "taobao",
                                     "baidu",
                        "http://car0.autoimg.cn/upload/spec/5900/1024x0_1_q87_2011071303265437981.jpg",
                        "http://car0.autoimg.cn/upload/spec/5900/1024x0_1_q87_2011071303245992681.jpg",
                        "http://car1.autoimg.cn/upload/spec/8550/1024x0_1_q87_20110604123334815123.jpg",
                        "http://car0.autoimg.cn/upload/spec/6032/1024x0_1_q87_20101125144828435240.jpg",
                        "http://car1.autoimg.cn/upload/spec/6032/1024x0_1_q87_20101125144819544240.jpg",
                        "http://img.bizhi.sogou.com/images/2015/05/25/1181600.jpg",
                        
                        "timg",
                        "timg-1",
                        
                        "http://img1a.xgo-img.com.cn/pics/2153/b2152556.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/140826/3-140R6142K1.jpg",
                        
                        "timg-2",
                        "timg-3",
                        "timg-4",
                        
                        "http://4493bz.1985t.com/uploads/allimg/140825/3-140R5143303.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/140825/3-140R5142J3.jpg",
                        
                        UIImage.init(named: "timg-5"),
                        UIImage.init(named: "timg-7"),
                        
                        "http://4493bz.1985t.com/uploads/allimg/140825/3-140R5115546.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/140823/3-140R3143405.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/140823/3-140R3141504.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/140823/3-140R3105544.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/140823/4-140R3103I0.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141104/3-141104100544.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141103/3-141103102212.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141103/3-141103095639.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141031/4-141031144339.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141031/4-141031144104.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141031/4-141031141938.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141031/1-141031112U4.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141030/3-141030104145.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141027/3-14102F95609.jpg",
                        "http://4493bz.1985t.com/uploads/allimg/141024/3-141024105111.jpg"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView?.register(UINib.init(nibName: "LLCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier )
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bigUrlArray1_0_1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LLCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LLCollectionViewCell
    
        // Configure the cell
        // 1.0.0
        // let url = URL.init(string: bigUrlArray1_0_0[indexPath.row])!
        // cell.ll_imageView.kf.setImage(with: url)
        
        // 1.0.1
        let data = bigUrlArray1_0_1[indexPath.row]
        if data is UIImage {
            cell.ll_imageView.image = data as? UIImage
        }else if data is String {
            if (data as! String).hasPrefix("http") {
                cell.ll_imageView.kf.setImage(with: URL.init(string: data as! String)!)
            }else{
                cell.ll_imageView.image = UIImage.init(named: data as! String)
            }
        }
        
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var data: [LLBrowserModel] = []
        for index in 0..<bigUrlArray1_0_1.count {
            let cell: LLCollectionViewCell? = collectionView.cellForItem(at: IndexPath.init(row: index, section: 0)) as? LLCollectionViewCell
            let model = LLBrowserModel.init()
            model.data = bigUrlArray1_0_1[index]
            if let c = cell {
                model.sourceImageView = c.ll_imageView
            }
            
            data.append(model)
        }
        
        let browser = LLPhotoBrowserViewController.init(photoArray: data, currentIndex: indexPath.row, sheetTitileArray: ["分享给朋友","保存到相册"], isOpenQRCodeCheck: true) { (index, imageView, qrcodeString) in
            print("ActionSheet点击-->下标=\(index); ImageView:\(imageView); qrcodeString:\(String(describing: qrcodeString))")
            
            if let qrcode = qrcodeString {
                UIAlertView.init(title: "二维码地址", message: qrcode, delegate: self, cancelButtonTitle: "取消").show()
            }
        }
        browser.presentBrowserViewController()
    }

    @IBAction func clear(_ sender: Any) {
        ImageCache.default.clearDiskCache()
        ImageCache.default.clearMemoryCache()
    }
}
