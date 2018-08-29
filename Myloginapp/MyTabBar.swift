//
//  File.swift
//  Myloginapp
//
//  Created by aokijun on 2018/08/29.
//  Copyright © 2018年 aokijun. All rights reserved.
//

import UIKit

class MyTabBar: UITabBar {
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        size.height = 58
        return size
    }
    
}
