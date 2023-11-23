//
//  CustomOperator.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/22/23.
//

import Foundation
import SwiftUI

public func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
