//
//  UsersListView.swift
//  iOSConcurrency1
//
//  Created by RAMESH on 16/07/24.
//

import SwiftUI

struct UsersListView: View {
    #warning("Remove forPreview argument or set ti to false for prod ")
    @StateObject var vm =  UsersListViewModel(forPreview: true)
    
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
            .navigationTitle("Users")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
        }
        .onAppear() {
            vm.fetchUsers()
        }
    }
}

#Preview {
    UsersListView()
}
