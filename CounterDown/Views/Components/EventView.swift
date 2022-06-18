//
//  EventView.swift
//  Countdown
//
//  Created by Cameron Slash on 26/5/22.
//

import DynamicColor
import SwiftUI

struct EventView: View {
    @EnvironmentObject var modeldata: ModelData
    @ObservedObject var viewmodel: EventViewModel
    
    var body: some View {
        if #available(iOS 16.0, *) {
            VStack {
                Text(viewmodel.event.name)
                    .font(.headline)
                    .padding(.bottom)
                
                HStack {
                    if viewmodel.event.components.contains(.year) {
                        VStack {
                            Text(viewmodel.yearsLeft())
                            
                            Text("YR")
                                .font(.subheadline.weight(.semibold))
                        }
                    }
                    
                    if viewmodel.event.components.contains(.month) {
                        VStack {
                            Text(viewmodel.monthsLeft())
                            
                            Text("MTH")
                                .font(.subheadline.weight(.semibold))
                        }
                    }
                    
                    VStack {
                        Text(viewmodel.daysLeft())
                        
                        Text("DAY")
                            .font(.subheadline.weight(.semibold))
                    }
                    
                    VStack {
                        Text(viewmodel.hoursLeft())
                        
                        Text("HR")
                            .font(.subheadline.weight(.semibold))
                    }
                    
                    VStack {
                        Text(viewmodel.minutesLeft())
                        
                        Text("MIN")
                            .font(.subheadline.weight(.semibold))
                    }
                    
                    VStack {
                        Text(viewmodel.secondsLeft())
                        
                        Text("SEC")
                            .font(.subheadline.weight(.semibold))
                    }
                }
            }
            .frame(width: (UIScreen.main.bounds.width / 4) * 3)
            .padding()
            .background(in: RoundedRectangle(cornerRadius: 20))
            .backgroundStyle(viewmodel.event.color.gradient)
            .padding(5)
        } else {
            VStack {
                Text(viewmodel.event.name)
                    .font(.headline)
                    .padding(.bottom)
                
                HStack {
                    if viewmodel.event.components.contains(.year) {
                        VStack {
                            Text(viewmodel.yearsLeft())
                            
                            Text("YR")
                                .font(.subheadline.weight(.semibold))
                        }
                    }
                    
                    if viewmodel.event.components.contains(.month) {
                        VStack {
                            Text(viewmodel.monthsLeft())
                            
                            Text("MTH")
                                .font(.subheadline.weight(.semibold))
                        }
                    }
                    
                    VStack {
                        Text(viewmodel.daysLeft())
                        
                        Text("DAY")
                            .font(.subheadline.weight(.semibold))
                    }
                    
                    VStack {
                        Text(viewmodel.hoursLeft())
                        
                        Text("HR")
                            .font(.subheadline.weight(.semibold))
                    }
                    
                    VStack {
                        Text(viewmodel.minutesLeft())
                        
                        Text("MIN")
                            .font(.subheadline.weight(.semibold))
                    }
                    
                    VStack {
                        Text(viewmodel.secondsLeft())
                        
                        Text("SEC")
                            .font(.subheadline.weight(.semibold))
                    }
                }
            }
            .frame(width: (UIScreen.main.bounds.width / 4) * 3)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(viewmodel.event.color, lineWidth: 3)
            )
            .padding(5)
        }
    }
    
    init(event: Event, now: Date) {
        self.viewmodel = EventViewModel(event: event, now: now)
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: PreviewEvents.birthday, now: Date())
            .environmentObject(ModelData.shared)
    }
}
