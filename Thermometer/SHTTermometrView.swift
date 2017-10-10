//
//  SHTTermometrView.swift
//  Thermometer
//
//  Created by  Tikhomirov on 03.10.17.
//  Copyright © 2017  Tikhomirov. All rights reserved.
//

import UIKit
import QuartzCore
import CoreText

@IBDesignable class SHTTermometrView: UIView {

    //MARK: - Properties
    
    @IBInspectable var startHeight:Int = 550 { didSet { initialTest(); setupView() } }
    @IBInspectable var startWidth:Int = 120 { didSet { initialTest(); setupView() } }
    @IBInspectable var startOffset:Int = 50 { didSet { initialTest(); setupView() } }
    @IBInspectable var sliderThickness: Int = 10 { didSet { initialTest(); setupView() } }
    @IBInspectable var position:Int = 100 { didSet { positionTest(); setupView() } }
    @IBInspectable var sliderMax:Int = 100 { didSet { initialTest(); setupView() } }
    @IBInspectable var sliderMin:Int = 0 { didSet { initialTest(); setupView() } }
    @IBInspectable var sliderBackgroundColor:UIColor = UIColor.red { didSet { self.layersSetting() } }
    @IBInspectable var tubeBackgroundColor:UIColor = UIColor.clear { didSet { self.layersSetting() } }
    @IBInspectable var tubeShadowColor:UIColor = UIColor.black { didSet { self.layersSetting() } }
    @IBInspectable var tubeBorderWidth:CGFloat = CGFloat(2.0) { didSet { self.layersSetting() } }
    @IBInspectable var tubeOpacity:Double = Double(0.4) { didSet { self.layersSetting() } }
    @IBInspectable var tubeShadowOffset:CGSize = CGSize.init(width: 8, height: 5) { didSet { self.layersSetting() } }
    @IBInspectable var tubeShadowOpacity:Double = Double(0.9) { didSet { self.layersSetting() } }

