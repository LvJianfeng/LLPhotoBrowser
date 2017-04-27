//
//  LLRemindView.swift
//  LLPhotoBrowser
//
//  Created by LvJianfeng on 2017/4/19.
//  Copyright © 2017年 LvJianfeng. All rights reserved.
//

import UIKit

open class LLRemindView: UIView {
    
    /// Back View
    var backMaskView: UIView?
    
    /// Remind Label
    var remindLabel: UILabel?
    
    /// Remind Icon
    var remindIcon: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRemindView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupRemindView() {
        self.alpha = 0
        backMaskView = UIView.init()
        backMaskView?.autoresizingMask = UIViewAutoresizing(rawValue: UInt(0 | 2 | 3 | 5))
        backMaskView?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backMaskView?.layer.cornerRadius = 5.0
        backMaskView?.layer.masksToBounds = true
        self.addSubview(backMaskView!)
        
        remindIcon = UIImageView.init()
        remindIcon?.autoresizingMask = UIViewAutoresizing(rawValue: UInt(0 | 2 | 3 | 5))
        remindIcon?.contentMode = .scaleAspectFit
        backMaskView?.addSubview(remindIcon!)
        
        remindLabel = UILabel.init()
        remindLabel?.autoresizingMask = UIViewAutoresizing(rawValue: UInt(0 | 2 | 3 | 5))
        remindLabel?.font = UIFont.systemFont(ofSize: 14)
        remindLabel?.textColor = UIColor.white
        remindLabel?.textAlignment = .center
        backMaskView?.addSubview(remindLabel!)
    }
    
    func getSize(_ text: String?) -> CGSize{
        var temp = text
        if (temp?.characters.count)! <= 0 || text == nil{
            temp = "发生未知错误"
        }
        return (temp! as NSString).boundingRect(with: CGSize.init(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: remindLabel?.font ?? UIFont.systemFont(ofSize: 14)], context: nil).size
        
    }
    
    func show(_ content: String? = nil) {
        let size = getSize(content)
        backMaskView?.ll_updateFrameInSuperviewCenterWithSize(size: CGSize.init(width: size.width + 20.0, height: size.height + 40.0))
        remindLabel?.ll_updateFrameInSuperviewCenterWithSize(size: size)
        remindLabel?.text = content
        self.alpha = 0
        UIView.animate(withDuration: 0.3) { 
            self.alpha = 1
        }
    }
    
    func showError(_ content: String? = nil) {
        let size = getSize(content)
        backMaskView?.ll_updateFrameInSuperviewCenterWithSize(size: CGSize.init(width: size.width + 20.0, height: size.height + 80))
        
        remindLabel?.frame = CGRect.init(x: 0, y: 72, width: size.width + 20.0, height: size.height)
        remindLabel?.text = content
        
        remindIcon?.ll_updateFrameInSuperviewCenterWithSize(size: CGSize.init(width: size.width + 20.0, height: 30))
        remindIcon?.image = LLAssetManager.image("ll_error")
        self.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
    func hide() {
        self.alpha = 1
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
        }
    }
}
