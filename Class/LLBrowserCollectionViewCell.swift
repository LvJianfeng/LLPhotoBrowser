//
//  LLBrowserCollectionViewCell.swift
//  LLPhotoBrowser
//
//  Created by LvJianfeng on 2017/4/14.
//  Copyright © 2017年 LvJianfeng. All rights reserved.
//

import UIKit

typealias BrowserCollectionViewCellTapClosure = (_ browserCell: LLBrowserCollectionViewCell) -> Void
typealias BrowserCollectionViewCellLongPressClosure = (_ browserCell: LLBrowserCollectionViewCell) -> Void

open class LLBrowserCollectionViewCell: UICollectionViewCell {
    // Scroll View
    var zoomScrollView: LLBrowserZoomScrollView? = nil
    
    // Loading View
    var loadingView: LLBrowserLoadingImageView? = nil
    
    // Tap
    var tapClosure: BrowserCollectionViewCellTapClosure? = nil
    
    // LongPress
    var longPressClosure: BrowserCollectionViewCellLongPressClosure? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCell()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCell() {
        zoomScrollView = LLBrowserZoomScrollView.init()
        zoomScrollView?.tapClick(tapAction: { [weak self] in
            self?.tapClosure!(self!)
        })
        contentView.addSubview(zoomScrollView!)
        
        loadingView = LLBrowserLoadingImageView.init(frame: CGRect.zero)
        zoomScrollView?.addSubview(loadingView!)
        
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressGesture(gesture:)))
        contentView.addGestureRecognizer(longPress)
    }
    
    // Click
    func tapClick(_ tap: BrowserCollectionViewCellTapClosure? = nil) {
        tapClosure = tap
    }
    
    // Long Press
    func longPress(_ longPress: BrowserCollectionViewCellLongPressClosure? = nil) {
        longPressClosure = longPress
    }
    
    
    func longPressGesture(gesture: UILongPressGestureRecognizer) {
        if let longPressAction = longPressClosure {
            if gesture.state == .began {
                longPressAction(self)
            }
        }
    }
}
