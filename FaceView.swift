//
//  FaceView.swift
//  fun
//
//  Created by 20151104705 on 2017/5/8.
//  Copyright © 2017年 20151104705. All rights reserved.
//

import UIKit

class FaceView: UIView
{
    var lineWidth :CGFloat =  3{ didSet{setNeedsDisplay()}}
    var color: UIColor = UIColor.blue{ didSet{setNeedsDisplay()}}
    
    var faceCenter:CGPoint
        {
            return convert(center, to: superview)
        }
    var faceRadius:CGFloat
        {
            return min(bounds.size.width,bounds.size.width)/2
        }


    override func draw(_ rect:CGRect)
    {
        let facePath = UIBezierPath(arcCenter: faceCenter , radius:faceRadius , startAngle: 0, endAngle: CGFloat( 2*M_PI), clockwise: true)
        facePath.lineWidth = lineWidth
        color.set()
        facePath.stroke()
        
    }
        
    
}
