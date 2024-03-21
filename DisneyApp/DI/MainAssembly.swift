import Foundation
import UIKit
import Swinject

enum MainAssembly {
    static let container: Container = {
        let container = Container()

        container.registerCoordinators()
        container.registerRepositories()
        container.registerStores()
        container.registerViews()

        return container
    }()
}

private extension Container {

    func registerCoordinators() {
        self.register(Coordinator.self) { _, navigationController in
            let coordinator = Coordinator(navigationController: navigationController)

            return coordinator
        }
    }

    func registerRepositories() {
        self.register(UserRepository.self) { _ in
            return UserRepositoryImpl()
        }

        self.register(CharactersRepository.self) { _ in
            return CharactersRepositoryImpl()
        }
    }

    func registerStores() {
        self.register(CharactersListViewStore.self) { resolver in
            return CharactersListViewStore(
                userRepository: resolver.resolve(UserRepository.self),
                charactersRepository: resolver.resolve(CharactersRepository.self)
            )
        }
    }

    func registerViews() {
        self.register(CharactersListView.self) { resolver in
            return CharactersListView(
                viewStore: resolver.resolve(CharactersListViewStore.self)
            )
        }
    }

}

private extension Resolver {
    func resolve<T>(_ type: T.Type) -> T {
        self.resolve(T.self)!
    }
}
