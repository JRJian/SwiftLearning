//
//  WebViewController.swift
//  TubeTV
//
//  Created by jian on 2025/12/29.
//

import UIKit

class WebViewController: UIViewController {
    
    var webview: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        definesPresentationContext = true
        
        initWebView()
    }
    
    private func initWebView() {
        if #available(tvOS 11.0, *) {
            additionalSafeAreaInsets = .zero
        }
        
        // 使用动态方式加载 UIWebView（tvOS hack）
        guard let webViewClass = NSClassFromString("UIWebView") as? NSObject.Type else {
            fatalError("Unable to get UIWebView class")
        }
        webview = webViewClass.init() as AnyObject
        
        webview?.setValue(false, forKey: "translatesAutoresizingMaskIntoConstraints")
        webview?.setValue(false, forKey: "clipsToBounds")
        // 关键：强制允许键盘显示和输入
        webview?.setValue(true, forKey: "keyboardDisplayRequiresUserAction")  // 允许键盘
        webview?.setValue(true, forKey: "allowsInlineMediaPlayback")         // 可选
        webview?.setValue(true, forKey: "mediaPlaybackRequiresUserAction")   // 可选

        // 尝试让网页元素可交互
        webview?.setValue(true, forKey: "userInteractionEnabled")
        
        // 示例加载（原代码被注释，可根据需要打开）
         if let url = URL(string: "https://www.youtube.com/profile") {
             let request = URLRequest(url: url)
             webview?.loadRequest(request)
         }
        
        view.addSubview(webview as! UIView)
        
        webview?.setValue(view.bounds, forKey: "frame")
        webview?.setValue(self, forKey: "delegate")
        webview?.setValue(UIEdgeInsets.zero, forKey: "layoutMargins")
        
        // 获取内部 scrollView
        if let scrollView = webview?.value(forKey: "scrollView") as? UIScrollView {
            scrollView.setValue(UIEdgeInsets.zero, forKey: "layoutMargins")
            scrollView.contentInsetAdjustmentBehavior = .never
            scrollView.isUserInteractionEnabled = true
            scrollView.canCancelContentTouches = false
            scrollView.delaysContentTouches = false
            scrollView.contentOffset = .zero
            scrollView.contentInset = .zero
            scrollView.frame = view.bounds
            scrollView.clipsToBounds = false
            scrollView.setNeedsLayout()
            scrollView.layoutIfNeeded()
        }
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
}
