import Foundation
import Swinject

final class ServicesAssembly: Assembly {

    func assemble(container: Container) {
        container.register(GenericAPI.self) { _ in
            Client()
        }

        container.register(UserRepository.self) { resolver in
            if ConfigKeyProvider.shared.isEnabled(.isUserMocked) {
                return UserRepositoryMock()
            }
            return UserRepositoryImpl(
                client: resolver.resolve(GenericAPI.self)
            )
        }

        container.register(CharactersRepository.self) { resolver in
            
            if ConfigKeyProvider.shared.isEnabled(.isDisneyCharacters) {
                return DisneyCharactersRepository(
                    client: resolver.resolve(GenericAPI.self)
                )
            }
            return NarutoCharactersRepository(
                client: resolver.resolve(GenericAPI.self)
            )
        }
    }
}
