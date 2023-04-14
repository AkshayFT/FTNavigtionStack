//
//  FTTemplatesSidebarItemView.swift
//  NewShelfSidebar
//
//  Created by Ramakrishna on 13/04/23.
//

import SwiftUI

struct FTTemplatesSidebarItemView: View {
    var body: some View {
        HStack(spacing:0) {
                VStack {
                    ZStack(alignment: .bottomLeading) {
                        Image(uiImage: UIImage(named: "paper")!)
                            .zIndex(1)
                        Image(uiImage: UIImage(named: "paper1")!)
                            .zIndex(0)
                            .padding(.leading,12.91)
                    }
                }
                VStack(alignment: .leading,spacing: 0) {
                    Text("Templates")
                        .frame(maxWidth: .infinity,maxHeight:22, alignment: .leading)
                        .foregroundColor(Color("templatesTitleTint"))
                    Text("Papers & Journals")
                        .frame(maxWidth: .infinity,maxHeight:16,alignment: .leading)
                        .foregroundColor(Color("templatesSubtitleTint"))
                }
        }
        .frame(maxWidth: .infinity,maxHeight: 71, alignment: .leading)
        .background(Color("templatesBG"))
        .cornerRadius(16)
    }
}
struct FTTemplatesSidebarItemView_Previews: PreviewProvider {
    static var previews: some View {
        FTTemplatesSidebarItemView()
            .environmentObject(FTSidebarTopSectionViewModel())
    }
}
