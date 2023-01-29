//
//  ImageAsset.swift
//  
//
//  Created by Doan Le Thieu on 28/01/2023.
//

import SwiftUI

public struct ImageAsset {

    public let name: String

    public init(name: String) {
        self.name = name
    }

    public var image: Image {
        .init(name, bundle: .module)
    }
}
