//
//  EntryView.swift
//  CounterDownWidgetExtension
//
//  Created by Cameron Slash on 18/6/22.
//

import DynamicColor
import SwiftUI
import WidgetKit

struct EntryView: View {
    let model: WidgetContent
    var body: some View {
        ZStack {
            model.event.color
            
            VStack {
                Text(model.event.name)
                    .font(.title2.weight(.black))
                
                HStack {
                    if model.event.components.contains(.year) {
                        VStack {
                            Text(model.yearsLeft())
                                .font(.title3.weight(.black))
                            
                            Text("YR")
                                .font(.subheadline.weight(.semibold))
                        }
                    }
                    
                    if model.event.components.contains(.month) {
                        VStack {
                            Text(model.monthsLeft())
                                .font(.title3.weight(.black))
                            
                            Text("MTH")
                                .font(.subheadline.weight(.semibold))
                        }
                    }
                    
                    VStack {
                        Text(model.daysLeft())
                            .font(.title3.weight(.black))
                        
                        Text("DAY")
                            .font(.subheadline.weight(.semibold))
                    }
                    
                    VStack {
                        Text(model.hoursLeft())
                            .font(.title3.weight(.black))
                        
                        Text("HR")
                            .font(.subheadline.weight(.semibold))
                    }
                }
            }
            .foregroundColor(DynamicColor(model.event.color).isLight() ? .black : .white)
        }
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(model: WidgetContent(event: PreviewEvents.birthday))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
