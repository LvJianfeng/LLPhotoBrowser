//
//  LLBrowserLoadingImageView.swift
//  LLPhotoBrowser
//
//  Created by LvJianfeng on 2017/4/14.
//  Copyright © 2017年 LvJianfeng. All rights reserved.
//

import UIKit

class LLBrowserLoadingImageView: UIImageView {

    let rotationAnimation: CABasicAnimation? = {
        let tempAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        tempAnimation.toValue = CGFloat(2 * Double.pi)
        tempAnimation.duration = 0.6
        tempAnimation.repeatCount = .greatestFiniteMagnitude
        return tempAnimation
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        image = LLAssetManager.image("ll_browserLoading")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func startAnimating() {
        isHidden = false
        layer.add(rotationAnimation!, forKey: "rotateAnimation")
    }
    
    override func stopAnimating() {
        isHidden = true
        layer.removeAnimation(forKey: "rotateAnimation")
    }
}
