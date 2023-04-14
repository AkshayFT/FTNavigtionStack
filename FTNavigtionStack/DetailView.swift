//
//  DetailView.swift
//  FTNavigtionStack
//
//  Created by Akshay on 11/04/23.
//

import SwiftUI

struct DetailView: View {

    @Binding var selection: Panel?

    var body: some View {
        Text(textContent())

    }

    func textContent() -> String {
        let text: String
        switch selection ?? .home {
        case .home:
            text = "Home"
        case .favorites:
            text = "Favorites"
        case .unfiled:
            text = "Unfiled"
        case .trash:
            text = "Trash"
        case .templates:
            text = "templates"
        case .category(let category):
            text = category
        case .tags(let tag):
            text = tag
        case .media(let type):
            text = type.rawValue
        }
        return text
    }
}

struct DetailView_Previews: PreviewProvider {
    struct Preview: View {
        @State private var selection: Panel? = .home

        var body: some View {
            DetailView(selection: $selection)
        }
    }
    static var previews: some View {
        Preview()
    }
}
