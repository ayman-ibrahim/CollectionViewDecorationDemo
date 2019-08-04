//
//  Presenter.swift
//  CollectionViewDecorationView
//
//  Created by Ayman Ibrahim on 8/4/19.
//  Copyright © 2019 Raju. All rights reserved.
//

import Foundation


class Presenter {
    
    var dataSource = [[0, 1, 2], [0, 1, 2, 3, 4], [0, 1, 2, 3, 4, 5, 6]]
    var didAdjustedData: ((Bool, [IndexPath])->())?
    
    func toggleSection(_ index: Int) {
        print("Toggle")
        let sectionData = dataSource[index]
        if sectionData.count > 0 {
            let indexPaths = dataSource[index].map { IndexPath(row: $0, section: index) }
            dataSource[index] = []
            didAdjustedData?(true, indexPaths)
        } else {
            let arr = getArrayOfRandomCount()
            let indexPaths = arr.map { IndexPath(row: $0, section: index) }
            dataSource[index] = arr
            didAdjustedData?(false, indexPaths)
        }
    }
    
    func getArrayOfRandomCount()-> [Int] {
        let randomInt = Int.random(in: 1..<6)
        var arr = [Int]()
        for i in 0..<randomInt {
            arr.append( i)
        }
        return arr
    }
}
