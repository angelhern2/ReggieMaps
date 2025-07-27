//
//  ExploreView.swift
//  Reggie's Map
//
//  Created by angel hernandez on 6/23/25.
//
import SwiftUI
import Foundation
import SafariServices

struct EventItem: Identifiable {
    let id = UUID()
    let title: String
    let link: URL
}

struct ExploreView: View {
    @State private var events: [EventItem] = []
    @State private var selectedEvent: EventItem? = nil
    @State private var showMoreEvents = false

    var body: some View {
        NavigationView {
            VStack {
                List(events.prefix(7)) { event in
                    Button(action: {
                        selectedEvent = event
                    }) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(event.title)
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        .padding(.vertical, 4)
                    }
                }
                Button("See More Events") {
                    if let url = URL(string: "https://events.illinoisstate.edu/") {
                        UIApplication.shared.open(url)
                    }
                }
                .padding()
            }
            .navigationTitle("ISU Events")
            .onAppear {
                fetchEvents()
            }
            .sheet(item: $selectedEvent) { event in
                SafariView(url: event.link)
            }
        }
    }

    func fetchEvents() {
        guard let url = URL(string: "https://events.illinoisstate.edu/events/rss") else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let parser = ISURSSParser()
            let parsedItems = parser.parseRSS(data: data)
            DispatchQueue.main.async {
                self.events = parsedItems
            }
        }
        task.resume()
    }
}

class ISURSSParser: NSObject, XMLParserDelegate {
    private var items: [EventItem] = []
    private var currentElement = ""
    private var currentTitle = ""
    private var currentLink = ""

    func parseRSS(data: Data) -> [EventItem] {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return items
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "item" {
            currentTitle = ""
            currentLink = ""
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title": currentTitle += string
        case "link": currentLink += string
        default: break
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            if let url = URL(string: currentLink.trimmingCharacters(in: .whitespacesAndNewlines)) {
                let item = EventItem(title: currentTitle.trimmingCharacters(in: .whitespacesAndNewlines), link: url)
                items.append(item)
            }
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}

#Preview {
    ExploreView()
}
