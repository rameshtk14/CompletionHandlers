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
    
    func fetchPosts() async {
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId!)/posts")
        isLoading.toggle()
        defer {
            isLoading.toggle()
        }
        do {
           posts = try await apiService.getJSON()
        }
        catch {
            self.showAlert = true
            self.errorMessage =  error.localizedDescription
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
