//
//  InputTag.swift
//  JobMate
//
//  Created by Luthfi Asmara on 05/06/23.
//

import SwiftUI

struct InputTag: View {
    @State private var tags: [String] = []
    @State private var newTag: String = ""


    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                FormViewBiodata(placeholder: "Enter Your Skill", fill: $newTag)
                Button{
                    print(newTag)
                    addTag()
                    
                }label: {
                    Text("tambah")
                        .padding(.leading, 10)
                }
                
            }.padding(.horizontal, 20)
            Spacer().frame(height: 20)
            GeometryReader { geometryProxy in
                FlexibleView(
                    availableWidth: geometryProxy.size.width, data: tags,
                    spacing: 15,
                    alignment: .leading
                ) { item in
                    HStack{
                        Text(item)
                            
                            
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                    }
                    .padding( 10)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.grayop)
                        )
                }
                .padding(.horizontal, 10)
            }
            Spacer()
        }
    }
    private func addTag() {
            guard !newTag.isEmpty else {
                return
            }
            tags.append(newTag)
            newTag = ""
        }
}


struct InputTag_Previews: PreviewProvider {
    static var previews: some View {
        InputTag()
    }
}

struct FormViewBiodata: View {
    //    @State var title: String
    @State var placeholder: String
    @Binding var fill: String
    @State var birthdate: Date = Date()
    
    
    var body: some View{
        VStack(alignment: .leading){
           
            HStack{
                TextField(placeholder, text: $fill)
                    .padding(.horizontal, 20)
                
                
                Spacer()
            }.background(Rectangle().fill(.white)
                .frame(height: 48)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 2)
                    
                )
            )
        }
        
    }
}

struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let availableWidth: CGFloat
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content
    @State var elementsSize: [Data.Element: CGSize] = [:]
    
    var body : some View {
        VStack(alignment: alignment, spacing: spacing) {
            ForEach(computeRows(), id: \.self) { rowElements in
                HStack(spacing: spacing) {
                    ForEach(rowElements, id: \.self) { element in
                        content(element)
                            .fixedSize()
                            .readSize { size in
                                elementsSize[element] = size
                            }
                    }
                }
            }
        }
    }
    
    func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth
        
        for element in data {
            let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]
            
            if remainingWidth - (elementSize.width + spacing) >= 0 {
                rows[currentRow].append(element)
            } else {
                currentRow = currentRow + 1
                rows.append([element])
                remainingWidth = availableWidth
            }
            
            remainingWidth = remainingWidth - (elementSize.width + spacing)
        }
        
        return rows
    }
}

extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}