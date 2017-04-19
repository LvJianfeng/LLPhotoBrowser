//
//  LLUIImageScale.swift
//  LLPhotoBrowser
//
//  Created by LvJianfeng on 2017/4/14.
//  Copyright © 2017年 LvJianfeng. All rights reserved.
//

import UIKit

extension UIImage {
    func getBigImageSizeWithScreenWidth(w: CGFloat, h: CGFloat) -> CGRect {
        let widthRatio = w / self.size.width
        let heightRatio = h / self.size.height
        let scale = min(widthRatio, heightRatio)
        let width = scale * self.size.width
        let height = scale * self.size.height
        return CGRect.init(x: (w - width) * 0.5, y: (h - height) * 0.5, width: width, height: height)
    }
}
