//
//  EightQueens.swift
//  EightQueens
//
//  Created by Bill Hu on 15/10/20.
//  Copyright © 2015年 Bill Hu. All rights reserved.
//

import UIKit

class Queens {
    init(line line: Int, row: Int) {
        self.line = line
        self.row = row
    }
    var line: Int
    var row: Int
}

class EightQueens: NSObject {

    init(queens queens: Int) {
        self.queens = queens
    }
    
    var queens: Int = 8
    var answers = NSMutableArray()
    var possable = NSMutableArray()
    
    func printQueens() {//调试输出位置
        for i in answers {
            if let i = i as? NSMutableArray {
                for j in i {
                    if let queens: Queens = j as? Queens {
                        NSLog("row:%d line:%d\n", queens.row, queens.line)
                    }
                }
            }
        }
    }
    
    func clean() {
        answers.removeAllObjects()
        possable.removeAllObjects()
    }
    
    func queensPosition(row: Int) {
        if row <= 0 {
            let temp = NSMutableArray()
            for i in possable {
                temp.addObject(i)
//log
//                if let queens: Queens = i as? Queens {
//                    NSLog("row:%d line:%d\n", queens.row, queens.line)
//                }
            }
//            NSLog("\n")
            answers.addObject(temp)
        }
        for line in 1...queens {
            if  safe(row: row, line: line) {//判断安全
                possable.addObject(Queens(line: line, row: row))
                queensPosition(row-1)//下一个皇后
                possable.removeLastObject()
            }
        }
    }
    
    func safe(row row: Int, line: Int) -> Bool {
        for temp in possable {
            if let preQueen: Queens = temp as? Queens {
                if abs(line - preQueen.line) == abs(row - preQueen.row) || line == preQueen.line || row == preQueen.row {
                    return false
                }
            }
        }
        return true
    }
}