    private var sliderLayer = CALayer()
    private var tubeLayer = CALayer()
    private var capsuleLayer = CALayer()
    private var capsuleShadowLayer = CALayer()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        layersSetting()
        setupView()
        markingDraw()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        layersSetting()
        setupView()
    }
    
    private func initialTest() {
        if let sup = super.superview?.bounds.height {
            if CGFloat(startHeight) > sup {
                startHeight = Int(sup)
            }
        }
        if startHeight < 0 {
            startHeight = 0
        }
        if let sup = super.superview?.bounds.width {
            if CGFloat(startWidth) > sup {
                startWidth = Int(sup)
            }
        }
        if startOffset > 100 {
            startOffset = 100
        }
        if startOffset < 0 {
            startOffset = 0
        }
        if sliderThickness > 50 {
            sliderThickness = 50
        }
        if sliderThickness < 0 {
            sliderThickness = 0
        }
    }
    private func positionTest() {
        if position > sliderMax {
            position = sliderMax
        }
        if position < sliderMin {
            position = sliderMin
        }
    }
    
    private func layersSetting() {
        sliderLayer.backgroundColor = sliderBackgroundColor.cgColor
        sliderLayer.cornerRadius = CGFloat(sliderThickness / 2)
        
        capsuleShadowLayer.backgroundColor = tubeBackgroundColor.cgColor
        capsuleShadowLayer.cornerRadius = CGFloat(sliderThickness)
        capsuleShadowLayer.borderWidth = tubeBorderWidth
        capsuleShadowLayer.opacity = Float(tubeOpacity)
        capsuleShadowLayer.shadowColor = tubeShadowColor.cgColor
        capsuleShadowLayer.shadowOffset = tubeShadowOffset
        capsuleShadowLayer.shadowOpacity = Float(tubeShadowOpacity)
        capsuleShadowLayer.shadowRadius = CGFloat(sliderThickness / 4)
        
        capsuleLayer.backgroundColor = sliderBackgroundColor.cgColor
        capsuleLayer.cornerRadius = CGFloat(sliderThickness)
        
        tubeLayer.backgroundColor = tubeBackgroundColor.cgColor
        tubeLayer.cornerRadius = CGFloat(sliderThickness / 2)
        tubeLayer.borderWidth = tubeBorderWidth
        tubeLayer.opacity = Float(tubeOpacity)
        tubeLayer.shadowColor = tubeShadowColor.cgColor
        tubeLayer.shadowOffset = tubeShadowOffset
        tubeLayer.shadowOpacity = Float(tubeShadowOpacity)
        tubeLayer.shadowRadius = CGFloat(sliderThickness / 4)
        
        self.layer.addSublayer(tubeLayer)
        self.layer.addSublayer(capsuleShadowLayer)
        self.layer.addSublayer(sliderLayer)
        self.layer.addSublayer(capsuleLayer)
    }
    
    //MARK: - Draw Layers
    private func setLayerFrames() {
        let capsuleHeigth = Int(startHeight / 12)
        let sliderX = Double((startWidth - sliderThickness) / 2)
        let sliderHeight = Double(position * (startHeight - startOffset * 2 - capsuleHeigth) / sliderMax)
        let sliderY = Double(startHeight - startOffset - capsuleHeigth) - sliderHeight
        sliderLayer.frame = CGRect.init(x: sliderX, y: sliderY,
                                        width: Double(sliderThickness),
                                        height: sliderHeight)
        sliderLayer.setNeedsDisplay()
        tubeLayer.frame = CGRect.init(x: sliderX, y: Double(startOffset),
                                      width: Double(sliderThickness),
                                      height: Double(startHeight - startOffset * 2 - capsuleHeigth))
        tubeLayer.setNeedsDisplay()
        capsuleLayer.frame = CGRect.init(x: Double((startWidth - sliderThickness * 2) / 2),
                                         y: Double(startHeight - startOffset - capsuleHeigth - sliderThickness),
                                         width: Double(sliderThickness * 2),
                                         height: Double(capsuleHeigth))
        capsuleLayer.setNeedsDisplay()
        capsuleShadowLayer.frame = CGRect.init(x: Double((startWidth - sliderThickness * 2) / 2),
                                         y: Double(startHeight - startOffset - capsuleHeigth - sliderThickness),
                                         width: Double(sliderThickness * 2),
                                         height: Double(capsuleHeigth))
        capsuleShadowLayer.setNeedsDisplay()
        self.setNeedsDisplay()
        print(self.frame)
    }
    
    private func markingDraw() {
        let markingLeft: Double = Double(startWidth - sliderThickness) / 4.0
        let markingRight: Double = Double(startWidth) - markingLeft
        var markingStep: Double = Double((startHeight - startOffset * 2)) / Double((sliderMax - sliderMin))
        let canvas0 = UIGraphicsGetCurrentContext()
        let canvas1 = UIGraphicsGetCurrentContext()
        let canvas2 = UIGraphicsGetCurrentContext()
        canvas0?.addRect(self.frame)
        canvas1?.addRect(self.frame)
        canvas2?.addRect(self.frame)
        print(self.frame)
        var markingArray0: [CGPoint] = []
        var markingArray1: [CGPoint] = []
        var i = sliderMin
        while i < sliderMax {
            if i < sliderMax - 10 {
                for j in 0 ..< 10 {
                    markingArray1.append(CGPoint.init(x: markingLeft, y: markingStep * (Double(j) + Double(i)) + Double(startOffset)))
                    markingArray1.append(CGPoint.init(x: markingRight, y: markingStep * (Double(j) + Double(i)) + Double(startOffset)))
                }
            }
            markingArray0.append(CGPoint.init(x: 0, y: markingStep * Double(i) + Double(startOffset)))
            markingArray0.append(CGPoint.init(x: Double(startWidth), y: markingStep * Double(i) + Double(startOffset)))
            i += 10
            
        }
        markingStep *= 10.0
        canvas0?.setLineWidth(2.0)
        canvas0?.strokeLineSegments(between: markingArray0)
        canvas1?.setLineWidth(1.0)
        canvas1?.strokeLineSegments(between: markingArray1)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        // Переверните систему координат
        context.textMatrix = .identity
        context.translateBy (x: 0 , y: bounds.height)
        context.scaleBy (x: 1.0 , y: -1.0)
        let path = CGMutablePath()
        i = sliderMin
        while i < sliderMax {
            path.closeSubpath()
            path.addRect(CGRect.init(x: 0, y: Int(markingStep / 10) * i + startOffset * 2,
                                     width: 50, height: 15))//bounds
            let attrString = NSAttributedString(string: "\(i)")
            let framesetter = CTFramesetterCreateWithAttributedString(attrString as CFAttributedString)
            let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrString.length), path, nil)
            CTFrameDraw(frame, context)
            i += 10
        }
        

    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupView()
        markingDraw()
    }
    
    //MARK: - SetupView
    private func setupView() {
        self.bounds = CGRect.init(x: 0, y: 0, width: startWidth, height: startHeight)
        setLayerFrames()
    }

}
