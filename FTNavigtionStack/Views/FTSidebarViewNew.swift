//
//  FTSidebarViewNew.swift
//  NewShelfSidebar
//
//  Created by Ramakrishna on 13/04/23.
//

import SwiftUI
struct FTSidebarViewNew: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var viewModel: FTSidebarTopSectionViewModel = FTSidebarTopSectionViewModel()
    var body: some View {
        VStack {
            FTSidebarTopSectionGridView()
                .environmentObject(viewModel)
            FTTemplatesSidebarItemView()
                .environmentObject(viewModel)
        }
        .frame(maxWidth: horizontalSizeClass == .regular ? 320 : 280)
        .padding(.horizontal,20)
    }
}
struct FTSidebarViewNew_Previews: PreviewProvider {
    static var previews: some View {
        FTSidebarViewNew()
    }
}
