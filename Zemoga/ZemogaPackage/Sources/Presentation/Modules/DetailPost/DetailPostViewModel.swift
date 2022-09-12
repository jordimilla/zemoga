import Foundation
import Domain
import UIKit
import Combine
import CoreData

final class DetailPostViewModel {
    
    let navigationController: UINavigationController
    let post: Post
    private let getDetailPostUseCase: GetDetailPostUseCase
    private let coreDataStore: CoreDataStoring
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var comments: [Comment] = []
    

    init(navigationController: UINavigationController,
         post: Post,
         getDetailPostUseCase: GetDetailPostUseCase,
         coreDataStore: CoreDataStoring) {
        self.navigationController = navigationController
        self.post = post
        self.getDetailPostUseCase = getDetailPostUseCase
        self.coreDataStore = coreDataStore
    }
    
    func getDetailPost() {
        getDetailPostUseCase.execute(value: (post.id))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }, receiveValue: { [weak self] items in
                self?.comments = items
                self?.createEntity()
            })
            .store(in: &cancellables)
    }
    
    func createEntity() {
        let action: Action = {
            for comment in self.comments {
                let c: CommentDB = self.coreDataStore.createEntity()
                c.id = Int32(comment.id)
                c.postId = Int32(comment.postId)
                c.name = comment.name
                c.email = comment.email
                c.body = comment.body
            }
        }
        
        coreDataStore
            .publicher(save: action)
            .sink { completion in
            } receiveValue: { success in
            }
            .store(in: &cancellables)
    }
    
    func fetchPostFromStored() {
        let request = NSFetchRequest<CommentDB>(entityName: CommentDB.entityName)
        request.predicate = NSPredicate(format: "postId == %@", NSNumber(value: post.id))
        coreDataStore
            .publicher(fetch: request)
            .sink { completion in
            } receiveValue: { items in
                if items.count == 0 {
                    self.getDetailPost()
                } else {
                    let comments = CommentDB.mapComments(input: items)
                    self.comments = comments
                }
                
            }
            .store(in: &cancellables)
    }

}
