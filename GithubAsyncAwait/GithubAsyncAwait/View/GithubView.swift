//
//  ContentView.swift
//  GithubAsyncAwait
//
//  Created by Neha Pant on 08/08/2023.
//

import SwiftUI

struct GithubView: View {
    @StateObject var vm: GithubUsersViewModel
    
    var body: some View {
        VStack {
            List(vm.users) { user in
                Text(user.login)
            }
        }
        .alert(vm.errorMessage, isPresented: $vm.showError, actions: {
        })
        .refreshable {
            vm.fetchUsers()
        }
        .padding()
        .onAppear {
            vm.fetchUsers()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GithubView(vm: GithubUsersViewModel(network: NetworkManager(session: URLSession.shared, baseURl: "")))
    }
}
