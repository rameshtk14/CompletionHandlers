//
//  UsersListView.swift
//  Concurrency_CompletionHandlers
//
//  Created by RAMESH on 16/07/24.
//

import SwiftUI

struct UsersListView: View {
    #warning("Remove forPreview argument or set ti to false for prod ")
    @StateObject var vm =  UsersListViewModel(forPreview: false)
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.users) { user in
                    
                    NavigationLink {
                        PostListView(userId: user.id)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            Text(user.email)
                        }
                    }
                   
                }
            }
            .overlay(content: {
                if vm.isLoading {
                    ProgressView()
                }
            })
            .alert("Concurrency App Error", isPresented: $vm.showAlert, actions: {
                Button("OK") {} },message: {
                if let errorMessage = vm.errorMessage {
                    Text(errorMessage)
                }
            })
            .navigationTitle("Users")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
        }
        
       
        .task {
            await vm.fetchUsers()
        }
    }
}

#Preview {
    UsersListView()
}
