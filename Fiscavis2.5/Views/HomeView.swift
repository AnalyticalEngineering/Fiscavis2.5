//
//  HomeView.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/19/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello")
                
                Spacer()
                Button {
                    HapticManager.notification(type: .success)
                    isPresented = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .frame(maxWidth: 200, maxHeight: 50)
                        VStack {
                            Text("+ Add New Budget")
                                .foregroundStyle(.white)
                                .font(.headline)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                        }
                        
                    }
                }
                    .padding(.horizontal)
            }
            
            
            .sheet(isPresented: $isPresented) {
                NavigationView{
                    AddNewBudgetListView { name, selectedIcon, color in
                    }   // save the list to the database
                }
            }
            .padding(.horizontal)
        }
        
    }
}


#Preview {
    HomeView()
}
