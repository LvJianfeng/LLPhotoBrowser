//
//  LLAssetManager.swift
//  LLPhotoBrowser
//
//  Created by LvJianfeng on 2017/4/27.
//  Copyright © 2017年 LvJianfeng. All rights reserved.
//

import UIKit

class LLAssetManager {
    static func image(_ named: String) -> UIImage? {
        return UIImage(named: "LLPhotoBrowser.bundle/\(named)", in: Bundle(for: LLAssetManager.self), compatibleWith: nil)
    }
}
