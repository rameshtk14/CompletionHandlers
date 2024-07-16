//
//  PostListViewModel.swift
//  iOSConcurrency1
//
//  Created by RAMESH on 16/07/24.
//

import Foundation


class PostListViewModel: ObservableObject {
    @Published var posts: [Post] = []
    var userId: Int?
    
    func fetchPosts() {
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users\(userId)/posts")
        apiService.getJSON { (result: Result<[Post], APIError>) in
            switch result {

            case .success(let posts):
                DispatchQueue.main.async {
                    self.posts = posts
                }
            case .failure(let error):
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
