//
//  LLPhotoBrowserViewController.swift
//  LLPhotoBrowser
//
//  Created by LvJianfeng on 2017/4/17.
//  Copyright © 2017年 LvJianfeng. All rights reserved.
//

import UIKit
import Kingfisher

open class LLPhotoBrowserViewController: LLBrowserViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override open func loadBrowserImagerWithModel(item: LLBrowserModel, cell: LLBrowserCollectionViewCell, imageFrame: CGRect) {
        // Check Network Image
        if let _ = item.image {
            self.isFirstOpen = false
            loadBigImageWithItem(item: item, cell: cell, rect: imageFrame)
        }else{
            // Stop Loading
            cell.loadingView?.stopAnimating()
            // Check Cache Image
            if ImageCache.default.isImageCached(forKey: item.imageURL!).cached {
                showBigImage(imageView: (cell.zoomScrollView?.zoomImageView)!, item: item, rect: imageFrame)
            }else{
                self.isFirstOpen = false
                loadBigImageWithItem(item: item, cell: cell, rect: imageFrame)
            }
        }
    }
    
    // Show Big Pictrue
    open func showBigImage(imageView: UIImageView, item: LLBrowserModel, rect: CGRect) {
        // Cancel Request
        imageView.kf.cancelDownloadTask()
        // Disk Or Mem
        let option = ImageCache.default.isImageCached(forKey: item.imageURL!).cacheType
        // If Exist
        if option == .disk {
            imageView.image = ImageCache.default.retrieveImageInDiskCache(forKey: item.imageURL!)
        }else if option == .memory{
            imageView.image = ImageCache.default.retrieveImageInMemoryCache(forKey: item.imageURL!)
        }
        // If Big Image Frame = nil , Reload Image Frame
        let bigRect = getBigImageFrameIfIsNil(rect: rect, image: imageView.image!)
        // First Open Animation
        if self.isFirstOpen {
            self.isFirstOpen = false
            imageView.frame = getFrameInWindow(view: item.sourceImageView!)
            UIView.animate(withDuration: 0.3, animations: {
                imageView.frame = bigRect
            })
        }else{
            imageView.frame = bigRect
        }
    }
    
    // Load Big Picture
    open func loadBigImageWithItem(item: LLBrowserModel, cell: LLBrowserCollectionViewCell, rect: CGRect) {
        let imageView = cell.zoomScrollView?.zoomImageView
        // Check is need use kf
        if let itemImage = item.image {
            cell.loadingView?.stopAnimating()
            // Center Frame
            if let sourceImageView = item.sourceImageView {
                imageView?.ll_updateFrameInSuperviewCenterWithSize(size: CGSize.init(width: sourceImageView.ll_w, height: sourceImageView.ll_h))
            }
            // Set Image
            imageView?.image = itemImage
            // If Big Image Frame = nil , Reload Image Frame
            let bigRect = self.getBigImageFrameIfIsNil(rect: rect, image: itemImage)
            // Load Success
            UIView.animate(withDuration: 0.3, animations: {
                imageView?.frame = bigRect
            })
        }else{
            // Load Image
            cell.loadingView?.startAnimating()
            // Center Frame
            if let sourceImageView = item.sourceImageView {
                imageView?.ll_updateFrameInSuperviewCenterWithSize(size: CGSize.init(width: sourceImageView.ll_w, height: sourceImageView.ll_h))
            }
            
            imageView?.kf.setImage(with: URL(string: item.imageURL!)!, placeholder: (item.sourceImageView != nil && item.sourceImageView?.image != nil) ? item.sourceImageView?.image : nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) in
                // 关闭图片浏览的view，不需要继续执行动画
                if (self.collectView?.isUserInteractionEnabled)! {
                    // Stop Animation
                    cell.loadingView?.stopAnimating()
                    if error != nil {
                        self.showError("无法加载图片")
                    }else{
                        // If Big Image Frame = nil , Reload Image Frame
                        let bigRect = self.getBigImageFrameIfIsNil(rect: rect, image: image!)
                        // Load Success
                        UIView.animate(withDuration: 0.3, animations: {
                            imageView?.frame = bigRect
                        })
                    }
                }
            })
        }
    }
    
    // If Big Image Frame = nil , Reload Image Frame
    open func getBigImageFrameIfIsNil(rect: CGRect, image: UIImage) -> CGRect{
        if rect.isEmpty {
            return image.getBigImageSizeWithScreenWidth(w: self.screenWidth, h: self.screenHeight)
        }
        return rect
    }
}
