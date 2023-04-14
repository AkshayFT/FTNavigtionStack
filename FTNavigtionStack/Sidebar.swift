//
//  Sidebar.swift
//  FTNavigtionStack
//
//  Created by Akshay on 11/04/23.
//

import SwiftUI
import UniformTypeIdentifiers

enum MediaType: String, Hashable, CaseIterable, Identifiable {
    var id: String { rawValue }

    case photo
    case audio
}

enum Panel: Hashable {
    case home
    case favorites
    case unfiled
    case trash
    case templates
    case category(category: String)
    case media(type: MediaType)
    case tags(tag: String)
}

extension CoordinateSpace {
    static let list = CoordinateSpace.named("list")
    static let zstack = CoordinateSpace.named("zstack")
}


//https://stackoverflow.com/questions/60688913/swiftui-list-inside-scrollview
struct Sidebar: View {
    @Binding var selection: Panel?
    @State private var categories = ["My Notes", "School Notes", "College Notes", "My Nostes", "School Notess", "College Notess"]
    @State private var newCategory: String = ""
    @State private var topViewRect: CGRect = .zero

    var body: some View {
        GeometryReader { geometry in
            //            ZStack(alignment: .top) {
            List(selection: $selection) {
                TopContent(selection: $selection)
//                    .onItemFrameChanged(listGeometry: geometry) { frame in
//                        print("rect of top view: \(String(describing: frame)))")
//                        topViewRect = frame ?? .zero
//                    }


                Section("Categories") {
                    ForEach(categories, id: \.self) { category in
                        NavigationLink(value: Panel.category(category: category)) {
                            Label(category, systemImage: "folder")
                                .onDrop(of: [.text], delegate: SidebarDropDelegate())
                        }
                        .contextMenu {
                            Button {
                            } label: {
                                Label("Rename", systemImage: "pencil")
                            }
                            Button(role: .destructive) {
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    .onMove(perform: moveCategories)
                    .onDrag {
                        let userActivity = NSUserActivity(activityType: "com.fluidtouch.noteshelf.opencategory")
                        let itemProvider = NSItemProvider()
                        itemProvider.registerObject(userActivity, visibility: .all)
                        return itemProvider
                    }

                    HStack {
                        Image(systemName: "plus.circle")
                        TextField("Add Category", text: $newCategory)
                            .onSubmit {
                                categories.append(newCategory)
                                newCategory = ""
                            }
                    }
                }

                Section("Content") {
                    ForEach(MediaType.allCases) { type in
                        NavigationLink(value: Panel.media(type: type)) {
                            Label(type.rawValue, systemImage: "photo")
                        }
                    }
                }

                Section("Tags") {
                    ForEach(["All Tags", "Maths", "Physics", "Asll Tags", "Mathsss", "Physicsss", "Asll ddTags", "Madthsss", "Physicsddss"], id: \.self) { tag in
                        NavigationLink(value: Panel.tags(tag: tag)) {
                            Label(tag, systemImage: "tag")
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .coordinateSpace(name: "list")
//            .trackListFrame()
//            .overlay {
//                TopContent(selection: $selection)
//                    .padding(.horizontal, 24)
//                    .offset(y: topViewRect.minY)
//            }
        }
        .coordinateSpace(name: "zstack")
        .navigationTitle("Noteshelf")
        .navigationDestination(for: Panel.self) { panel in
            DetailView(selection: Binding(get: { return panel }, set: { selection = $0 }))
        }
        //        }
    }

    private func moveCategories(from source: IndexSet, to destination: Int) {
        categories.move(fromOffsets: source, toOffset: destination)
    }

}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGRect
    static var defaultValue = CGRect.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        let newRect = nextValue()
        value.origin.y = newRect.origin.y
    }
}

struct TopContent: View {
    @Binding var selection: Panel?

    var body: some View {
        Grid {
            GridRow {
                gridItem(for: .home) {
                        selection = .home
                    }

                gridItem(for: .starred) {
                        selection = .favorites
                    }
            }
            GridRow {
                gridItem(for: .unfiled) {
                        selection = .unfiled
                    }
                gridItem(for: .trash) {
                        selection = .trash
                    }
                .highPriorityGesture(LongPressGesture())
                .contextMenu {
                    Button {
                    } label: {
                        Label("Open in new window", systemImage: "window")
                    }
                    Button(role: .destructive) {
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            GridRow {
                Button {
                    selection = .templates
                } label: {
                    FTTemplatesSidebarItemView()
                }
                .gridCellColumns(2)
            }
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private func gridItem(for type: SidebarTopSectionElement, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            FTSidebarTopSectionGridItemView(title: type.displayTitle,
                                            iconName: type.iconName,
                                            itemsCount: 0,
                                            bgColor: type.bgColor,
                                            iconTintColor: type.iconTint)
        }
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(selection: Binding.constant(Panel.home))
    }
}

class SidebarDropDelegate: DropDelegate {
    func performDrop(info: DropInfo) -> Bool {
        print("Dropped", info)
        return true
    }
}
