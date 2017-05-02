//
//  ViewController.swift
//  YS_iOS_Swift_Test
//
//  Created by YJ on 17/4/25.
//  Copyright © 2017年 YJ. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 内嵌函数
        let makeSum = makeIndexTest(outAccountName: 10)
        print(makeSum())
        print(makeSum())
        print(makeSum())
        print("\n")
        
        // 结构体
        var aMarkStruct = MarkStructTest(mark:98)
        var bMarkStruct = aMarkStruct
        bMarkStruct.mark = 97
        print(aMarkStruct.mark)
        print(bMarkStruct.mark)
        print("\n")
        
        // 计算属性，函数
        var sampleVar = sample()
        print(sampleVar.middle)

        sampleVar.middle = (40.0, 40.0)
        print(sampleVar.no1)
        print(sampleVar.no2)
        print(sampleVar.middle)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 内嵌函数
    func makeIndexTest(outAccountName account:Int) -> () -> Int{
        var sum = 0
        func inFunction()->Int{
            sum += account;
            print("-------- current sum: \(sum)  ---------- account: \(account)");
            
            // -------- current sum: 10  ---------- account: 10
            // -------- current sum: 20  ---------- account: 10
            // -------- current sum: 30  ---------- account: 10
            
            // 因为 inFunction 函数保存了 sum 和 account 的副本，所以会出现累加的现象。
            
            return sum;
        }
        return inFunction
    }
    
    // 结构体
    struct MarkStructTest {
        
        var mark:Int
        
        init(mark:Int) {
            self.mark = mark
        }
    }
}

class sample {
    var length = 100.0, width = 80.0
    var no1 = 0.0, no2 = 0.0
    
    var middle: (Double, Double) {
        get {
            return (self.length / 2, self.width / 2)
        }
        set(axis) {
            no1 = axis.0 - self.length / 2
            no2 = axis.1 - self.width / 2
        }
    }
}

