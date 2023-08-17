//
//  YearPicker.swift
//  SwiftLearningDemo
//
//  Created by 三九四九石景山 on 2023/7/24.
//

import UIKit

fileprivate var yearPickerView: YearPicker? = nil

class YearPicker: UIView {
    
    // 当前选中的年份
    var curentYear: Int
    var years: [Int] = []
    
    // 年份选择器
    private var tableView: UITableView = {
        let tbl = UITableView(frame: .zero, style: .plain)
        tbl.separatorStyle = .none
        tbl.layer.cornerRadius = 30.0
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
        btn.setTitleColor(.black, for: .normal)
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
    
    private let cellHeight = 64.0
    
    init(curentYear: Int) {
        self.curentYear = curentYear
        super.init(frame: .zero)
        self.setupData()
        backgroundColor = .clear
        
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
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview().offset(-44)
            make.height.equalTo(cellHeight * 3.0)
        }
        confirmButton.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        tableView.register(YearPickerCell.self, forCellReuseIdentifier: "YearPickerCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
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
    
    static func showup() {
        guard yearPickerView == nil else {
            yearPickerView?.removeFromSuperview()
            yearPickerView = nil
            return
        }
        
        let picker = YearPicker(curentYear: 2023)
        picker.frame = UIScreen.main.bounds
        
        if let win = UIApplication.shared.keyWindow {
            win.addSubview(picker)
            yearPickerView = picker
        }
    }
    
    static func dismiss() {
    }
}

// MAKR: - Extension UITableView delegate & dataSource
extension YearPicker: UITableViewDelegate, UITableViewDataSource {
    
    // find the center cell and scroll it to tableview center
    private func stoppedScrolling() {
        var centerCell = tableView.visibleCells.first
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
