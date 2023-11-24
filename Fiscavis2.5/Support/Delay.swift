//
//  Delay.swift
//  Fiscavis2.5
//
//  Created by J. DeWeese on 11/22/23.
//

import Foundation


class Delay {
    
    private var seconds: Double
    var workItem: DispatchWorkItem?
    
    init(seconds: Double = 1.5) {
        self.seconds = seconds
     
    }
    func performWork(_ work: @escaping () -> Void) {
        
        workItem = DispatchWorkItem(block: {
            work()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: workItem!)
    }
    func cancel() {
        workItem?.cancel()
    }
}
