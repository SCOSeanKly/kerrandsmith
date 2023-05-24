//
//  AnimationProgress.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 22/05/2023.
//

import SwiftUI

/// Custom View Modifier, Which will return Animation Progress
extension View {
    @ViewBuilder
    func animationProgress<Value: VectorArithmetic>(endValue: Value, progress: @escaping (Value) -> ()) -> some View {
        self
            .modifier(AnimationProgress(endValue: endValue, onChange: progress))
    }
}


struct AnimationProgress<Value: VectorArithmetic>: ViewModifier, Animatable {
    var animatableData: Value {
        didSet {
            sendProgress()
        }
    }
    var endValue: Value
    var onChange: (Value) -> ()
    
    init(endValue: Value, onChange: @escaping (Value) -> Void) {
        self.animatableData = endValue
        self.endValue = endValue
        self.onChange = onChange
    }
    
    func body(content: Content) -> some View {
        content
    }
    
    func sendProgress() {
        DispatchQueue.main.async {
            onChange(animatableData)
        }
    }
}
