//
//  LLBrowserViewController.swift
//  LLPhotoBrowser
//
//  Created by LvJianfeng on 2017/4/14.
//  Copyright © 2017年 LvJianfeng. All rights reserved.
//

import UIKit

public typealias LLDidActionSheetAction = (NSInteger, UIImageView, String?) -> Void

let k_LL_ScreenWidth = UIScreen.main.bounds.size.width
let k_LL_ScreenHeight = UIScreen.main.bounds.size.height
let k_LL_QRCodeTitle = "识别图中二维码"
let presentAnimator = LLPresentAnimator()
let dismissAnimator = LLDismissAnimator()

/// Image Object
open class LLBrowserModel: NSObject {
    // Data
    open var data: Any? = nil {
        didSet {
            if data is UIImage {
                image = data as? UIImage
            }else if data is String {
                if (data as! String).hasPrefix("http") {
                    imageURL = data as? String
                }else{
                    image = UIImage.init(named: data as! String)
                }
            }else{
                image = LLAssetManager.image("ll_placeholder")
            }
        }
    }
    
    // Thumbnail Data
    open var thumbnailData: Any? = nil {
        didSet {
            if thumbnailData is UIImage {
                thumbnailImage = thumbnailData as? UIImage
            }else if thumbnailData is String {
                if (thumbnailData as! String).hasPrefix("http") {
                    thumbnailURL = thumbnailData as? String
                }else{
                    thumbnailImage = UIImage.init(named: thumbnailData as! String)
                }
            }else{
                thumbnailImage = LLAssetManager.image("ll_placeholder")
            }
        }
        
    }
    
    // URL
    open var imageURL: String? = nil {
        didSet {
            if let url = imageURL {
                isHttpsURL = url.hasPrefix("https")
            }
        }
    }
    
    // Image
    open var image: UIImage?  = nil
    
    // Thumbnail URL
    open var thumbnailURL: String? = nil {
        didSet {
            if let url = thumbnailURL {
                isHttpsURL = url.hasPrefix("https")
            }
        }
    }
    
    // Thumbnail
    open var thumbnailImage: UIImage? = nil
    
    // Source Image
    open var sourceImageView: UIImageView? = nil
    
    // IS Https
    open var isHttpsURL: Bool = false
}

/// Browser View Controller
open class LLBrowserViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout ,UIViewControllerTransitioningDelegate {
    /// Device
    fileprivate var isRotate: Bool = false
    
    /// First Open
    open var isFirstOpen: Bool = false
    
    /// Ratio
    fileprivate var isEqualRatio: Bool = false
    
    /// UIImage Or URL
    fileprivate var photoArray: [LLBrowserModel]?
    
    /// Current Index
    fileprivate var currentIndex: NSInteger = 0
    
    /// ActionSheet Title Array
    fileprivate var sheetTitileArray: [String]? = []
    
    /// Show Current Index Label
    fileprivate var currentIndexLabel: UILabel?
    
    /// Vertical Big Rect Array
    fileprivate var verticalBigRectArray: [NSValue]?
    
    /// Horizontal Big Rect Array
    fileprivate var horizontalBigRectArray: [NSValue]?
    
    /// UIDeviceOrientation
    fileprivate var currentOrientation: UIDeviceOrientation?
    
    /// Can Use QRCode Default false
    fileprivate var isOpenQRCodeCheck: Bool = false
    
    /// Background View
    fileprivate var backView: UIView?
    
    /// History Image Rect Frame
    fileprivate var onceImageViewHistoryRect: CGRect
    
    /// Collection View
    open var collectView: UICollectionView?
    
    /// Remind View
    open var remindView: LLRemindView?
    
    /// Action Sheet
    open var browserActionSheet: LLBrowserActionSheet?
    
    /// Action Sheet Did
    open var didActionSheetSelected: LLDidActionSheetAction?
    
    /// Screen Width
    open var screenWidth = UIScreen.main.bounds.size.width
    
    /// Screen Height
    open var screenHeight = UIScreen.main.bounds.size.height
    
    /// Space
    fileprivate let browserSpace: CGFloat = 20.0
    
    /// Custom ActionSheet Style
    /// Background Color
    open var actionSheetBackgroundColor: UIColor?
    
    /// Cell Height default 44.0
    open var actionSheetCellHeight: CGFloat? = 44.0
    
    /// Cell Background Color default white
    open var actionSheetCellBackgroundColor: UIColor? = UIColor.white
    
    /// Title Font default UIFont.systemFont(ofSize: 15.0)
    open var actionSheetTitleFont: UIFont? = UIFont.systemFont(ofSize: 15.0)
    
