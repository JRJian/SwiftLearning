//
//  YearButton.swift
//  SwiftLearningDemo
//
//  Created by 三九四九石景山 on 2023/8/17.
//

import UIKit

class YearButton: UIControl {
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .black
        return lbl
    }()
    
    private lazy var backIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "Return")
        imgView.isHidden = true
        return imgView
    }()
    
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            self.setup(title: newValue)
        }
    }
    
    // MAKR:
    // true: Title Only
    // false: title & icon
    var backToCurrent: Bool = true {
        didSet {
            self.animate()
        }
    }
    var defaultSize: CGSize = CGSize(width: 100, height: 44)
    var biggerSize: CGSize = CGSize(width: 100, height: 64)
    var tapHandler: ((YearButton)->(Void))?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(backIcon)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(defaultSize.height*0.5)
        }
        backIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
        }
        
        // setup layer
        layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 15.0
        
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String?) {
        UIView.transition(with: titleLabel,
                      duration: 0.25,
                       options: .transitionCrossDissolve,
                    animations: { [weak self] in
                        self?.titleLabel.text = title
                 }, completion: nil)
    }
    
    func animate() {
        
        // change to title only state
        if self.backToCurrent {
            
            backIcon.scale(revert: true)
            
            UIView.animate(withDuration: 0.55, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.2) {
                var newFrame = self.frame
                newFrame.size = self.defaultSize
                self.frame = newFrame
                self.backIcon.alpha = 0
            } completion: { finished in
                if finished {
                    self.backIcon.isHidden = true
                }
            }
        } else {
            
            // change to state that contains title and backicon
            backIcon.alpha = 0
            backIcon.isHidden  = false
            backIcon.rotate()
            backIcon.scale()
            
            UIView.animate(withDuration: 0.55, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.2) {
                var newFrame = self.frame
                newFrame.size = self.biggerSize
                self.frame = newFrame
                self.backIcon.alpha = 1
            } completion: { finished in
                if finished {
                }
            }
        }
    }
    
    @objc func didTap() {
        tapHandler?(self)
    }
}
 
