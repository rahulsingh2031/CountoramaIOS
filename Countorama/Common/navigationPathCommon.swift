//
//  navigationPathCommon.swift
//  Countorama
//
//  Created by Raj Singh on 21/01/25.
//

import Foundation
import SwiftUI

struct NavigationPathKey: EnvironmentKey {
    static let defaultValue: NavigationPath = NavigationPath()
}

extension EnvironmentValues {
    var homeNavigationPath: NavigationPath {
        get { self[NavigationPathKey.self] }
        set { self[NavigationPathKey.self] = newValue }
    }
}