    /// Title Color default black
    open var actionSheetTitleTextColor: UIColor? = UIColor.black

    /// Cancel Color default black
    open var actionSheetCancelTextColor: UIColor? = UIColor.black
    
    /// Cancel Title default 取消
    open var actionSheetCancelTitle: String? = "取消"
    
    /// Line Color default 212.0 212.0 212.0
    open var actionSheetLineColor: UIColor? = UIColor.init(red: 212.0/255.0, green: 212.0/255.0, blue: 212.0/255.0, alpha: 1.0)
    
    /// Init With Data
    public init(photoArray: [LLBrowserModel], currentIndex: NSInteger, sheetTitileArray: [String]? = nil, isOpenQRCodeCheck: Bool = false, didActionSheet: LLDidActionSheetAction? = nil) {
        self.photoArray = photoArray
        self.currentIndex = currentIndex
        self.sheetTitileArray = sheetTitileArray
        self.isEqualRatio = true
        self.isFirstOpen = true
        self.isOpenQRCodeCheck = isOpenQRCodeCheck
        self.screenWidth = k_LL_ScreenWidth
        self.screenHeight = k_LL_ScreenHeight
        self.currentOrientation = UIDeviceOrientation.portrait
        self.verticalBigRectArray = []
        self.horizontalBigRectArray = []
        self.didActionSheetSelected = didActionSheet
        self.onceImageViewHistoryRect = CGRect.zero
        
        super.init(nibName: nil, bundle: nil)
        
        // UIViewControllerTransitioningDelegate
        self.transitioningDelegate = self
        
        // UIModalPresentationStyle
        self.modalPresentationStyle = .custom
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Dealloc
    deinit {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
    }
    
    // View Did Load
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Init Data
        initData()
        createBrowserView()
    }
    
    // Init Data
    func initData() {
        for browserModel in photoArray! {
            var vRect = CGRect.zero
            var hRect = CGRect.zero
            // Scale
            if isEqualRatio {
                if let sourceImageView = browserModel.sourceImageView, sourceImageView.image != nil {
                    vRect = (sourceImageView.image?.getBigImageSizeWithScreenWidth(w: k_LL_ScreenWidth, h: k_LL_ScreenHeight))!
                    hRect = (sourceImageView.image?.getBigImageSizeWithScreenWidth(w: k_LL_ScreenHeight, h: k_LL_ScreenWidth))!
                }
            }
            let vValue = NSValue.init(cgRect: vRect)
            verticalBigRectArray?.append(vValue)
            let hValue = NSValue.init(cgRect: hRect)
            horizontalBigRectArray?.append(hValue)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange(notification:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    // Get Rect In Window
    func getFrameInWindow(view: UIView) -> CGRect{
        return (view.superview?.convert(view.frame, to: UIApplication.shared.keyWindow?.rootViewController?.view))!
    }
    
    // Create
    func createBrowserView() {
        view.backgroundColor = UIColor.clear
        // Back View
        backView = UIView.init(frame: self.view.bounds)
        backView?.backgroundColor = UIColor.clear
        view.addSubview(backView!)
        
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        // Cell Item Spacing
        flowLayout.minimumInteritemSpacing = 0
        // Row Spacing
        flowLayout.minimumLineSpacing = 0
        
        collectView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth + browserSpace, height: screenHeight), collectionViewLayout: flowLayout)
        collectView?.delegate = self
        collectView?.dataSource = self
        collectView?.isPagingEnabled = true
        collectView?.bounces = false
        collectView?.showsVerticalScrollIndicator = false
        collectView?.showsHorizontalScrollIndicator = false
        collectView?.backgroundColor = UIColor.clear
        collectView?.register(LLBrowserCollectionViewCell.self, forCellWithReuseIdentifier: "LLBrowserCollectionViewCell")
        collectView?.contentOffset = CGPoint.init(x: CGFloat(currentIndex) * (screenWidth + browserSpace), y: 0)
        backView?.addSubview(collectView!)
        
        currentIndexLabel = UILabel.init()
        currentIndexLabel?.textColor = UIColor.white
        currentIndexLabel?.frame = CGRect.init(x: 0, y: screenHeight - 50, width: screenWidth, height: 50)
        currentIndexLabel?.text = "\(currentIndex + 1)/\((photoArray?.count)!)"
        currentIndexLabel?.textAlignment = .center
        backView?.addSubview(currentIndexLabel!)
        
        remindView = LLRemindView.init(frame: (backView?.bounds)!)
        backView?.addSubview(remindView!)
    }
    
    // MARK: UICollectionViewDataSource
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (photoArray?.count)!
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LLBrowserCollectionViewCell", for: indexPath) as! LLBrowserCollectionViewCell
        let imageItem = photoArray?[indexPath.row]
        // Reset scale
        cell.zoomScrollView?.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight)
        cell.zoomScrollView?.zoomScale = 1.0
        // Reset contentSize of scale before
        cell.zoomScrollView?.contentSize = CGSize.init(width: screenWidth, height: screenHeight)
        if let sourceImageView = imageItem?.sourceImageView {
            cell.zoomScrollView?.zoomImageView?.contentMode = sourceImageView.contentMode
            cell.zoomScrollView?.zoomImageView?.clipsToBounds = sourceImageView.clipsToBounds
        }
        
