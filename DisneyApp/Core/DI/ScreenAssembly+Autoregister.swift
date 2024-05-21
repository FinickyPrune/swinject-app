import SwiftUI
import Swinject
import SwinjectAutoregistration

final class ScreenAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(
            CharactersListViewStore.self,
            initializer: CharactersListViewStore.init
        )
        
        container.autoregister(
            CharactersListView.self,
            initializer: CharactersListView.init
        )
        
        container.autoregister(
            UIViewController.self,
            name: container.charactersListViewName,
            argument: CharactersListView.self,
            initializer: UIHostingController.init
        )
        
        container.autoregister(
            UIViewController.self,
            name: container.charactersListViewName,
            initializer: {
                container.resolve(
                    UIViewController.self,
                    name: container.charactersListViewName,
                    argument: container.resolve(CharactersListView.self)
                )
            }
        )
    }
}
