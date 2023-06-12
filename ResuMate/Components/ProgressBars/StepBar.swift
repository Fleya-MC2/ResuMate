//
//  LiquidProgress.swift
//  JobMate
//
//  Created by Luthfi Asmara on 05/06/23.
//

import SwiftUI

//struct ContentView: View {
//    @State private var progress: CGFloat = 0
//    
//    var body: some View {
//        VStack {
//            ProgressBar(progress: progress)
//                .frame(width: 340, height: 5)
//            
//            Button("Next") {
//                withAnimation(.easeInOut(duration: 0.5)) {
//                    
//                    if progress == 1{
//                        progress = 1
//                    }
//                    else{
//                        progress = progress + 0.20
//                    }
//                }
//            }
//            .padding()
//        }
//    }
//}

struct StepBar: View {
    var progress: CGFloat
    var step: Int
    
    var body: some View {
        VStack{
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.5))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(width: geometry.size.width * progress, height: geometry.size.height)
                }
                .cornerRadius(geometry.size.height / 2)
            }.frame(width: 340, height: 5)
            HStack{
                Spacer()
                Text("\(step)/5 Step")
                    .blacktext15()
                    .bold()
                    
            }.padding(.horizontal, 25)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        StepBar(progress: 0.2, step: 1)
    }
}
