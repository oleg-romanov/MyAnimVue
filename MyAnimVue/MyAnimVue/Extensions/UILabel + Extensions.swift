//
//  UILabel + Extensions.swift
//  MyAnimVue
//
//  Created by Олег Романов on 15.07.2024.
//

import UIKit

extension UILabel {
    func setAttributedText(_ text: String, lineHeight: CGFloat) {
        guard let font = self.font else { return }
            
        let baselineOffset = (lineHeight - font.lineHeight) / 2.0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.minimumLineHeight = lineHeight
            
        let attributes: [NSAttributedString.Key: Any] = [
            .baselineOffset: baselineOffset,
            .paragraphStyle: paragraphStyle
        ]
            
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        self.attributedText = attributedString
    }
}
