//
//  FaceView.swift
//  fun
//
//  Created by 20151104705 on 2017/5/10.
//  Copyright © 2017年 20151104705. All rights reserved.
//

import UIKit

class FaceView: UIView {

        var lineWidth :CGFloat =  3{ didSet{setNeedsDisplay()}}
        var color: UIColor = UIColor.blue{ didSet{setNeedsDisplay()}}
        var scale :CGFloat=0.90{didSet{setNeedsDisplay()}}
        
        var faceCenter:CGPoint
        {
            return convert(center, to: superview)
        }
        var faceRadius:CGFloat
        {
            return min(bounds.size.width,bounds.size.width)/2 * scale
        }
        private struct Scaling
        {
            static let FaceRadiusToEyeRadiusRatio:CGFloat = 10
            static let FaceRadiusToEyeOffsetRatio:CGFloat = 3
            static let FaceRadiusToEyeSeparationRatio:CGFloat = 1.5
            static let FaceRadiusToMouthWidthRatio:CGFloat = 1
            static let FaceRadiusToMouthHeightRatio:CGFloat = 3
            static let FaceRadiusToMouthOffsetRatio:CGFloat = 3
        }
        private enum Eye {case Left,Right} //左右眼
        //绘制眼睛
        private func bezierPathForEye(whichEye:Eye) -> UIBezierPath{
            let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
            let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
            let eyeHorizonTalSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio
            var eyeCenter = faceCenter
            eyeCenter.y -= eyeVerticalOffset
            switch whichEye{
            case .Left:eyeCenter.x -= eyeHorizonTalSeparation / 2
            case .Right:eyeCenter.x += eyeHorizonTalSeparation / 2
            }
            
            let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
            path.lineWidth = lineWidth
            return path
        }
        //参数范围-1到1，正数表示开心，负数表示伤心
        private func bezierPathForSmile(fractionOfMaxSmile:Double) -> UIBezierPath {
            let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRatio
            let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRatio
            let mouthVertiaclOffset = faceRadius / Scaling.FaceRadiusToMouthOffsetRatio
            let smileHeight = CGFloat(max(min(fractionOfMaxSmile, 1), -1)) * mouthHeight  //这种写法保证了 -1到1的范围
            //设置四个点，开始结束和拐点，可以靠这四点绘制一条弧线
            let start = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthVertiaclOffset)
            let end = CGPoint(x: start.x + mouthWidth, y: start.y)
            let cp1 = CGPoint(x: start.x + mouthWidth / 3, y: start.y + smileHeight)
            let cp2 = CGPoint(x: end.x - mouthWidth / 3, y: cp1.y)
            
            let path = UIBezierPath()
            path.move(to: start)
            path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
            path.lineWidth = lineWidth
            return path
        }
        var FaceRadius:CGFloat{
            return min(bounds.size.width,bounds.size.height) / 2 * 0.90
        }
        
        
        override func draw(_ rect:CGRect)
        {
            let facePath = UIBezierPath(
                arcCenter: faceCenter ,
                radius:faceRadius ,
                startAngle: 0,
                endAngle: CGFloat( 2*M_PI),
                clockwise: true
            )
            facePath.lineWidth = lineWidth
            color.set()
            facePath.stroke()
            bezierPathForEye(whichEye: .Left).stroke()
            bezierPathForEye(whichEye: .Right).stroke()
            let smiliness = 0.75
            let smilePath = bezierPathForSmile(fractionOfMaxSmile: smiliness)
            smilePath.stroke()
            
        }
        
        
}


