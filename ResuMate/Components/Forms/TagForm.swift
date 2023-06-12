//
//  InputTag.swift
//  JobMate
//
//  Created by Luthfi Asmara on 05/06/23.
//

import SwiftUI

struct TagForm: View {
    @Binding var tags: [SkillModel]
    @State private var newTag: String = ""
    
    @State private var timer: Timer? = nil
    
    let chatGptService: ChatGptService = ChatGptService()
    @State private var isLoading: Bool = false
    @State private var isSuggestion: Bool = false
    
    @State private var suggestionSkill: [String] = []
    
    
    var body: some View {
        VStack{
            Spacer()
            VStack(alignment: .leading){
                HStack{
                    Text("Skill")
                        .blacktext17()
                        .fontWeight(.regular)
                        .padding(.bottom, 10)
                        .padding(.horizontal)
                    Spacer()
                }
                Spacer().frame(height: 5)
                ZStack {
                    TextField("Input Skill", text: $newTag)
                        .padding(.leading, 20)
                        .submitLabel(.return)
                        .onSubmit {
                            handleSubmit(text: newTag)
                        }
                        .onChange(of: newTag) { skill in
                            timer?.invalidate() // Cancel the existing timer if there is one
                            timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                                print("textfield 2 sec")
                                self.isLoading = true
                            }
                        }
                        .background(Rectangle().fill(.white)
                            .frame(height: 48)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                        )
                        .foregroundColor(.black)
                    
                    if !newTag.isEmpty || isSuggestion {
                        Button {
                            //                        onClosed()
                            newTag = ""
                            isSuggestion = false
                            isLoading = false
                        } label: {
                            HStack {
                                Spacer()
                                
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.darkGray)
                                    .font(.system(size: 18))
                                    .frame(width: 30, height: 30)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical)
                
                if isLoading {
                    VStack {
                        ProgressView("Loading...")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.lightGray)
                            .cornerRadius(16)
                            .padding()
                        
                        Spacer()
                    }
                }
                
                if isSuggestion && !isLoading {
                    VStack {
                        List {
                            ForEach(suggestionSkill, id: \.self) { skill in
                                Button {
                                    handleSubmit(text: skill)
                                    isSuggestion = false
                                } label: {
                                    Text(skill)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        .listStyle(.insetGrouped)
                        
                        Spacer()
                    }
                    .cornerRadius(16)
                    .padding()
                } else {
                    GeometryReader { geometryProxy in
                        FlexibleView(
                            availableWidth: geometryProxy.size.width, data: tags,
                            spacing: 15,
                            alignment: .leading
                        ) { item in
                            HStack{
                                Text(item.title ?? "")
                                
                                Button {
//                                    remove func here
                                } label: {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.gray)
                                }
                                
                                
                            }
                            .padding( 10)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.mediumDarkGray)
                            )
                        }
                        .padding(.horizontal, 10)
                    }
                }
                
                
                Spacer()
            }
        }
        .onChange(of: isLoading) { isLoading in
            if !isLoading {
                return
            }
            
            chatGptService.fetchSkillSuggestionBySkill(skill: newTag, completion: { result in
                DispatchQueue.main.async {
                    self.isLoading = false
                    switch result {
                    case .success(let suggestionList):
                        print("[suggestionList]", suggestionList)
                        
                        self.suggestionSkill = suggestionList.map { $0.suggestion }
                        print("[suggestionSkill]", suggestionSkill)
                        
                        isSuggestion = true
                    case .failure(_): break
                    }
                }
            })
        }
    }

    
    func handleSubmit(text: String) {
        addTag()
        newTag = ""
    }
    
    private func addTag() {
          guard !newTag.isEmpty else {
            return
        }
        tags.append(SkillModel(id: UUID(), title: newTag))
        newTag = ""
    }
    
    func removeTag(tag: String) {
        // remove function
    }
}


//struct InputTag_Previews: PreviewProvider {
//    static var previews: some View {
//        TagForm()
//    }
//}

struct FormViewBiodata: View {
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
