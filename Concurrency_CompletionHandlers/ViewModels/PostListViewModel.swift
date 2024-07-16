//
//  PostListViewModel.swift
//  Concurrency_CompletionHandlers
//
//  Created by RAMESH on 16/07/24.
//

import Foundation


@MainActor
class PostListViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    var userId: Int?
    
    func fetchPosts() {
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId!)/posts")
        isLoading.toggle()
        apiService.getJSON { (result: Result<[Post], APIError>) in
            defer { self.isLoading.toggle() }
            
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    self.posts = posts
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                print(error)
            }
        }
    }
}
extension PostListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.posts = Post.mockSingleUsersPostsArray
        }
    }
}
