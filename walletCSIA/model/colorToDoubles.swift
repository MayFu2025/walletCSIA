//
//  stringToColor.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/19.
//

import Foundation
import SwiftUI

extension Color {
    func asRGB() -> [Double] {
        let color = UIColor(self).cgColor
        let RGB = color.components
        var output: Array<Double> = []
        for n in RGB! {
            output.append(Double(n))
        }
        return output
    }
}

func extractSwiftUIColor(RGB: [Double]) -> Color {
    return Color(
        red: RGB[0],
        green: RGB[1],
        blue: RGB[2],
        opacity: RGB[3]
    )
}

//var test = Color.red.asRGB()
//print(test)
//print(Color(red: test[0],
//            green: test[1],
//            blue: test[2],
//            opacity: test[3]))
