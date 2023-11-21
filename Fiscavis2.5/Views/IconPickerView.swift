//
//  IconPickerView.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/20/23.
//

import SwiftUI
import CoreData


struct IconPickerView: View {
    @Binding var selectedIcon: String
    
    
    let icon = [
    "car.circle.fill",
    "house.circle.fill",
    "graduationcap.circle.fill",
    "fork.knife.circle.fill",
    "dollarsign.circle.fill",
    "wifi.circle.fill",
    "phone.circle.fill",
    "play.circle.fill",
    "stethoscope.circle.fill",
    "cross.circle.fill",
    "figure.run.circle.fill"
    ]
    @Binding var selectedColor: Color
    
    let colors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple]
    
    
    
       var body: some View {
           VStack {
               Text("Select Budget Category Icon:")
                   .font(.headline)
                   .fontWeight(.bold)
               Picker("Icons", selection: $selectedIcon){
                   
                   ForEach(icon, id: \.self) { icon in
                       Image(systemName: icon)
                           .tag(icon)
                           .tint(selectedColor)
                         
                          
                   }
                  
               }
               .frame(maxWidth: .infinity, maxHeight: 150)
               .scaleEffect(CGSize(width: 2.5, height: 2.5))
               .tint(selectedColor)
               
               HStack {
                   ForEach(colors, id: \.self) { color in
                       ZStack{
                           Circle().fill()
                               .foregroundColor(color)
                               .padding(2)
                           Circle()
                               .strokeBorder(selectedColor == color ? .gray: .clear, lineWidth: 4)
                               .scaleEffect(CGSize(width: 1.2, height: 1.2))
                       }.onTapGesture {
                          
                           selectedColor = color
                       }
                               
                   }
               }.padding()
               .frame(maxWidth: .infinity, maxHeight: 100)
                   .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                   
           }
       }
               }
#Preview {
    IconPickerView(selectedIcon: .constant(""), selectedColor: .constant(.orange))
}



