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
    
    //    @Binding var items: [String]
    var biodata: BiodataModel?
    var workExperienceList: [WorkExperienceModel]?
    var educationList: [EducationModel]?
    var organizationList: [OrganizationModel]?
    var volunteerList: [VolunteerModel]?
    var achievementList: [AchievementModel]?
    var skillList: [SkillModel]?
    
    var itemType: ItemType
    var resumeItemType: ResumeItemType
    
    var onItemRemoved: (String) -> Void
    
    var onWorkExperienceItemRemoved: ((WorkExperienceModel) -> Void)?
    var onEducationItemRemoved: ((EducationModel) -> Void)?
    var onOrganizationItemRemoved: ((OrganizationModel) -> Void)?
    var onVolunteerItemRemoved: ((VolunteerModel) -> Void)?
    var onAchievementItemRemoved: ((AchievementModel) -> Void)?
    var onSkillItemRemoved: ((SkillModel) -> Void)?
    
    @State private var draggedAt: Int = 0
    
    var body: some View {
        LazyVStack {
            AddItemHeaderView(
                title: title,
                isButtonEnabled: isButtonEnabled,
                onClicked: onClicked)
            
            switch itemType {
            case .item:
                switch resumeItemType {
                case .biodata:
                    ItemCard(text: "\(String(describing: biodata?.firstName ?? "")) \(String(describing: biodata?.lastName ?? ""))",
                             isShowingThumbsUp: false, isShowingClose: true) {
                        print("deleteetetete")
                        onItemRemoved("\(String(describing: biodata?.firstName)) \(String(describing: biodata?.lastName))")
                    }
                case .workExperience:
                    ForEach(workExperienceList!.indices, id: \.self) { index in
                        ItemCard(text: workExperienceList![index].company ?? "", isShowingThumbsUp: false, isShowingClose: true) {
                            print("deleteetetete")
                            onWorkExperienceItemRemoved!(workExperienceList![index])
                        }
                    }
                case .education:
                    ForEach(educationList!.indices, id: \.self) { index in
                        ItemCard(text: educationList![index].institution ?? "", isShowingThumbsUp: false, isShowingClose: true) {
                            print("deleteetetete")
                            onEducationItemRemoved!(educationList![index])
                        }
                    }
                case .organization:
                    ForEach(organizationList!.indices, id: \.self) { index in
                        ItemCard(text: organizationList![index].organization ?? "", isShowingThumbsUp: false, isShowingClose: true) {
                            print("deleteetetete")
                            onOrganizationItemRemoved!(organizationList![index])
                        }
                    }
                case .skill:
                    VStack {
                        
                    }
                case .achievement:
                    ForEach(achievementList!.indices, id: \.self) { index in
                        ItemCard(text: achievementList![index].title ?? "", isShowingThumbsUp: false, isShowingClose: true) {
                            print("deleteetetete")
                            onAchievementItemRemoved!(achievementList![index])
                        }
                    }
                case .volunteer:
                    ForEach(volunteerList!.indices, id: \.self) { index in
                        ItemCard(text: volunteerList![index].role ?? "", isShowingThumbsUp: false, isShowingClose: true) {
                            print("deleteetetete")
                            onVolunteerItemRemoved!(volunteerList![index])
                        }
//                        .onDrag {
//                            self.draggedAt = index
//                            return NSItemProvider(object: String(index) as NSString)
//                        }
//                        .onDrop(of: [.text], delegate: DragRelocateDelegate(item: items[index], oldIndex: index, newIndex: self.$draggedAt, items: $items))
                    }
                }

            case .tag:
                FlexibleView(
                    availableWidth: UIScreen.main.bounds.width,
                    data: skillList!,
                    spacing: 15,
                    alignment: .leading
                ) { item in
                    TagCard(
                        text: item.title ?? "",
                        tagColor: .light, onClosed: {
                            onItemRemoved(item.title ?? "")
                        })
                }
            }
        }
    }
    
//    private mutating func moveItem(from source: IndexSet, to destination: Int) {
//        items.move(fromOffsets: source, toOffset: destination)
//    }
}

//struct DragRelocateDelegate: DropDelegate {
//    var biodata: BiodataModel?
//    var workExperienceList: [WorkExperienceModel]?
//    var educationList: [EducationModel]?
//    var organizationList: [OrganizationModel]?
//    var volunteerList: [VolunteerModel]?
//    var achievementList: [AchievementModel]?
//    var skillList: [SkillModel]?
//
//    let oldIndex: Int
//    @Binding var newIndex: Int
//    @Binding var items: [String]
//
//    func performDrop(info: DropInfo) -> Bool {
//        items.move(fromOffsets: IndexSet(integer: oldIndex), toOffset: newIndex < oldIndex ? newIndex : newIndex+1)
//        return true
//    }
//
//    func dropUpdated(info: DropInfo) -> DropProposal? {
//        if info.location.y < CGFloat(oldIndex)*72 && oldIndex > 0 {
//            newIndex = oldIndex - 1
//        } else if info.location.y > CGFloat(oldIndex)*72 && oldIndex < (items.count - 1) {
//            newIndex = oldIndex + 1
//        }
//        return DropProposal(operation: .move)
//    }
//}


//struct AddAndDisplayItemsView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            AddAndDisplayItemsView(
//                title: "Preview Title",
//                isButtonEnabled: true,
//                onClicked: {},
//                itemType: .tag,
//                onItemRemoved: {_ in },
//                viewModel: ResumeViewModel(),
//                on
//            )
//        }
//        .background(.gray)
//    }
//}
