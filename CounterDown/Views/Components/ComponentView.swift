//
//  ComponentView.swift
//  Countdown
//
//  Created by Cameron Slash on 27/5/22.
//

import CounterKit
import SwiftUI

struct ComponentView: View {
    @EnvironmentObject var modeldata: ModelData
    @State var left: String
    @State var component: Calendar.Component
    var body: some View {
        VStack {
            Text(left)
            
            Text(component.name.uppercased())
                .font(.subheadline.weight(.semibold))
        }
    }
}

struct ComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentView(left: "52", component: .day)
            .environmentObject(ModelData.shared)
    }
}
