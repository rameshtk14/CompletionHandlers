//
//  PostListView.swift
//  iOSConcurrency1
//
//  Created by RAMESH on 16/07/24.
//

import SwiftUI

struct PostListView: View {
    @StateObject var vm =  PostListViewModel(forPreview: true)
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
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
        }
        .onAppear() {
            vm.userId = userId
            vm.fetchPosts()
        }
    }
}

#Preview {
    NavigationStack {
        PostListView(userId: 1)
    }
}
