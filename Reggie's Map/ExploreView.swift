//
//  ExploreView.swift
//  Reggie's Map
//
//  Created by angel hernandez   , Tanvai Pohare  , matt Strand , justin ray    on 6/17/25.


import SwiftUI
import Foundation
import SafariServices
import SwiftSoup

struct EventItem: Identifiable {
    let id = UUID()
    let title: String
    let link: URL
    let dateRange: String
    let startDate: Date
}

class ExploreViewModel: ObservableObject {
    @Published var events: [EventItem] = []

    func fetchEvents() {
        guard let url = URL(string: "https://events.illinoisstate.edu/events/rss") else {
            print("Invalid RSS feed URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error fetching RSS feed:", error.localizedDescription)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Server error or invalid response")
                return
            }

            guard let data = data else {
                print("No data received from RSS feed")
                return
            }

            let parser = ISURSSParser()
            let parsedItems = parser.parseRSS(data: data)

            DispatchQueue.main.async {
                self.events = parsedItems.sorted(by: { $0.startDate < $1.startDate })
            }
        }.resume()
    }
}

struct ExploreView: View {
    @StateObject private var viewModel = ExploreViewModel()
    @State private var selectedEvent: EventItem? = nil

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.events.prefix(7)) { event in
                    Button {
                        selectedEvent = event
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(event.title)
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text(event.dateRange)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
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
                viewModel.fetchEvents()
            }
            .sheet(item: $selectedEvent) { event in
                SafariView(url: event.link)
            }
        }
    }
}

class ISURSSParser: NSObject, XMLParserDelegate {
    private var items: [EventItem] = []
    private var currentElement = ""
    private var parsingItem = false

    private var currentTitle = ""
    private var currentLink = ""
    private var currentDateString = ""
    private var currentContentEncoded = ""

    func parseRSS(data: Data) -> [EventItem] {
        items.removeAll()
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return items
    }

    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName

        if elementName == "item" {
            parsingItem = true
            currentTitle = ""
            currentLink = ""
            currentDateString = ""
            currentContentEncoded = ""
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        guard parsingItem else { return }

        switch currentElement {
        case "title": currentTitle += string
        case "link": currentLink += string
        case "pubDate": currentDateString += string
        case "content:encoded": currentContentEncoded += string
        default: break
        }
    }

    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        if elementName == "item" {
            parsingItem = false

            let trimmedTitle = currentTitle.trimmingCharacters(in: .whitespacesAndNewlines)
            let trimmedLink = currentLink.trimmingCharacters(in: .whitespacesAndNewlines)
            let trimmedDate = currentDateString.trimmingCharacters(in: .whitespacesAndNewlines)
            let trimmedContent = currentContentEncoded.trimmingCharacters(in: .whitespacesAndNewlines)

            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"

            guard let parsedStartDate = dateFormatter.date(from: trimmedDate),
                  let url = URL(string: trimmedLink) else {
                print("Failed to parse event: \(trimmedTitle)")
                return
            }

            var fullDateRange: String = ""

            do {
                let doc = try SwiftSoup.parse(trimmedContent)
                let dateStart = try doc.select("span.tribe-events-schedule__date--start").first()?.text() ?? ""
                let timeStart = try doc.select("span.tribe-events-schedule__time--start").first()?.text() ?? ""
                let dateEnd = try doc.select("span.tribe-events-schedule__date--end").first()?.text() ?? ""
                let timeEnd = try doc.select("span.tribe-events-schedule__time--end").first()?.text() ?? ""
                let timezone = try doc.select("span.tribe-events-schedule__timezone").first()?.text() ?? ""

                if !dateStart.isEmpty && !timeStart.isEmpty && !dateEnd.isEmpty && !timeEnd.isEmpty {
                    fullDateRange = "\(dateStart), \(timeStart) – \(dateEnd), \(timeEnd) \(timezone)"
                } else {
                    fullDateRange = dateStart + (timeStart.isEmpty ? "" : ", \(timeStart)")
                }
            } catch {
                print("SwiftSoup parse error: \(error)")
                fullDateRange = DateFormatter.localizedString(from: parsedStartDate, dateStyle: .medium, timeStyle: .short)
            }

            let item = EventItem(title: trimmedTitle, link: url, dateRange: fullDateRange, startDate: parsedStartDate)
            items.append(item)
        }
    }

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("XML parse error:", parseError.localizedDescription)
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
