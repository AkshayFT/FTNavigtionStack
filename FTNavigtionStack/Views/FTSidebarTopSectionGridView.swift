//
//  FTSidebarTopSectionGridView.swift
//  NewShelfSidebar
//
//  Created by Ramakrishna on 13/04/23.
//

import SwiftUI


struct FTSidebarTopSectionGridView: View {
    private var topSectionOptions: [SidebarTopSectionElement] = [.home,.starred,.unfiled,.trash]
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        LazyVGrid(columns: gridItemLayout(),alignment: .center, content: {
            ForEach(topSectionOptions, id: \.self) { option in
                Button {

                } label: {
                    FTSidebarTopSectionGridItemView(title: option.displayTitle, iconName: option.iconName, itemsCount: 0, bgColor: option.bgColor, iconTintColor: option.iconTint)
                }
            }
        })
        .frame(maxWidth: horizontalSizeClass == .regular ? 320 : 280,maxHeight: 168)
    }
    private func gridItemLayout() -> [GridItem] {
        let spacing : CGFloat = 8
        let width: CGFloat = 116
        return [GridItem(GridItem.Size.adaptive(minimum: width,maximum: .infinity), spacing: spacing, alignment: .center)]
    }
}

struct FTSidebarTopSectionGridView_Previews: PreviewProvider {
    static var previews: some View {
        FTSidebarTopSectionGridView()
            .environmentObject(FTSidebarTopSectionViewModel())
    }
}
