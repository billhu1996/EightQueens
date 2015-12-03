//
//  ViewController.swift
//  EightQueens
//
//  Created by Bill Hu on 15/10/20.
//  Copyright © 2015年 Bill Hu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayArea: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var numbers: UILabel!
    var threeDTouched = false
    var viewWasLayouted = false
    var queens = 8//初始八皇后可更改
    var currentAnswers = 0
    lazy var queenViews: NSMutableArray = {
        return NSMutableArray()
        }()
    lazy var lineViews: NSMutableArray = {
        return NSMutableArray()
        }()
    lazy var eightQueen: EightQueens = {
        let t = EightQueens(queens: 8)
        return t
        }()//EightQueens类初始化
    
    
    @IBAction func pre(sender: UIButton) {//上一个btn
        if currentAnswers > 0 {
            currentAnswers--
            self.numbers.text = "\(self.currentAnswers + 1)\\\(self.eightQueen.answers.count)"
            self.changeQueensPosition()
        }
    }
    
    @IBAction func next(sender: UIButton) {//下一个btn
        if currentAnswers < eightQueen.answers.count - 1 {
            currentAnswers++
            self.numbers.text = "\(self.currentAnswers + 1)\\\(self.eightQueen.answers.count)"
            self.changeQueensPosition()
        }
    }
    
    @IBAction func count(sender: UIButton) {//是的!btn(开始计算)
        if let text = textField.text {
            if let temp: Int = Int(text)! {
                queens = temp
            }
        }
        currentAnswers = 0
        eightQueen.clean()//调用清理函数
        eightQueen.queens = queens//设置初始值
        eightQueen.queensPosition(queens)//计算
        if eightQueen.answers.count > 0 {//现实种树
            numbers.text = "1\\\(eightQueen.answers.count)"
        } else {
            numbers.text = "0\\\(eightQueen.answers.count)"
            return
        }
        for v in queenViews {
            (v as! UIView).removeFromSuperview()
            queenViews.removeObject(v)
        }//清理GUI中皇后
        printLines()//画线
        let temp: NSMutableArray = eightQueen.answers[currentAnswers] as! NSMutableArray
        for i in temp {
            let a = i as! Queens
            let x = CGFloat(CGFloat(queens - a.row) * displayArea.bounds.maxX / CGFloat(queens))
            let y = CGFloat(CGFloat(a.line - 1) * displayArea.bounds.maxX / CGFloat(queens))
            let v = UIView(frame: CGRect(x: x, y: y, width: displayArea.bounds.maxX / CGFloat(queens), height: displayArea.bounds.maxX / CGFloat(queens)))
            v.backgroundColor = UIColor.purpleColor()
            queenViews.addObject(v)
            displayArea.addSubview(v)
        }//添加皇后
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewWasLayouted = true
        if threeDTouched {
            textField.text = "8"
            count(UIButton())
            threeDTouched = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "shortcutAction:", name: "eightQueens", object: nil)
    }
    
    func shortcutAction(notification: NSNotification) {
        guard notification.name == "eightQueens" else { return }
        if viewWasLayouted {
            textField.text = "8"
            count(UIButton())
            threeDTouched = false
        } else {
            threeDTouched = true
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func printLines() {//画线
        for v in lineViews {
            (v as! UIView).removeFromSuperview()
            queenViews.removeObject(v)
        }
        
        for i in 0...queens {
            let postion = CGFloat(CGFloat(i) * displayArea.bounds.maxX / CGFloat(queens))
            let lineView = UIView(frame: CGRect(x: postion, y: 0, width: 1, height: displayArea.bounds.maxX))
            let rowView = UIView(frame: CGRect(x: 0, y: postion, width: displayArea.bounds.maxX, height: 1))
            lineView.backgroundColor = UIColor.blackColor()
            rowView.backgroundColor = UIColor.blackColor()
            displayArea.addSubview(lineView)
            displayArea.addSubview(rowView)
            lineViews.addObject(lineView)
            lineViews.addObject(rowView)
        }
    }
    
    func changeQueensPosition() {//换位置
        if eightQueen.answers.count > 0 {
            let temp: NSMutableArray = eightQueen.answers[currentAnswers] as! NSMutableArray
            for i in 0..<temp.count {
                UIView.animateWithDuration(0.5) {
                    let a = temp[i] as! Queens
                    let x = CGFloat(CGFloat(self.queens - a.row) * self.displayArea.bounds.maxX / CGFloat(self.queens))
                    let y = CGFloat(CGFloat(a.line - 1) * self.displayArea.bounds.maxX / CGFloat(self.queens))
                    (self.queenViews[i] as! UIView).frame = CGRect(x: x, y: y, width: self.displayArea.bounds.maxX / CGFloat(self.queens), height: self.displayArea.bounds.maxX / CGFloat(self.queens))
                }
            }
        }
    }
    
}
