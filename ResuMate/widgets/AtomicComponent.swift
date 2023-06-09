//
//  AtomicComponent.swift
//  JobMate
//
//  Created by Luthfi Asmara on 07/06/23.
//

import SwiftUI

struct AtomicComponents: View {
    var body: some View {
           VStack {
               Text("Judul")
               
               AtomicComponent {
                   Text("Isi Konten 1")
                   Text("Isi Konten 2")
                   // Tambahkan view lain yang Anda inginkan di sini
               }
               
               Text("Keterangan")
           }
       }
}

struct AtomicComponent_Previews: PreviewProvider {
    static var previews: some View {
        AtomicComponents()
    }
}


struct AtomicComponent<Content: View>: View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        VStack {
            // Add any desired layout or logic for the atomic component here
            content()
        }
    }
}
