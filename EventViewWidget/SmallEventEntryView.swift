//
//  SmallEventEntryView.swift
//  CounterDown
//
//  Created by Cameron Slash on 19/6/22.
//

import SwiftUI
import WidgetKit

struct SmallEventEntryView: View {
    let entry: EventEntry
    var body: some View {
        VStack {
            Text(entry.event.name)
                .font(.title2.weight(.black))
                .multilineTextAlignment(.center)
            
            HStack {
                VStack {
                    Text(entry.monthsLeft())
                        .font(.title3.weight(.black))
                    
                    Text("MTH")
                        .font(.subheadline.weight(.semibold))
                }
                
                VStack {
                    Text(entry.daysLeft())
                        .font(.title3.weight(.black))
                    
                    Text("DAY")
                        .font(.subheadline.weight(.semibold))
                }
                
                VStack {
                    Text(entry.hoursLeft())
                        .font(.title3.weight(.black))
                    
                    Text("HR")
                        .font(.subheadline.weight(.semibold))
                }
            }
        }
        .padding()
    }
}

struct SmallEventEntryView_Previews: PreviewProvider {
    static var previews: some View {
        SmallEventEntryView(entry: EventEntry(event: PreviewEvents.nyd))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
