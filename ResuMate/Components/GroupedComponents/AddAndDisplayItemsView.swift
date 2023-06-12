//
//  AddAndDisplayItemsView.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 10/06/23.
//

import SwiftUI

enum ItemType {
    case item
    case tag
}

struct AddAndDisplayItemsView: View {
    var title: String
    var isButtonEnabled: Bool
    
    var onClicked: () -> Void
    
    @Binding var items: [String]
    var itemType: ItemType
    var onItemRemoved: (String) -> Void
    
    @State private var draggedAt: Int = 0
    
    var body: some View {
        LazyVStack {
            AddItemHeaderView(
                title: title,
                isButtonEnabled: isButtonEnabled,
                onClicked: onClicked)
            
            switch itemType {
            case .item:
                ForEach(items.indices, id: \.self) { index in
                    ItemCard(text: items[index], isShowingThumbsUp: false, isShowingDraggable: true, isShowingClose: true) {
                        print("deleteetetete")
                        onItemRemoved(items[index])
                    }
                        .onDrag {
                            self.draggedAt = index
                            return NSItemProvider(object: String(index) as NSString)
                        }
                        .onDrop(of: [.text], delegate: DragRelocateDelegate(item: items[index], oldIndex: index, newIndex: self.$draggedAt, items: $items))
                }
            case .tag:
                FlexibleView(
                    availableWidth: UIScreen.main.bounds.width,
                    data: items,
                    spacing: 15,
                    alignment: .leading
                ) { item in
                    TagCard(
                        text: item,
                        tagColor: .light, onClosed: {
                            onItemRemoved(item)
                        })
                        .onDrag {
                            self.draggedAt = items.firstIndex(of: item) ?? 0
                            return NSItemProvider(object: String(self.draggedAt) as NSString)
                        }
                        .onDrop(of: [.text], delegate: DragRelocateDelegate(item: item, oldIndex: items.firstIndex(of: item) ?? 0, newIndex: self.$draggedAt, items: $items))
                }
            }
        }
    }
    
    private mutating func moveItem(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
}

struct DragRelocateDelegate: DropDelegate {
    let item: String
    let oldIndex: Int
    @Binding var newIndex: Int
    @Binding var items: [String]
    
    func performDrop(info: DropInfo) -> Bool {
        items.move(fromOffsets: IndexSet(integer: oldIndex), toOffset: newIndex < oldIndex ? newIndex : newIndex+1)
        return true
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        if info.location.y < CGFloat(oldIndex)*72 && oldIndex > 0 {
            newIndex = oldIndex - 1
        } else if info.location.y > CGFloat(oldIndex)*72 && oldIndex < (items.count - 1) {
            newIndex = oldIndex + 1
        }
        return DropProposal(operation: .move)
    }
}


struct AddAndDisplayItemsView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AddAndDisplayItemsView(
                title: "Preview Title",
                isButtonEnabled: true,
                onClicked: {},
                items: .constant(["Test", "Test", "frwqklnrqw", "kdwqnklenwq", "fmqwkl"]),
                itemType: .item,
                onItemRemoved: {_ in }
            )
        }
        .background(.gray)
    }
}
