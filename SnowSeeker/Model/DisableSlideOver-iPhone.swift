//
//  DisableSlideOver-iPhone.swift
//  SnowSeeker
//
//  Created by Justin Wells on 12/13/22.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}
