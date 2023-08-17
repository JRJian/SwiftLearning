//
//  AppsIconChangingController.swift
//  SwiftLearningDemo
//
//  Created by 三九四九石景山 on 2023/7/10.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class  AppsIconChangingController: UIViewController {
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
//        let appIconChangeBtn = UIButton(type: .custom)
//        appIconChangeBtn.setTitle("图标1", for: .normal)
//        appIconChangeBtn.setTitleColor(.black, for: .normal)
//        appIconChangeBtn.rx.tap.bind {
//            AppIconManager.shared.setIcon(.cookie)
//        }.disposed(by: disposeBag)
//        view.addSubview(appIconChangeBtn)
//        appIconChangeBtn.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(100)
//        }
//
//
//        let appIconChangeBtn2 = UIButton(type: .custom)
//        appIconChangeBtn2.setTitle("图标2", for: .normal)
//        appIconChangeBtn2.setTitleColor(.black, for: .normal)
//        appIconChangeBtn2.rx.tap.bind {
//            AppIconManager.shared.setIcon(.classic)
//            KeepAliveThread.quick()
//        }.disposed(by: disposeBag)
//        view.addSubview(appIconChangeBtn2)
//        appIconChangeBtn2.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(appIconChangeBtn.snp.bottom).offset(30)
//        }
//
//        KeepAliveThread.testAlive()
        
//        Cat.runtimeCall()
//        Cat.classBarke()
        
//        let gcd = GCD()
//        gcd.semaphore()
        
        let fillColor = UIColor.FromRGB(0x00A1E9)
        let defaultBgColor = UIColor.init(white: 0.95, alpha: 1.0)
        let cal = ContributionCalendar()
        cal.columnsCount = 8
        cal.frame = CGRect.init(x: 30, y: 100, width: view.frame.width, height: 300)
        cal.items = [
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0.01),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0.2),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 1),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 1),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 1),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0.3),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0.4),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0.9),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0.1),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0.2),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0.3),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0.4),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0.9),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0.1),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0.2),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0.3),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0.4),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0.9),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0.1),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0.2),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0.3),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0.4),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0),
            ContributionCalendarItem(fillColor: fillColor, defaultColor: defaultBgColor, progress: 0.9),
        ]
//        view.addSubview(cal)
        
        
        let btn = YearButton(frame: .init(x: (view.frame.width - 100) * 0.5, y: 100, width: 100, height: 44))
        btn.setup(title: "2023")
        view.addSubview(btn)
        
//        let fView = FirstView(frame: view.bounds)
//        view.addSubview(fView)
//        fView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            YearPicker.showup()
//        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("AppsIconChangingController touchesBegan")
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("AppsIconChangingController touchesEnded")
//    }
}
