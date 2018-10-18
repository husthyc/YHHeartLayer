//
//  HeartLayer.swift
//  HeartCurveDemo
//
//  Created by Yuchen Huang on 10/15/18.
//  Copyright © 2018 Yuchen Huang. All rights reserved.
//

import UIKit

class HeartLayer: CALayer {
    var heartColor = UIColor.white {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var bgCircleColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init() {
        super.init()
        needsDisplayOnBoundsChange = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(in ctx: CGContext) {
        let rect = bounds
        
        let minEdgeLength = min(rect.width, rect.height)
        
        let circlePath = UIBezierPath()
        let circleRadius = minEdgeLength / 2.05
        let heartOffset = minEdgeLength * 0.02 // Offset the heart to the circle's center, for a better looking
        circlePath.addArc(withCenter: CGPoint(x: rect.width / 2, y: rect.height / 2),
                          radius: circleRadius,
                          startAngle: 0,
                          endAngle: 2 * CGFloat.pi,
                          clockwise: true)
        
        ctx.setFillColor(bgCircleColor.cgColor)
        ctx.addPath(circlePath.cgPath)
        ctx.fillPath()
        
        let arcRadius = minEdgeLength / 6
        let heartPath = UIBezierPath()
        heartPath.addArc(withCenter: CGPoint(x: rect.width / 2 - minEdgeLength * 0.4 / 3, y: rect.height / 2 - minEdgeLength * 0.1 + heartOffset),
                    radius: arcRadius,
                    startAngle: 135 * CGFloat.pi / 180,
                    endAngle: 315 * CGFloat.pi / 180,
                    clockwise: true)

        heartPath.addLine(to: CGPoint(x: rect.width / 2, y: rect.height / 2 - minEdgeLength * 0.2 + heartOffset))
        heartPath.addArc(withCenter: CGPoint(x: rect.width / 2 + minEdgeLength * 0.4 / 3, y: rect.height / 2 - minEdgeLength * 0.1 + heartOffset),
                    radius: arcRadius,
                    startAngle: 225 * CGFloat.pi / 180,
                    endAngle: 45 * CGFloat.pi / 180,
                    clockwise: true)
        heartPath.addLine(to: CGPoint(x: rect.width / 2, y: rect.height / 2 + minEdgeLength * 0.3 + heartOffset))
        heartPath.close()
        
        ctx.setFillColor(heartColor.cgColor)
        ctx.addPath(heartPath.cgPath)
        ctx.fillPath()
    }
}
