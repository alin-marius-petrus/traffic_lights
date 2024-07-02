//
//  UIColor+Helpers.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import UIKit

extension UIColor {
    
    var darkerVariant: UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard self.getHue(&hue,
                          saturation: &saturation,
                          brightness: &brightness,
                          alpha: &alpha) else {
            return self
        }
        
        return UIColor(hue: hue,
                       saturation: max(saturation + 0.5, 0),
                       brightness: brightness * 0.5,
                       alpha: alpha)
    }
    
}
