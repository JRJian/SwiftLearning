//
//  ViewController.swift
//  TubeTV
//
//  Created by jian on 2025/12/28.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    private var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadYouTubeHomePage()
    }
    
    
    private func loadYouTubeHomePage() {
        let url = "https://www.youtube.com"
        
        // 可选：添加常见的浏览器 User-Agent，防止被 YouTube 拒绝或返回移动版
        let headers: HTTPHeaders = [
            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15"
        ]
        
        AF.request(url, headers: headers)
            .validate()                            // 自动检查 HTTP 状态码（200-299）
            .responseString { response in
                switch response.result {
                case .success(let htmlString):
                    print("成功获取 YouTube 首页 HTML，长度：\(htmlString.count) 字符")
                    
                    // 这里你可以：
                    // 1. 直接打印前几百个字符看看
                    let preview = String(htmlString.prefix(500))
                    print("HTML 预览：\n\(preview)")
                    
                    // 2. 后续可以用正则或 SwiftSoup 解析标题、视频等信息
                    // 3. 或者直接塞进 UIWebView / WKWebView 显示（但 YouTube 会检测并可能阻止）
                    
                case .failure(let error):
                    print("请求失败：\(error.localizedDescription)")
                    
                    if let data = response.data, let body = String(data: data, encoding: .utf8) {
                        print("响应内容：\(body)")
                    }
                }
            }
    }
    // MARK: - UI Setup
    
    private func setupUI() {
        // 设置背景色（可选）
        view.backgroundColor = .black
        
        
        // 1. 创建搜索输入框
        searchTextField = UITextField()
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // tvOS 风格设置
        searchTextField.placeholder = "输入搜索关键词或网址..."
        searchTextField.font = UIFont.preferredFont(forTextStyle: .title2)
        searchTextField.textColor = .white
        searchTextField.backgroundColor = UIColor(white: 0.2, alpha: 0.8)  // 深色半透明背景
        searchTextField.layer.cornerRadius = 12
        searchTextField.layer.borderWidth = 2
        searchTextField.layer.borderColor = UIColor.systemBlue.cgColor
        
        // 左右内边距，让文字不贴边
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 60))
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = .always
        searchTextField.rightView = paddingView
        searchTextField.rightViewMode = .always
        
        // 高度固定，适合 tvOS 焦点放大效果
        searchTextField.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        // 重要：让 UITextField 可以获得焦点（tvOS 默认不支持，需要设置为可聚焦）
        searchTextField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        view.addSubview(searchTextField)
        
        // 创建按钮
        let openWebButton = UIButton(type: .system)
        
        // tvOS 上推荐使用较大的标题和焦点效果
        openWebButton.setTitle("打开网页浏览器", for: .normal)
        openWebButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        openWebButton.titleLabel?.adjustsFontForContentSizeCategory = true
        
        // 设置按钮图片（可选，提升 tvOS 焦点视觉效果）
        // 如果你有自定义图标，可以替换下面这行
        // openWebButton.setImage(UIImage(systemName: "globe"), for: .normal)
        
        // 添加点击事件
        openWebButton.addTarget(self,
                               action: #selector(openWebViewController),
                               for: .primaryActionTriggered)
        
        // 关闭自动约束转译
        openWebButton.translatesAutoresizingMaskIntoConstraints = false
        
        // 添加到视图层次
        view.addSubview(openWebButton)
        
        
        // 3. 布局约束（垂直堆叠，居中）
        NSLayoutConstraint.activate([
            // 输入框在上方
            searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            searchTextField.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 100),
            searchTextField.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -100),
            
            // 按钮在下方
            openWebButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 80),
            openWebButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        // 重要：让按钮在 tvOS 遥控器下可以获得焦点
        // （UIButton 默认是可聚焦的，但建议显式设置以确保）
        openWebButton.isUserInteractionEnabled = true
    }
    
    // MARK: - Actions
    
    @objc private func openWebViewController() {
        // 假设你有一个叫 WebViewController 的控制器（你之前转换的那个）
        let webVC = WebViewController()
        // 呈现
        present(webVC, animated: true, completion: nil)
        
        // 如果你希望支持从 WebViewController 返回（比如按 Menu 键），
        // 确保 WebViewController 里没有阻止 Menu 键默认行为
    }
    
    // 可选：让遥控器的 Menu 键能正常返回（如果有多个层级）
    override var preferredFocusedView: UIView? {
        return view.subviews.first(where: { $0 is UIButton }) // 让按钮默认获得焦点
    }

    
    // 当用户在输入框按“选择”键或完成输入后，可以在这里处理
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        
        // 当输入框获得焦点时，边框高亮（增强视觉反馈）
        if context.nextFocusedView === searchTextField {
            searchTextField.layer.borderColor = UIColor.white.cgColor
            searchTextField.layer.shadowOpacity = 0.8
            searchTextField.layer.shadowRadius = 20
            searchTextField.layer.shadowColor = UIColor.white.cgColor
        } else {
            searchTextField.layer.borderColor = UIColor.systemBlue.cgColor
            searchTextField.layer.shadowOpacity = 0
        }
    }
    
}

