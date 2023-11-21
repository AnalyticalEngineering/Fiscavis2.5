//
//  UIColorTransformer.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/21/23.
//

import Foundation
import UIKit

class UIColorTransformer: ValueTransformer {
    
    override func transformedValue(_ value: Any?) -> Any? {
        //transforms to color data
        guard let color = value as? UIColor else { return nil }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
            return data
        } catch {
            return nil
        }
        
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
       //transforms UI Color data back to actual "color"
        guard let data = value as? Data else { return nil }
        
        do {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
            return color
        } catch {
            return nil
        }
        
    }
    
}
