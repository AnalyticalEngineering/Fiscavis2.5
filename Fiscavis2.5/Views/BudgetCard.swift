//
//  BudgetCard.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/21/23.
//

import SwiftUI

struct BudgetCard: View {
    //MARK:  PROPERTIES
    let myList: MyList
    
    
    
    var body: some View {
        
        VStack{
        HStack{
            Image(systemName: myList.icon)
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundStyle(Color(myList.color))
                .padding(10)
            
            Text(myList.name)
            Spacer()
        }
            HStack{
                Text("Amount Budgeted:     $4500.00")
                    .font(.caption)
                    .foregroundStyle(.primary)
                    .padding(2)
                Spacer()
                Text("Amount Remaing:    $2750.78")
                    .font(.caption)
                    .foregroundStyle(.red)
                    .padding(2)
            }.background(Color.colorGray)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 10.0).stroke(Color(myList.color), lineWidth: 4)
                    .font(.title3)
                    .fontWeight(.bold)
            }
        }
    }
    
    

