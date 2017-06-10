//
//  LLBrowserActionSheet.swift
//  LLPhotoBrowser
//
//  Created by LvJianfeng on 2017/4/18.
//  Copyright © 2017年 LvJianfeng. All rights reserved.
//

import UIKit

typealias LLDidSelectedCell = (NSInteger) -> Void

open class LLBrowserActionSheet: UIView, UITableViewDelegate, UITableViewDataSource {
    
    /// Title Array
    fileprivate var titleArray: [String]?
    
    /// Cancel Title
    fileprivate var cancelTitle: String = "取消"
    
    /// Did Selected
    fileprivate var didSelectedAction: LLDidSelectedCell? = nil

    /// TableView
    fileprivate var tableView: UITableView?
    
    /// Mask View
    fileprivate var backMaskView: UIView?
    
    /// Height
    fileprivate var tableViewHeight: CGFloat?
    
    /// Cell Height
    fileprivate var tableCellHeight: CGFloat?
    
    ///  Section View Background Color default: 191.0 191.0 191.0
    fileprivate var sectionViewBackgroundColor: UIColor? = UIColor.init(red: 191.0/255.0, green: 191.0/255.0, blue: 191.0/255.0, alpha: 1.0)
    
    /// Cell Background Color
    fileprivate var cellBackgroundColor: UIColor? = UIColor.white
    
    /// Title Font
    fileprivate var titleFont: UIFont? = UIFont.systemFont(ofSize: 14.0)
    
    /// Title Color
    fileprivate var titleTextColor: UIColor? = UIColor.black
    
    /// Cancel Color
    fileprivate var cancelTextColor: UIColor? = UIColor.black
    
    /// Line Color
    fileprivate var lineColor: UIColor? = UIColor.init(red: 212.0/255.0, green: 212.0/255.0, blue: 212.0/255.0, alpha: 1.0)
    
    /// Init
    init(titleArray: [String] = [], cancelTitle: String, cellHeight: CGFloat? = 44.0, backgroundColor: UIColor?, cellBackgroundColor: UIColor, titleFont: UIFont?, titleTextColor: UIColor?, cancelTextColor: UIColor?, lineColor: UIColor?, didSelectedCell:LLDidSelectedCell? = nil) {
        super.init(frame: CGRect.zero)
        self.titleArray = titleArray
        self.cancelTitle = cancelTitle
        self.tableCellHeight = cellHeight
        
        if let _ = backgroundColor {
           self.sectionViewBackgroundColor = backgroundColor
        }
        
        if let _ = titleFont {
            self.titleFont = titleFont
        }
        
        if let _ = titleTextColor {
            self.titleTextColor = titleTextColor
        }
        
        if let _ = cancelTextColor {
            self.cancelTextColor = cancelTextColor
        }
        
        if let _ = lineColor {
            self.lineColor = lineColor
        }
        
        self.cellBackgroundColor = cellBackgroundColor
        self.tableViewHeight = CGFloat((self.titleArray?.count)! + 1) * self.tableCellHeight! + 10.0
        self.didSelectedAction = didSelectedCell
        
        setupActionSheet()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setupActionSheet() {
        backMaskView = UIView.init()
        backMaskView?.backgroundColor = UIColor.black
        backMaskView?.alpha = 0
        // 渐变效果
        UIView.animate(withDuration: 0.3) { 
            self.backMaskView?.alpha = 0.3
        }
        addSubview(backMaskView!)
        
        tableView = UITableView.init()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorColor = UIColor.clear
        tableView?.bounces = false
        addSubview(tableView!)
    }
    
    // MARK: UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section == 1) ? 10.0 : 0
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = UIView.init()
            view.backgroundColor = sectionViewBackgroundColor!
            return view
        }
        return nil
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableCellHeight!
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? (titleArray?.count)! : 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier: String = "LLBrowserActionSheetCell"
        var cell: LLBrowserActionSheetCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? LLBrowserActionSheetCell
        if cell == nil {
            cell = LLBrowserActionSheetCell.init(style: .default, reuseIdentifier: identifier)
        }
        cell?.backgroundColor = cellBackgroundColor!
        cell?.titleLabel?.frame = CGRect.init(x: 0, y: 0, width: ll_w, height: tableCellHeight!)
        cell?.titleLabel?.font = titleFont!
        cell?.titleLabel?.textColor = titleTextColor!
        cell?.bottomLine?.backgroundColor = lineColor!
        cell?.bottomLine?.isHidden = true
        if indexPath.section == 0 {
            cell?.titleLabel?.text = titleArray?[indexPath.row]
            if (titleArray?.count)! > indexPath.row + 1 {
                cell?.bottomLine?.frame = CGRect.init(x: 0, y: tableCellHeight! - (1.0 / UIScreen.main.scale), width: self.ll_w, height: 1.0 / UIScreen.main.scale)
                cell?.bottomLine?.isHidden = false
            }
        }else{
            cell?.titleLabel?.textColor = cancelTextColor!
            cell?.titleLabel?.text = cancelTitle
        }
        
        return cell!
    }
    
    // MARK: UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            if let didSelected = didSelectedAction {
                didSelected(indexPath.row)
            }
        }
        dismiss()
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss()
    }
    
    func show(_ view: UIView) {
        view.addSubview(self)
        self.backgroundColor = UIColor.clear
        self.frame = view.bounds
        backMaskView?.frame = view.bounds
        tableView?.frame = CGRect.init(x: 0, y: ll_h, width: ll_w, height: tableViewHeight!)
        UIView.animate(withDuration: 0.3) { 
            var frame = self.tableView?.frame
            frame?.origin.y -= self.tableViewHeight!
            self.tableView?.frame = frame!
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.2, animations: { 
            var frame = self.tableView?.frame
            frame?.origin.y += self.tableViewHeight!
            self.tableView?.frame = frame!
            self.backMaskView?.alpha = 0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    func updateFrameByTransform() {
        // Update
        if let _ = self.superview {            
            self.frame = (self.superview?.bounds)!
            backMaskView?.frame = (self.superview?.bounds)!
            tableView?.frame = CGRect.init(x: 0, y: ll_h - tableViewHeight!, width: ll_w, height: tableViewHeight!)
            tableView?.reloadData()
        }
    }
}


class LLBrowserActionSheetCell: UITableViewCell {
    public var titleLabel: UILabel?
    public var bottomLine: UIView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCell() {
        titleLabel = UILabel.init()
        titleLabel?.textAlignment = .center
        contentView.addSubview(titleLabel!)
        
        bottomLine = UILabel.init()
        bottomLine?.backgroundColor = UIColor.init(red: 212.0/255.0, green: 212.0/255.0, blue: 212.0/255.0, alpha: 1.0)
        contentView.addSubview(bottomLine!)
    }
}
