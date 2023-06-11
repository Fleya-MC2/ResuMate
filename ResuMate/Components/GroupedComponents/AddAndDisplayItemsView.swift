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
    
    var itemType: ItemType
    @State var items: [String]
    var onItemRemoved: () -> Void
    
    var body: some View {
        VStack {
            AddItemHeaderView(
                title: title,
                isButtonEnabled: isButtonEnabled,
                onClicked: onClicked)
            
            switch itemType {
            case .item:
                ForEach(items, id: \.self) { item in
                    ItemCard(text: item, isShowingThumbsUp: false)
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
                            onItemRemoved()
                        })
                }
            }
        }
    }
}

struct AddAndDisplayItemsView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AddAndDisplayItemsView(
                title: "Preview Title",
                isButtonEnabled: true,
                onClicked: {},
                itemType: .tag,
                items: ["Test", "Test", "frwqklnrqw", "kdwqnklenwq", "fmqwkl"],
                onItemRemoved: {}
            )
        }
        .background(.gray)
    }
}
