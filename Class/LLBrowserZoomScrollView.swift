//
//  LLBrowserZoomScrollView.swift
//  LLPhotoBrowser
//
//  Created by LvJianfeng on 2017/4/14.
//  Copyright © 2017年 LvJianfeng. All rights reserved.
//

import UIKit

typealias ZoomScrollViewTapClosure = () -> Void

class LLBrowserZoomScrollView: UIScrollView, UIScrollViewDelegate {

    /// ImageView
    public var zoomImageView: UIImageView? = nil
    
    /// SingleTap
    public var isSingleTap: Bool = false
    
    public var zoomScrollViewTapClosure: ZoomScrollViewTapClosure?
    
    /// Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        createZoomScrollView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Create
    func createZoomScrollView() {
        isSingleTap = false
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        delegate = self
        minimumZoomScale = 1.0
        maximumZoomScale = 3.0
        
        zoomImageView = UIImageView.init()
        zoomImageView?.isUserInteractionEnabled = true
        self.addSubview(zoomImageView!)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return zoomImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // Center
        var rect = zoomImageView?.frame
        rect?.origin.x = 0
        rect?.origin.y = 0
        if (rect?.size.width)! < ll_w {
            rect?.origin.x = CGFloat(floorf(Float((ll_w - (rect?.size.width)!) * 0.5)))
        }
        if (rect?.size.height)! < ll_h {
            rect?.origin.y = CGFloat(floorf(Float((ll_h - (rect?.size.height)!) * 0.5)))
        }
        zoomImageView?.frame = rect!
    }
    
    /// Click
    func tapClick(tapAction: ZoomScrollViewTapClosure? = nil) {
        zoomScrollViewTapClosure = tapAction
    }
    
    /// Touch
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = (touches as NSSet).anyObject() as! UITouch
        if touch.tapCount == 1 {
            self.perform(#selector(singleTapClick), with: nil, afterDelay: 0.3)
        }else{
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            if !isSingleTap {
                let touchPoint = touch.location(in: zoomImageView)
                zoomDoubleTapWithPoint(touchPoint: touchPoint)
            }
        }
    }
    
    /// Single Click
    func singleTapClick() {
        isSingleTap = true
        if let closure = zoomScrollViewTapClosure {
            closure()
        }
    }
    
    /// Zoom
    func zoomDoubleTapWithPoint(touchPoint: CGPoint) {
        if zoomScale > minimumZoomScale {
            self.setZoomScale(minimumZoomScale, animated: true)
        }else{
            let width = self.bounds.size.width / maximumZoomScale
            let height = self.bounds.size.height / maximumZoomScale
            self.zoom(to: CGRect.init(x: touchPoint.x - width * 0.5, y: touchPoint.y - height * 0.5, width: width, height: height), animated: true)
        }
    }
}
