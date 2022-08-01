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
    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var modeldata: ModelData
    @ObservedObject var viewmodel: EventViewModel
    @State private var showingEditSheet = false
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                
                VStack {
                    Menu {
                        Button {
                            self.showingEditSheet = true
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        
                        Button(role: .destructive) {
                            self.dataController.delete(self.viewmodel.event)
                            self.dataController.save()
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: .ellipsisCircle)
                            .font(.title3)
                    }
                    
                    Spacer()
                }
            }
            
            
            if self.viewmodel.event.isRecurring {
                HStack {
                    Spacer()
                    
                    VStack {
                        Spacer()
                        
                        Text(self.viewmodel.event.eventRecurrenceInterval.displayName)
                            .font(.footnote.weight(.bold))
                            .padding(3)
                            .background(.ultraThinMaterial)
                            .cornerRadius(5)
                    }
                }
            }
            
            VStack {
                Text(self.viewmodel.event.eventName)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .truncationMode(.tail)
                    .font(.title.weight(.black))
                
                Text(self.viewmodel.event.dateText())
                    .font(.footnote)
            
                HStack(spacing: 5) {
                    if self.viewmodel.event.eventComponents.contains(.year) {
                        VStack {
                            Text(self.viewmodel.yearsLeft())
                                .font(.title3.weight(.black))
                            
                            Text("YR")
                                .font(.subheadline.weight(.semibold))
                        }
                        .frame(width: 50, height: 50)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                    }
                    
                    if self.viewmodel.event.eventComponents.contains(.month) {
                        VStack {
                            Text(self.viewmodel.monthsLeft())
                                .font(.title3.weight(.black))
                            
                            Text("MTH")
                                .font(.subheadline.weight(.semibold))
                        }
                        .frame(width: 50, height: 50)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                    }
                    
                    VStack {
                        Text(self.viewmodel.daysLeft())
                            .font(.title3.weight(.black))
                        
                        Text("DAY")
                            .font(.subheadline.weight(.semibold))
                    }
                    .frame(width: 50, height: 50)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    
                    VStack {
                        Text(self.viewmodel.hoursLeft())
                            .font(.title3.weight(.black))
                        
                        Text("HR")
                            .font(.subheadline.weight(.semibold))
                    }
                    .frame(width: 50, height: 50)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    
                    VStack {
                        Text(self.viewmodel.minutesLeft())
                            .font(.title3.weight(.black))
                        
                        Text("MIN")
                            .font(.subheadline.weight(.semibold))
                    }
                    .frame(width: 50, height: 50)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    
                    VStack {
                        Text(self.viewmodel.secondsLeft())
                            .font(.title3.weight(.black))
                        
                        Text("SEC")
                            .font(.subheadline.weight(.semibold))
                    }
                    .frame(width: 50, height: 50)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                }
            }
        }
        .foregroundColor(UIColor(self.viewmodel.event.eventColor).isLight() ? .black : .white)
        .frame(width: (UIScreen.main.bounds.width / 5) * 4, height: UIScreen.main.bounds.height / 7)
        .padding()
        .background(self.viewmodel.event.eventColor.gradient, in: RoundedRectangle(cornerRadius: 20))
        .sheet(isPresented: $showingEditSheet) {
            EditEventView(self.viewmodel.event)
                .presentationDetents([.fraction(0.42), .large])
        }
        .onChange(of: self.viewmodel.now) {_ in
            if self.viewmodel.event.eventDueDate <= self.viewmodel.now {
                print("\(self.viewmodel.event.eventName) is past due")
                self.dataController.processRefresh(event: self.viewmodel.event)
            }
        }
    }
    
    init(event: SavedEvent) {
        self.viewmodel = EventViewModel(event: event)
    }
}

@available(iOS 16.0, *)
struct GradientEventView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GradientEventView(event: SavedEvent.exampleEvent)
                .environmentObject(DataController.preview)
                .environmentObject(ModelData.shared)
        }
    }
}
