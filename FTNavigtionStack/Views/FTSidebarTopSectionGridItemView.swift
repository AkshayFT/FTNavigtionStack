//
//  FTSidebarTopSectionGridView.swift
//  NewShelfSidebar
//
//  Created by Ramakrishna on 13/04/23.
//

import SwiftUI

struct FTSidebarTopSectionGridItemView: View {
    var viewModel: FTSidebarGridItemViewModel = FTSidebarGridItemViewModel()
    var title: String
    var iconName:String
    var itemsCount: Int
    var bgColor: Color
    var iconTintColor: Color
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, content: {
                    Image(systemName: iconName)
                        .frame(width: 24,height: 24,alignment: .center)
                        .padding(.bottom,10)
                        .foregroundColor(iconTintColor)
                    Spacer()
                Text(itemsCount > 0 ? "\(itemsCount)" : "")
                })
                .padding(.top,14)
                .padding(.horizontal,12)
                HStack(alignment: .top, content: {
                    Text(title)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .foregroundColor(.black)
                })
                .padding(.horizontal,12)
                .padding(.bottom,10)
        }
        .frame(maxWidth: .infinity,maxHeight: 80)
        .background(bgColor)
        .cornerRadius(16)

    }
}
struct FTSidebarTopSectionGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        FTSidebarTopSectionGridItemView(title: "Starred", iconName: "star", itemsCount: 0, bgColor: Color.red, iconTintColor: Color.white)
    }
}
