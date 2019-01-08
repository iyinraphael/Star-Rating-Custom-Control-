//
//  CustomControl.swift
//  Star Rating (Custom Control)
//
//  Created by Iyin Raphael on 1/8/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class CustomControl: UIControl {
    
    var value: Int = 1
    
    private let componentDimension: CGFloat = 40.0
    private let componentCount: Int = 5
    private let componentActiveColor: UIColor = .black
    private let componentInactiveColor: UIColor = .gray
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        
        setUp()
    }
    
    
    func setUp(){
        
        var labels: [UILabel] = []
        
        for num in 1...5{
            
            let label: UILabel = UILabel()
            self.addSubview(label)
            
            label.frame.size = CGSize(width: componentDimension, height: componentDimension)
            let x = CGFloat(integerLiteral: (8 * num))
            label.layer.position = CGPoint(x: x, y: 0)
            
            label.font = UIFont.systemFont(ofSize: 32.0)
            label.text = "✯"
            
            label.textColor = componentInactiveColor
            
            label.tag = num
            labels.append(label)
            NSLog("\(label)")
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
}
