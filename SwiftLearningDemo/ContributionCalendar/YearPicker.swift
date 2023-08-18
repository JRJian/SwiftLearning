//
//  YearPicker.swift
//  SwiftLearningDemo
//
//  Created by 三九四九石景山 on 2023/7/24.
//

import UIKit

fileprivate var yearPickerView: YearPicker? = nil

class YearPicker: UIView {
    
    // current selected year
    var curentYear: Int {
        didSet {
            self.scrollTo(year: curentYear)
        }
    }
    var years: [Int] = []
    //
    var confirmActionHandler: ((Int)->(Void))?
    
    // selected index of years list for tableview
    private var selectedIndex: Int = 0
    
    // 年份选择器
    private var tableView: UITableView = {
        let tbl = UITableView(frame: .zero, style: .plain)
        tbl.separatorStyle = .none
        tbl.layer.cornerRadius = 30.0
        tbl.scrollsToTop = false
        return tbl
    }()
    
    private var centerHighlightedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15.0
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.35)
        view.isUserInteractionEnabled = false
        return view
    }()
    
    // 确认按钮
    private var confirmButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("OK", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor.black
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    // 容器
    private var container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30.0
        view.backgroundColor = .white
        view.layer.shadowRadius = 10.0
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.1)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        return view
    }()
    
    // 模糊背景
    private var blurBgView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        return view
    }()
    
    private let cellHeight = 64.0
    
    init(curentYear: Int) {
        self.curentYear = curentYear
        super.init(frame: .zero)
        self.setupData()
        backgroundColor = .clear
        
        addSubview(blurBgView)
        addSubview(container)
        container.addSubview(tableView)
        container.addSubview(confirmButton)
        container.addSubview(centerHighlightedView)
        container.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 300, height: 450))
        }
        centerHighlightedView.snp.makeConstraints { make in
            make.center.equalTo(tableView)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(cellHeight)
        }
        blurBgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview().offset(-44)
            make.height.equalTo(cellHeight * 3.0)
        }
        confirmButton.snp.makeConstraints { make in
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.height.equalTo(44)
            make.bottom.equalTo(-20)
        }
        confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        
        tableView.register(YearPickerCell.self, forCellReuseIdentifier: "YearPickerCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.scrollTo(year: curentYear, animated: false)
        }
    }
    
    private func setupData() {
        for y in (curentYear - 50)..<curentYear+51 {
            years.append(y)
        }
        years[0] = 0
        years[years.count - 1] = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func showup(withConfirmAction: ((Int)->(Void))? = nil) {
        
        guard yearPickerView == nil else {
            yearPickerView?.removeFromSuperview()
            yearPickerView = nil
            return
        }
        
        let picker = YearPicker(curentYear: 2023)
        picker.frame = UIScreen.main.bounds
        picker.confirmActionHandler = withConfirmAction
        
        if let win = UIApplication.shared.keyWindow {
            win.addSubview(picker)
            yearPickerView = picker
            
            // animation
            yearPickerView?.alpha = 0
            UIView.animate(withDuration: 0.15) {
                yearPickerView?.alpha = 1
            }
        }
    }
    
    static func dismiss() {
        UIView.animate(withDuration: 0.15) {
            yearPickerView?.alpha = 0
        } completion: { finished in
            if finished {
                yearPickerView?.removeFromSuperview()
                yearPickerView = nil
            }
        }
    }
    
    @objc private func confirmAction() {
        confirmActionHandler?(years[selectedIndex])
    }
    
    func scrollTo(year: Int, animated: Bool = true) {
        guard let index = years.firstIndex(of: year) else {
            return
        }
        selectedIndex = index
        tableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .middle, animated: animated)
    }
}

// MAKR: - Extension UITableView delegate & dataSource
extension YearPicker: UITableViewDelegate, UITableViewDataSource {
    
    // find the center cell and scroll it to tableview center
    private func stoppedScrolling() {
        var centerCell: UITableViewCell? = nil
        var maxDistance = 0.0
        
        guard let visibleRows = tableView.indexPathsForVisibleRows else { return }
        
        for path in visibleRows {
            
            var cellFrame = tableView.rectForRow(at: path)
            cellFrame.origin.y = cellFrame.minY - tableView.contentOffset.y + tableView.frame.minY
            
            // 交集
            if centerHighlightedView.frame.intersects(cellFrame) {
                
                // 判断交集的长度
                if cellFrame.origin.y < centerHighlightedView.frame.origin.y {
                    let dis = cellFrame.maxY - centerHighlightedView.frame.origin.y
                    if dis > maxDistance {
                        maxDistance = max(maxDistance, dis)
                        centerCell = tableView.cellForRow(at: path)
                    }
                } else if cellFrame.origin.y > centerHighlightedView.frame.origin.y {
                    let dis = centerHighlightedView.frame.maxY - cellFrame.minY
                    if dis > maxDistance {
                        maxDistance = max(maxDistance, dis)
                        centerCell = tableView.cellForRow(at: path)
                    }
                }
            }
        }
        
        if let c = centerCell, let indexpath = tableView.indexPath(for: c) {
            selectedIndex = indexpath.row
            tableView.scrollToRow(at: indexpath, at: .middle, animated: true)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return years.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "YearPickerCell", for: indexPath) as? YearPickerCell {
            let year = years[indexPath.row]
            if year != 0 {
                cell.yearLabel.text = "\(year)"
            } else {
                cell.yearLabel.text = ""
            }
            return cell
        }
        
        return YearPickerCell(style: .default, reuseIdentifier: "YearPickerCell")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        stoppedScrolling()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        stoppedScrolling()
    }
}

// MAKR: - The cell of yearPicker
class YearPickerCell: UITableViewCell {
    
    var yearLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        lbl.textColor = .black
        lbl.textAlignment = .center
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(yearLabel)
        yearLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
