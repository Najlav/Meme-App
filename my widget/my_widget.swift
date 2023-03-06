//
//  my_widget.swift
//  my widget
//
//  Created by Najla on 12/09/2022.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), memeData: Data())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        Task{
            do{
                let meme = try await MemeService.shared.getMeme()
                let (data, _) = try await URLSession.shared.data(from: meme.url)
                let entry = SimpleEntry(date: .now, memeData: data)
                
                _ = Timeline(entries: [entry], policy: .after(.now.advanced(by: 15 * 60)))
                completion(entry)
            } catch{
                print(error)
            }
        }
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task{
            do{
                let meme = try await MemeService.shared.getMeme()
                let (data, _) = try await URLSession.shared.data(from: meme.url)
                let entry = SimpleEntry(date: .now, memeData: data)
                
                let timeline = Timeline(entries: [entry], policy: .after(.now.advanced(by: 15 * 60)))
                completion(timeline)
            } catch{
                print(error)
            }
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let memeData: Data
}

struct my_widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
       
        Image(uiImage: UIImage(data: entry.memeData)!).resizable().scaledToFit()
    }
}

@main
struct my_widget: Widget {
    let kind: String = "my_widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            my_widgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct my_widget_Previews: PreviewProvider {
    static var previews: some View {
        my_widgetEntryView(entry: SimpleEntry(date: Date(), memeData: Data()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
