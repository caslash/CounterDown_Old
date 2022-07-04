//
//  GradientEventView.swift
//  CounterDown
//
//  Created by Cameron Slash on 03/7/22.
//

import CounterKit
import DynamicColor
import SFSymbolsFinder
import SwiftUI

@available(iOS 16.0, *)
struct GradientEventView: View {
    @EnvironmentObject var modeldata: ModelData
    @ObservedObject var viewmodel: EventViewModel
    @State private var showingEditSheet = false
    var body: some View {
        VStack {
            ZStack {
                Text(self.viewmodel.event.name)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .truncationMode(.tail)
                    .font(.title.weight(.black))
                
                HStack {
                    Spacer()
                    
                    Menu {
                        Button {
                            self.showingEditSheet = true
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        
                        Button(role: .destructive) {
                            self.modeldata.deleteEvent(uuid: self.viewmodel.event.id)
                            self.modeldata.saveMoc()
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: .ellipsisCircle)
                            .font(.title3)
                    }
                }
            }
            
            HStack(spacing: 5) {
                if viewmodel.event.components.contains(.year) {
                    VStack {
                        Text(viewmodel.yearsLeft())
                            .font(.title3.weight(.black))
                        
                        Text("YR")
                            .font(.subheadline.weight(.semibold))
                    }
                    .frame(width: 50, height: 50)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                }
                
                if viewmodel.event.components.contains(.month) {
                    VStack {
                        Text(viewmodel.monthsLeft())
                            .font(.title3.weight(.black))
                        
                        Text("MTH")
                            .font(.subheadline.weight(.semibold))
                    }
                    .frame(width: 50, height: 50)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                }
                
                VStack {
                    Text(viewmodel.daysLeft())
                        .font(.title3.weight(.black))
                    
                    Text("DAY")
                        .font(.subheadline.weight(.semibold))
                }
                .frame(width: 50, height: 50)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                
                VStack {
                    Text(viewmodel.hoursLeft())
                        .font(.title3.weight(.black))
                    
                    Text("HR")
                        .font(.subheadline.weight(.semibold))
                }
                .frame(width: 50, height: 50)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                
                VStack {
                    Text(viewmodel.minutesLeft())
                        .font(.title3.weight(.black))
                    
                    Text("MIN")
                        .font(.subheadline.weight(.semibold))
                }
                .frame(width: 50, height: 50)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                
                VStack {
                    Text(viewmodel.secondsLeft())
                        .font(.title3.weight(.black))
                    
                    Text("SEC")
                        .font(.subheadline.weight(.semibold))
                }
                .frame(width: 50, height: 50)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
            }
        }
        .foregroundColor(UIColor(self.viewmodel.event.color).isLight() ? .black : .white)
        .frame(width: (UIScreen.main.bounds.width / 4) * 3)
        .padding()
        .background(self.viewmodel.event.color.gradient)
        .cornerRadius(20)
        .sheet(isPresented: $showingEditSheet) {
            EditEventView(self.viewmodel.event)
                .presentationDetents([.fraction(0.42), .large])
        }
    }
    
    init(event: Event) {
        self.viewmodel = EventViewModel(event: event, now: Date())
    }
}

@available(iOS 16.0, *)
struct GradientEventView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GradientEventView(event: PreviewEvents.nyd)
                .environmentObject(ModelData.shared)
                .previewDisplayName("New Years")
            
            GradientEventView(event: PreviewEvents.christmas)
                .environmentObject(ModelData.shared)
                .previewDisplayName("Christmas")
            
            GradientEventView(event: PreviewEvents.birthday)
                .environmentObject(ModelData.shared)
                .previewDisplayName("Birthday")
        }
    }
}
