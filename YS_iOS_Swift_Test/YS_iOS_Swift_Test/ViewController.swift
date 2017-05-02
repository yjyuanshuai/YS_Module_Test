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
        // 1.
//        var aMarkStruct = MarkStructTest(mark:98)
//        var bMarkStruct = aMarkStruct
//        bMarkStruct.mark = 97
//        print(aMarkStruct.mark)
//        print(bMarkStruct.mark)
//        print("\n")
        // 2.修改实例属性值
        var areaStruct = MarkStructTest(length:3.0, widtht:5.0)
        areaStruct.mutArea(res: 13)
        areaStruct.mutArea(res: 3)
        print("\n")
        // 3.下标
        let divStruct = subscriptStruct(chushu: 100)
        print("100 除以 9：\(divStruct[9])")
        print("\n")
        // 4.下标
        var subStruct = getSetStruct()
        let zhouer = subStruct[2]
        print("获取第 3 个值：\(zhouer)")
        print("\(zhouer) 对应的中文为：\(subStruct[zhouer])")
        
        subStruct[0] = "星期日"
        print("修改第 0 个值：\(subStruct[0])")
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
        
        //
//        var mark:Int
//        
//        init(mark:Int) {
//            self.mark = mark
//        }
        
        //
        var length = 1.0, widtht = 1.0
        func area() -> Double {
            return length * widtht
        }
        
        mutating func mutArea(res: Double) {
            self.length *= res
            self.widtht *= res

//            length *= res
//            widtht *= res
            
            print("------ self.length: \(self.length) --------  self.width: \(self.widtht)")
            print("------ length: \(length) --------  width: \(widtht)")
        }
        
    }
    
    // 结构体，下标
    struct subscriptStruct {
        
        let chushu: Double
        
        subscript (beichushu: Double) -> Double{
            return chushu / beichushu
        }
    }
    
    // 结构体，下标
    struct getSetStruct {
        
        private var days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "saturday"]
        
        subscript (index: Int) -> String{
            get{
                return days[index]
            }
            set(newValue) {
                self.days[index] = newValue
            }
        }
        
        
        private var daysDic = ["Sunday":"周日", "Monday":"周一", "Tuesday":"周二", "Wednesday":"周三", "Thursday":"周四", "Friday":"周五", "saturday":"周六"]

        subscript (keyStr: String) -> String{
            get{
                if daysDic[keyStr] != nil {
                    return daysDic[keyStr]!
                }
                return ""
            }
            set(newValue){
                self.daysDic[keyStr] = newValue
            }
        }
    }
}

class sample {
    var length = 100.0, width = 80.0
    var no1 = 0.0, no2 = 0.0
    
    var middle: (Double, Double) {
        get {
            return (length / 2, width / 2)
        }
        set(axis) {
            no1 = axis.0 - length / 2
            no2 = axis.1 - width / 2
        }
    }
}

