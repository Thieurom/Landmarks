//
//  View+shadowedCircle.swift
//  
//
//  Created by Doan Le Thieu on 28/01/2023.
//

import SwiftUI

fileprivate struct ShadowedCircleModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

extension View {

    func shadowedCicle() -> some View {
        modifier(ShadowedCircleModifier())
    }
}
