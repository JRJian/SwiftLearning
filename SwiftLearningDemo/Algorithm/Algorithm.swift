//
//  QuickSort.swift
//  SwiftLearningDemo
//
//  Created by 三九四九石景山 on 2023/7/12.
//
//

import Foundation

class Algorithm {
    // https://blog.csdn.net/justidle/article/details/104203963
    // 快排序
    static func QuickSort(list: inout [Int], low: Int, high: Int) {
        var rightFlag = high
        var leftFlag = low
        
        if leftFlag >= rightFlag { return }
        
        let key = list[low]
        
        while leftFlag != rightFlag {
            while list[rightFlag] >= key, leftFlag < rightFlag {
                rightFlag -= 1
            }
            while list[leftFlag] <= key, leftFlag < rightFlag {
                leftFlag += 1
            }
            if leftFlag < rightFlag {
                print("交换前:\(list)")
                let tmp = list[rightFlag]
                list[rightFlag] = list[leftFlag]
                list[leftFlag] = tmp
                print("交换后:\(list)")
            }
        }
        
        // exchange
        print("交换前:\(list)")
        let tmp = list[low]
        list[low] = list[leftFlag]
        list[leftFlag] = tmp
        print("交换后:\(list)")
        
        print("\n")
        print("\n")
        QuickSort(list: &list, low: low, high: leftFlag - 1)
        QuickSort(list: &list, low: leftFlag + 1, high: high)
    }
    
    // 插入
    // O(n^2)
    static func InsertSort(list: [Int]) -> [Int] {
        var sorted:[Int] = [list[0]]
        for i in 1..<list.count {
            var min : Int? = nil
            let tmp = list[i]
            for j in 0...max(i-1, 0) {
                if tmp < sorted[j] {
                    min = j
                    sorted.insert(tmp, at: j)
                    break
                }
            }
            
            if min == nil {
                sorted.append(tmp)
            }
        }
        return sorted
    }
}
