//
//  ContentView.swift
//  Down
//
//  Created by Pablo Martinez Piles on 2/2/24.
//

import SwiftUI

struct ZappingView: View {
    @StateObject var viewModel = ZappingViewModel(useCase: UserProfileUseCase(repository: UserRepositoryImpl()))
    @State private var currentIndex = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Header
                HeaderView()
                //Tabview with all profile cards
                tabView
            }
        }
        .task {
            // Load profiles when view is loaded
            await viewModel.loadProfiles()
        }
    }
    
    var tabView: some View {
        TabView(selection: $viewModel.currentIndex) {
            ForEach(viewModel.profiles.indices, id: \.self) { index in
                let profile = viewModel.profiles[index]
                ProfileCardView(profile: profile, swipingDirection: $viewModel.swippingDirection) { translation in
                    viewModel.onChangedSwipe(translation: translation)
                } onAction: { direction in
                    Task {
                        await viewModel.handleAction(direction: direction, for: profile)
                    }
                }
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .animation(.easeInOut, value: viewModel.currentIndex)
        .transition(.slide)
        .onChange(of: viewModel.currentIndex) {
            withAnimation {
                viewModel.handleSwipe(index: viewModel.currentIndex)
            }
        }
    }
}

#Preview {
    ZappingView()
}


