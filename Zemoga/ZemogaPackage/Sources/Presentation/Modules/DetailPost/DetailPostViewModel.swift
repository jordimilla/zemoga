import Foundation
import Domain
import UIKit
import Combine
import CoreData

final class DetailPostViewModel {
    
    let navigationController: UINavigationController
    let post: Post
    private let getDetailPostUseCase: GetDetailPostUseCase
    private let fetchCommentsFromStoredUseCase: FetchCommentsFromStoredUseCase
    private let createCommentDBEntitiesUseCase: CreateCommentDBEntitiesUseCase
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var comments: [Comment] = []
    @Published private(set) var alert: Bool = false
    

    init(navigationController: UINavigationController,
         post: Post,
         getDetailPostUseCase: GetDetailPostUseCase,
         fetchCommentsFromStoredUseCase: FetchCommentsFromStoredUseCase,
         createCommentDBEntitiesUseCase: CreateCommentDBEntitiesUseCase) {
        self.navigationController = navigationController
        self.post = post
        self.getDetailPostUseCase = getDetailPostUseCase
        self.fetchCommentsFromStoredUseCase = fetchCommentsFromStoredUseCase
        self.createCommentDBEntitiesUseCase = createCommentDBEntitiesUseCase
    }
    
    func getDetailPost() {
        getDetailPostUseCase.execute(value: (post.id))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    self.alert = true
                    break
                }
            }, receiveValue: { [weak self] items in
                self?.comments = items
                self?.createEntity(comments: items)
            })
            .store(in: &cancellables)
    }
    
    func createEntity(comments: [Comment]) {
        createCommentDBEntitiesUseCase.execute(value: comments)
    }
    
    func fetchCommentsFromStored() {
        fetchCommentsFromStoredUseCase.execute(value: (post))
            .sink(receiveCompletion: { completion in
            }, receiveValue: { [weak self] items in
                if items.count == 0 {
                    self?.getDetailPost()
                } else {
                    let comments = CommentDB.mapComments(input: items)
                    self?.comments = comments
                }
            })
            .store(in: &cancellables)
    }

}
