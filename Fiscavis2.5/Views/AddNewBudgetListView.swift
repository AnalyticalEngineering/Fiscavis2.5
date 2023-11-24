//
//  AddNewBudgetListView.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/20/23.
//

import SwiftUI
import CoreData

struct AddNewBudgetListView: View {
    //MARK:  PROPERTIES
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var selectedIcon: String = "figure.run.circle.fill"
    @State private var selectedColor: Color = .orange
    
    let onSave: (String,String, UIColor) -> Void
    
    private var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading){
            
            VStack {
                IconPickerView(selectedIcon: $selectedIcon, selectedColor: $selectedColor)
                    .font(.headline)
                   }
                
          
            TextField("Enter Budget Name", text: $name)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
                .font(.system(size: 22))
            Spacer()
        }
        .padding(10)
        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
       
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("New Budget")
                            .font(.headline)
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            HapticManager.notification(type: .success)
                            dismiss()
                        }
                        .fontDesign(.serif)
                        .font(.title3)
                        .fontWeight(.bold)
                        .tint(.red)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            HapticManager.notification(type: .success)
                            // save the list
                            onSave(name, selectedIcon, UIColor(selectedColor))
                            
                            dismiss()
                        }
                        .disabled(!isFormValid)
                        .fontDesign(.serif)
                        .font(.title3)
                        .fontWeight(.bold)
                        .tint(.green)
                    }
                }
        }
    }

struct AddNewListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddNewBudgetListView(onSave: { (_, _, _) in })
        }
    }
}
