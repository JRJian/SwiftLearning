//
//  ContributionCalendar.swift
//  SwiftLearningDemo
//
//  Created by 三九四九石景山 on 2023/7/24.
//

import UIKit

extension UIColor {

    func rgb() -> Int? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)

            //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
            let rgb = (iAlpha << 24) + (iRed << 16) + (iGreen << 8) + iBlue
            return rgb
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
}
extension UIColor {
    static func FromRGB(_ rgbValue: Int) -> UIColor! {
        return UIColor(
            red: CGFloat((Float((rgbValue & 0xff0000) >> 16)) / 255.0),
            green: CGFloat((Float((rgbValue & 0x00ff00) >> 8)) / 255.0),
            blue: CGFloat((Float((rgbValue & 0x0000ff) >> 0)) / 255.0),
            alpha: 1.0)
    }
}

struct ContributionCalendarItem {
    var fillColor: UIColor?
    var defaultColor: UIColor?
    var progress: CGFloat = 0
    
    init(fillColor: UIColor? = nil, defaultColor: UIColor? = nil, progress: CGFloat) {
        self.fillColor = fillColor
        self.defaultColor = defaultColor
        self.progress = progress
    }
}

class ContributionCalendar: UIView {
    // 数据
    var items: [ContributionCalendarItem] = [] {
        didSet {
            reloadItems()
        }
    }
    // 列数
    var columnsCount = 4
    // 间距
    var spacing = 5.0
    
    var itemRadius = 3.0
    var itemSize = CGSize(width: 20, height: 20)
    
    // 视图
    private var itemLayers: [CAShapeLayer] = []
    
    func reloadItems() {
        itemLayers.forEach { $0.removeFromSuperlayer() }
        
        var row = 0
        var col = 0
        
        for i in 0..<items.count {
            let layer = createAItemLayer(item: items[i])
            layer.frame = {
                row = i / columnsCount
                col = i % columnsCount
                var f = CGRect.zero
                f.size = itemSize
                f.origin = CGPoint(x: CGFloat(col) * (spacing + f.size.width), y: CGFloat(row) * (spacing + f.size.height))
                return f
            }()
            self.layer.addSublayer(layer)
        }
    }
    
    private func createAItemLayer(item: ContributionCalendarItem) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.cornerRadius = itemRadius
        layer.borderColor = UIColor.init(white: 0.9, alpha: 1.0).cgColor
        layer.borderWidth = 0.2
        
        let defaultBgColor = UIColor.init(white: 0.95, alpha: 1.0)
        
        if item.progress > 0 {
            let progressColor = item.fillColor ?? UIColor.green
            guard let comps = progressColor.cgColor.components else {
                layer.backgroundColor = (item.defaultColor ?? defaultBgColor).cgColor
                return layer
            }
            let r = comps[0]
            let g = comps[1]
            let b = comps[2]
            let a = comps[3]
            let p = 1.0 - item.progress * 0.5
            layer.backgroundColor = UIColor(red: r * p, green: g * p, blue: b * p, alpha: a).cgColor
        } else {
            layer.backgroundColor = (item.defaultColor ?? defaultBgColor).cgColor
        }
        return layer
    }
}
