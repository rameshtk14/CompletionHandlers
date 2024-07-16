//
//  UserViewModel.swift
//  Concurrency_CompletionHandlers
//
//  Created by RAMESH on 16/07/24.
//

import Foundation

@MainActor
class UsersListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    @MainActor
    func fetchUsers() {
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        isLoading.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            apiService.getJSON { (result: Result<[User], APIError>) in
                defer { self.isLoading.toggle() }
                
                switch result {
                case .success(let users):
                    self.users = users
                case .failure(let error):
                    print(error)
                    self.showAlert = true
                    self.errorMessage =  error.localizedDescription
                }
            }
        }
    }
}
extension UsersListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.users = User.mockUsers
        }
    }
}
