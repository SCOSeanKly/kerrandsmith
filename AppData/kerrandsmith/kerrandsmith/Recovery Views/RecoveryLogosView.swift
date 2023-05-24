//
//  RecoveryLogosView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 17/05/2023.
//

import SwiftUI

struct RecoveryLogosView: View {
    let screenWidth = UIScreen.main.bounds.width / 8
    @State private var flippedIndices: Set<Int> = []

    var body: some View {
        HStack(spacing: 15) {
            ForEach(recoveryLogos.indices, id: \.self) { index in
                Image(recoveryLogos[index])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(5)
                    .frame(width: screenWidth)
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 0)
                 //   .rotation3DEffect(.degrees(flippedIndices.contains(index) ? 90 : 0), axis: (x: 0, y: 1, z: 0))
                    .onAppear {
                        flipImageRandomly(index: index)
                    }
                    .animation(.easeOut(duration: 1.0), value: flippedIndices)
            }
        }
    }

    func flipImageRandomly(index: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int.random(in: 3...10))) {
            let _ = withAnimation(Animation.linear(duration: 0.2)) {
                flippedIndices.insert(index)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                let _ = withAnimation(Animation.linear(duration: 0.2)) {
                    flippedIndices.remove(index)
                }
                flipImageRandomly(index: index)
            }
        }
    }
}

struct RecoveryLogosView_Previews: PreviewProvider {
    static var previews: some View {
        RecoveryLogosView()
    }
}



   

