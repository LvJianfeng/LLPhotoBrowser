//
//  LLLayout.swift
//  LLPhotoBrowser
//
//  Created by LvJianfeng on 2017/4/14.
//  Copyright © 2017年 LvJianfeng. All rights reserved.
//

import UIKit

// MARK: Frame
extension UIView {
    public var ll_x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(value) {
            self.frame = CGRect(x: value, y: self.ll_y, width: self.ll_w, height: self.ll_h)
        }
    }
    
    public var ll_y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(value) {
            self.frame = CGRect(x: self.ll_x, y: value, width: self.ll_w, height: self.ll_h)
        }
    }
    
    public var ll_w: CGFloat {
        get {
            return self.frame.size.width
        } set(value) {
            self.frame = CGRect(x: self.ll_x, y: self.ll_y, width: value, height: self.ll_h)
        }
    }
    
    public var ll_h: CGFloat {
        get {
            return self.frame.size.height
        } set(value) {
            self.frame = CGRect(x: self.ll_x, y: self.ll_y, width: self.ll_w, height: value)
        }
    }
    
    func ll_updateFrameInSuperviewCenterWithSize(size: CGSize) {
        self.frame = CGRect.init(x: ((self.superview?.ll_w)! - size.width) * 0.5, y: ((self.superview?.ll_h)! - size.height) * 0.5, width: size.width, height: size.height)
    }
}
