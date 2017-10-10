//
//  ViewController.swift
//  Thermometer
//
//  Created by  Tikhomirov on 26.09.17.
//  Copyright © 2017  Tikhomirov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, colorDelegate {

    
    @IBOutlet weak var colorBackgroundBtn: UIButton!
    @IBOutlet weak var colorShadowBtn: UIButton!
    @IBOutlet weak var colortubeBtn: UIButton!
    @IBOutlet weak var colorPicker: ColorPicker!
    @IBOutlet weak var termView: UIImageView!
    @IBOutlet weak var termometrView: SHTTermometrView!
    @IBOutlet weak var heigthSlider: UISlider!    
    @IBOutlet weak var widthSlider: UISlider!
    @IBOutlet weak var positionSlider: UISlider!
    @IBOutlet weak var shadowWidthSlider: UISlider!
    @IBOutlet weak var shadowHeigthSlider: UISlider!
    @IBOutlet weak var colorSliderBtn: UIButton!
    @IBOutlet weak var thicknessSlider: UISlider!
    
    private var colorItem:UIColor = UIColor.red
    
    override func viewDidLoad() {
        self.view.sendSubview(toBack: termView)
        
        colorPicker.delegate = self;
        valueSlider(self)
    }

    @IBAction func valueSlider(_ sender: Any) {
        termometrView.startHeight = Int(heigthSlider.value)
        termometrView.startWidth = Int(widthSlider.value)
        termometrView.position = Int(positionSlider.value)
        termometrView.tubeShadowOffset = CGSize.init(width: Double(shadowWidthSlider.value), height: Double(shadowHeigthSlider.value))
        termometrView.sliderThickness = Int(thicknessSlider.value)
        self.view.setNeedsDisplay()
    }
    

    @IBAction func colorTapped(_ sender: Any) {
        if let btn = sender as? UIButton {
            switch btn.tag {
            case 0: do {
                    termometrView.sliderBackgroundColor = colorItem
                }
            case 1: do {
                    termometrView.tubeBackgroundColor = colorItem
                }
            case 2: do {
                    termometrView.tubeShadowColor = colorItem
                }
            default:
                termometrView.backgroundColor = colorItem
            }
        }
    }
    

    
    func pickedColor(color: UIColor) {
        colorSliderBtn.backgroundColor = color
        colortubeBtn.backgroundColor = color
        colorShadowBtn.backgroundColor = color
        colorBackgroundBtn.backgroundColor = color
        colorItem = color;
    }

}

