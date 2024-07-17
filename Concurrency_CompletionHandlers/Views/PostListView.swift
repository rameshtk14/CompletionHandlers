//
//  PostListView.swift
//  Concurrency_CompletionHandlers
//
//  Created by RAMESH on 16/07/24.
//

import SwiftUI

struct PostListView: View {
    @StateObject var vm =  PostListViewModel(forPreview: false)
    var userId: Int?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.posts) { post in
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                            .font(.callout)
                            .foregroundStyle(.secondary)
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
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
        }
        .task{
            vm.userId = userId
            await vm.fetchPosts()
        }
    }
}

#Preview {
    NavigationStack {
        PostListView(userId: 1)
    }
}
