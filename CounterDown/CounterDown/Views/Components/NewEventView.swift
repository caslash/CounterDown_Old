//
//  NewEventView.swift
//  CounterDown
//
//  Created by Cameron Slash on 23/7/22.
//

import SlashKit
import SwiftUI

struct NewEventView: View {
    @Binding var showingAddSheet: Bool
    var body: some View {
        Button {
            self.showingAddSheet = true
        } label: {
            Label("Add Event", systemImage: "plus")
                .font(.title.weight(.black))
                .foregroundColor(.primary)
                .labelStyle(ReverseLabelStyle())
                .frame(width: (UIScreen.main.bounds.width / 5) * 4, height: UIScreen.main.bounds.height / 7)
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20))
        }
    }
}

struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventView(showingAddSheet: .constant(false))
    }
}
