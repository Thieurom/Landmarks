//
//  PageControl.swift
//  
//
//  Created by Doan Le Thieu on 03/02/2023.
//

import SwiftUI
import UIKit

public struct PageControl: UIViewRepresentable {

    public var numberOfPages: Int
    @Binding public var currentPage: Int?

    public init(numberOfPages: Int, currentPage: Binding<Int?>) {
        self.numberOfPages = numberOfPages
        self._currentPage = currentPage
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged)

        return control
    }

    public func updateUIView(_ uiView: UIPageControl, context: Context) {
        if let currentPage = currentPage, (0..<numberOfPages) ~= currentPage {
            uiView.currentPage = currentPage
        }
    }

    public class Coordinator: NSObject {
        var control: PageControl

        init(_ control: PageControl) {
            self.control = control
        }

        @objc func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}
