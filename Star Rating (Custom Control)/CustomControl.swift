//
//  CustomControl.swift
//  Star Rating (Custom Control)
//
//  Created by Iyin Raphael on 1/8/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

@IBDesignable class CustomControl: UIControl {
    
    var labels: [UILabel] = []
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
        
        var count: CGFloat = 0.0
        
        for num in 1...5{
            let space: CGFloat = (componentDimension * count) + (8.0 * count)

            let label: UILabel = UILabel(frame: CGRect(x: space, y: 0, width: componentDimension, height: componentDimension))
            self.addSubview(label)
            
            label.font = UIFont.systemFont(ofSize: 32.0)
            label.text = "✯"
            
            label.textColor = componentInactiveColor
            
            label.tag = num
            labels.append(label)
            count += 1.0
            NSLog("\(label)")
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
    
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {

        updateValue(at: touch)
        sendActions(for: [.touchDown, .valueChanged])
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        
        if bounds.contains(touchPoint){
            sendActions(for: [.touchDragInside, .valueChanged])
            updateValue(at: touch)
        } else {
            sendActions(for: .touchDragOutside)
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        defer {
            super.endTracking(touch, with: event)
        }
        
        guard let touch = touch else {return}
        
        let touchPoint = touch.location(in: self)
        
        if bounds.contains(touchPoint){
            updateValue(at: touch)
            sendActions(for: [.touchUpInside, .valueChanged])
        } else {
            sendActions(for: [.touchUpOutside])
        }

    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: .touchCancel)
    }
    
    
    func updateValue(at touch: UITouch){
        
        for label in self.labels {
            let touchPoint = touch.location(in: self)
            
            if label.bounds.contains(touchPoint){
                value = label.tag
                label.textColor = componentActiveColor
                sendActions(for: .valueChanged)
                performFlare()
            }
        }
        
    }
    
}

extension UIView {
    // "Flare view" animation sequence
    func performFlare() {
        func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
        func unflare() { transform = .identity }
        
        UIView.animate(withDuration: 0.3,
                       animations: { flare() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
    }
}
