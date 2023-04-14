//
//  ContentView.swift
//  FTNavigtionStack
//
//  Created by Akshay on 10/04/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Panel? = Panel.home
    @State private var path = NavigationPath()

    var body: some View {
        NavigationSplitView {
            Sidebar(selection: $selection)
                .navigationSplitViewColumnWidth(320)
        } detail: {
            NavigationStack(path: $path) {
                DetailView(selection: $selection)
            }
        }
        .onChange(of: selection) { _ in
            path.removeLast(path.count)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
