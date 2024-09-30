import AppIntents
import Foundation
import OSLog

@available(iOS 16.0, *)
struct ClientShortcuts: AppShortcutsProvider {
    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: GetPageContent(),
            phrases: [
                "Get content for currently open page from \(.applicationName)"
            ],
            shortTitle: "Get current page"
        )
    }
}

@available(iOS 16, *)
struct ShortcutPageContent: AppEntity {
    static var defaultQuery = ShortcutPageContentQuery()
    
    let id = UUID()
    var title = ""
    
    static var typeDisplayRepresentation = TypeDisplayRepresentation(
        stringLiteral: "Current Page"
    )
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(title)")
    }
}

struct ShortcutPageContentQuery: EntityQuery {
    
    func entities(for identifiers: [Entity.ID]) async throws -> [ShortcutPageContent] {
        []
    }
    
    func suggestedEntities() async throws -> some ResultsCollection {
        .empty
    }
}

@available(iOS 16, *)
struct GetPageContent: AppIntent {
    static var title: LocalizedStringResource = "Get current page content"

    enum Error: Swift.Error, LocalizedError {
        case unableToFindPage

        var errorDescription: String? {
            switch self {
            case .unableToFindPage:
                return NSLocalizedString("There is currently no page open.", comment: "")
            }
        }
    }

    func perform() async throws -> some ReturnsValue<ShortcutPageContent> {
        .result(value: ShortcutPageContent(title: "Google"))
    }
}
