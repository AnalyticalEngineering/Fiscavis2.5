//
//  BudgetCard.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/21/23.
//

import SwiftUI

struct BudgetCard: View {
    let myList: MyList
   
    
    
    var body: some View {
        VStack{
           
            HStack {
                Image(systemName: myList.icon)
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundStyle(Color(myList.color))
                    
                Text(myList.name)
                Spacer()
                Image(systemName: "chevron.right")
                    
                    .opacity(0.4)
                    .padding([.trailing], 10)
            }
            .font(.title3)
            .fontWeight(.bold)
            .padding(.horizontal)
            
        }
    }
}
struct BudgetCard_Previews: PreviewProvider {
    static var previews: some View {
        BudgetCard(myList: PreviewData.myList)
    }
}