        cell.loadingView?.ll_updateFrameInSuperviewCenterWithSize(size: CGSize.init(width: 30, height: 30))
        var imageRect = verticalBigRectArray?[indexPath.row].cgRectValue
        if currentOrientation != UIDeviceOrientation.portrait {
            imageRect = horizontalBigRectArray?[indexPath.row].cgRectValue
        }
        loadBrowserImagerWithModel(item: imageItem!, cell: cell, imageFrame: imageRect!)
        
        cell.tapClick { [weak self] (cell) in
            self?.tap(cell: cell)
        }
        
        cell.longPress { [weak self] (cell) in
            self?.longPress(cell: cell)
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: screenWidth + browserSpace, height: screenHeight)
    }
    
    // MARK: UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    open func loadBrowserImagerWithModel(item: LLBrowserModel, cell: LLBrowserCollectionViewCell, imageFrame: CGRect) {
    
    }
    
    // MARK: UIScrollViewDeletate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isRotate {
            currentIndex = NSInteger(scrollView.contentOffset.x / (screenWidth + browserSpace))
            currentIndexLabel?.text = "\(currentIndex + 1)/\((photoArray?.count)!)"
        }
        isRotate = false
    }
   
    // Device Change
    @objc func deviceOrientationDidChange(notification: NSNotification) {
        let orientation = UIDevice.current.orientation
        if orientation == .portrait || orientation == .landscapeLeft || orientation == .landscapeRight {
            isRotate = true
            currentOrientation = orientation
            if currentOrientation == UIDeviceOrientation.portrait {
                screenWidth = k_LL_ScreenWidth
                screenHeight = k_LL_ScreenHeight
                UIView.animate(withDuration: 0.5, animations: { 
                    self.backView?.transform = CGAffineTransform(rotationAngle: 0)
                })

            }else{
                screenWidth = k_LL_ScreenHeight
                screenHeight = k_LL_ScreenWidth
                
                if currentOrientation == .landscapeLeft {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.backView?.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
                    })
                }else{
                    UIView.animate(withDuration: 0.5, animations: {
                        self.backView?.transform = CGAffineTransform(rotationAngle:CGFloat(-Double.pi / 2))
                    })
                }
            }
            backView?.frame = CGRect.init(x: 0, y: 0, width: k_LL_ScreenWidth, height: k_LL_ScreenHeight)
            currentIndexLabel?.frame = CGRect.init(x: 0, y: screenHeight - 50, width: screenWidth, height: 50)
            remindView?.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight)
            if let _ = browserActionSheet {
                browserActionSheet?.updateFrameByTransform()
            }
            collectView?.collectionViewLayout.invalidateLayout()
            collectView?.frame = CGRect.init(x: 0, y: 0, width: screenWidth + browserSpace, height: screenHeight)
            collectView?.contentOffset = CGPoint.init(x: (screenWidth + browserSpace) * CGFloat(currentIndex), y: 0)
            collectView?.reloadData()
        }
    }
    
    // MARK: Status Bar
    override open var prefersStatusBarHidden: Bool {
        if !(collectView?.isUserInteractionEnabled)! {
            return false
        }
        return true
    }
    
    // MARK: Tap
    func tap(cell: LLBrowserCollectionViewCell) {
        
        let indexPath = collectView?.indexPath(for: cell)
        
        guard let _ = indexPath else {
            self.view.alpha = 0.0
            self.dismiss(animated: false, completion: nil)
            return
        }
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        view.backgroundColor = UIColor.clear
        
        // Background Color
        collectView?.backgroundColor = UIColor.clear
        collectView?.isUserInteractionEnabled = false
        
        // Status Bar
        setNeedsStatusBarAppearanceUpdate()
        
        let cellArray = collectView?.visibleCells
        for lcell in cellArray! {
            (lcell as! LLBrowserCollectionViewCell).loadingView?.stopAnimating()
        }
        currentIndexLabel?.removeFromSuperview()
        currentIndexLabel = nil
        
        cell.zoomScrollView?.zoomScale = 1.0
        let item = photoArray?[(indexPath?.row)!]
        
        var transform = CGAffineTransform(rotationAngle: 0)
        if currentOrientation == .landscapeLeft {
            transform = CGAffineTransform(rotationAngle:CGFloat(-Double.pi / 2))
        }else if currentOrientation == .landscapeRight{
            transform = CGAffineTransform(rotationAngle:CGFloat(Double.pi / 2))
        }
        
        if let smallImageView = item?.sourceImageView {
            var rect = getFrameInWindow(view: smallImageView)
            if currentOrientation == .landscapeLeft {
                rect = CGRect.init(x: rect.origin.y, y: k_LL_ScreenWidth - rect.size.width - rect.origin.x, width: rect.size.height, height: rect.size.width)
            }else if currentOrientation == .landscapeRight{
                rect = CGRect.init(x: k_LL_ScreenHeight - rect.size.height - rect.origin.y, y: rect.origin.x, width: rect.size.height, height: rect.size.width)
            }
            // Record
            onceImageViewHistoryRect = rect
        }else{
            onceImageViewHistoryRect = CGRect.init(x: k_LL_ScreenWidth * 0.5, y: k_LL_ScreenHeight * 0.5, width: 0, height: 0)
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            cell.zoomScrollView?.zoomImageView?.transform = transform
            cell.zoomScrollView?.zoomImageView?.frame = self.onceImageViewHistoryRect
        }, completion: { (finished) in
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    // MARK: Long Press
    func longPress(cell: LLBrowserCollectionViewCell) {
        if let _ = browserActionSheet {
            browserActionSheet?.removeFromSuperview()
            browserActionSheet = nil
        }
        
        var qrcodeString: String? = nil
        if isOpenQRCodeCheck {
            /// 没有使用异步，是因为不确定sheetTitileArray是否使用，如果没有使用，弹出来的仅先显示取消，显得太突兀了。
            /// 如有需求或者疑问可以issues
            qrcodeString = findAvailableQRCode(imageView: (cell.zoomScrollView?.zoomImageView)!)
            
            if let _ = qrcodeString {
                if !(sheetTitileArray?.contains(k_LL_QRCodeTitle))! {
                    sheetTitileArray?.append(k_LL_QRCodeTitle)
                }
            }else{
                if (sheetTitileArray?.contains(k_LL_QRCodeTitle))! {
                    let index = sheetTitileArray?.index(of: k_LL_QRCodeTitle)
                    sheetTitileArray?.remove(at: index!)
                }
            }
        }
        
        guard let titleArray = sheetTitileArray, titleArray.count > 0 else {
            return
        }
        
        guard let _ = didActionSheetSelected else {
            print("注意注意：既然存在ActionSheetTitle，就必须实现点击哦～～～～")
            return
        }
        
        browserActionSheet = LLBrowserActionSheet.init(titleArray: sheetTitileArray!, cancelTitle: actionSheetCancelTitle!, cellHeight: actionSheetCellHeight!,backgroundColor: actionSheetBackgroundColor, cellBackgroundColor: actionSheetCellBackgroundColor!, titleFont: actionSheetTitleFont!, titleTextColor: actionSheetTitleTextColor!, cancelTextColor: actionSheetCancelTextColor!, lineColor: actionSheetLineColor!, didSelectedCell:
            { [weak self] (index) in
            
                self?.didActionSheetSelected!(index, (cell.zoomScrollView?.zoomImageView)!, qrcodeString)
        
            })
        browserActionSheet?.show(backView!)
    }
    
    
    // MARK: Show Remind View
    func show(_ content: String? = nil) {
        remindView?.show(content)
        self.perform(#selector(hide), with: nil, afterDelay: 1.2)
    }
    
    func showError(_ content: String? = nil) {
        remindView?.showError(content)
        self.perform(#selector(hide), with: nil, afterDelay: 1.2)
    }
    
    @objc func hide() {
        remindView?.hide()
    }
    
    // MARK: CIDetector
    func findAvailableQRCode(imageView: UIImageView) -> String? {
        let detector: CIDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])!
        let ciImage: CIImage = CIImage.init(image: imageView.image!)!
        let features = detector.features(in: ciImage)
        for feature in features as! [CIQRCodeFeature] {
            return feature.messageString ?? nil
        }
        return nil
    }
}

extension LLBrowserViewController {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimator
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimator
    }
}
