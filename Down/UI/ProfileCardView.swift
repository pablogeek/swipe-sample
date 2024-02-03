//
//  ProfileCardView.swift
//  Down
//
//  Created by Pablo Martinez Piles on 3/2/24.
//

import SwiftUI

struct ProfileCardView: View {
    @ObservedObject var profile: UserProfile
    @Binding var swipingDirection: ZappingViewModel.SwipeDirection?
    var onTraslation: (CGSize) -> Void
    var onAction: (ZappingViewModel.SwipeDirection) -> Void
    @State private var draggedOffset = CGSize.zero

    var body: some View {
        GeometryReader { geometry in
            AsyncImage(url: URL(string: profile.profilePicUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(alignment: .center)
                    .frame(maxWidth: geometry.size.width, maxHeight: .infinity)
                    .clipped()
                    .cornerRadius(Constants.cornerRadius)
                    .overlay {
                        overlayGradient
                    }
            } placeholder: {
                Color.gray
            }
            .offset(y: self.draggedOffset.height)
            .clipped()
            .gesture(DragGesture(minimumDistance: 20)
                .onChanged { gesture in
                    onTraslation(gesture.translation)
                    self.draggedOffset = gesture.translation
                }
                .onEnded { _ in
                    if abs(self.draggedOffset.height) > Constants.thresholdSwipeDistance {
                        let direction: ZappingViewModel.SwipeDirection = self.draggedOffset.height < 0 ? .up : .down
                        onAction(direction)
                    }
                    self.draggedOffset = .zero
                }
            )
            .animation(.spring(), value: draggedOffset)
            .overlay {
                overlayLabel
            }
            .allowsHitTesting(profile.state == .none)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .cornerRadius(Constants.cornerRadius)
        .shadow(radius: 5)
        .padding()
    }
    
    var overlayGradient: some View {
        GeometryReader { geometry in
            if let swipingDirection = swipingDirection {
                // Gradient overlay
                OverlayGradient(direction: swipingDirection)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .cornerRadius(Constants.cornerRadius)
                    .opacity(opacityForSwipe(draggedOffset.height, geometry: geometry))
                    .zIndex(2)
            } else {
                switch profile.state {
                case .hookup:
                    OverlayGradient(direction: .up)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .cornerRadius(Constants.cornerRadius)
                        .zIndex(2)
                case .date:
                    OverlayGradient(direction: .down)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .cornerRadius(Constants.cornerRadius)
                        .zIndex(2)
                case .none:
                    EmptyView()
                }
            }
        }
    }
    
    var overlayLabel: some View {
        GeometryReader { geometry in
            ZStack {
                if let swipingDirection = swipingDirection {
                    // Label overlay
                    OverlayLabel(direction: swipingDirection)
                        .opacity(opacityForSwipe(draggedOffset.height, geometry: geometry))
                } else {
                    switch profile.state {
                    case .hookup:
                        OverlayLabel(direction: .up)
                    case .date:
                        OverlayLabel(direction: .down)
                    case .none:
                        EmptyView()
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Text("\(profile.name) • \(profile.age)")
                            .font(.title)
                            .foregroundColor(Color.white)
                            .bold()
                        Spacer()
                    }
                    .padding()
                    buttons
                        .padding()
                }
            }
            .zIndex(1)
        }
    }
    
    private func opacityForSwipe(_ swipeDistance: CGFloat, geometry: GeometryProxy) -> Double {
        let threshold: CGFloat = Constants.thresholdSwipeDistance
        let adjustedDistance = min(threshold, abs(swipeDistance))
        return Double(adjustedDistance / threshold)
    }
    
    var buttons: some View {
        HStack {
            Spacer()
            Button(action: {
                onAction(.up)
            }) {
                ZappingButton(title: "Date", iconName: "heart.fill")
            }
            Spacer()
            Button(action: {
            
            }) {
                ZappingButton(title: nil, iconName: "message.fill")
            }
            Spacer()
            Button(action: {
                onAction(.down)
            }) {
                ZappingButton(title: "Hookup", iconName: "flame.fill")
            }
            Spacer()
        }
    }
}

extension ProfileCardView {
    enum Constants {
        static let cornerRadius: CGFloat = 15
        static let thresholdSwipeDistance: CGFloat = 100
    }
}

struct OverlayGradient: View {
    let direction: ZappingViewModel.SwipeDirection
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: direction == .up ? [.clear, .blue] : [.clear, .red]),
            startPoint: direction == .up ? .top : .bottom,
            endPoint: direction == .up ? .bottom : .top
        )
    }
}

struct OverlayLabel: View {
    let direction: ZappingViewModel.SwipeDirection
    var body: some View {
        HStack {
            Image(systemName: direction == .up ? "flame.fill" : "flame.fill")
                .renderingMode(.template)
                .foregroundColor(Color.white)
            Text(direction == .up ? "Date": "Hookup")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color.white)
                .textCase(.uppercase)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
    }
}

#Preview {
    ProfileCardView(profile: UserProfile(userId: 1, name: "Pablo", age: 35, profilePicUrl: "", loc: "Spain", aboutMe: "Pablo"), swipingDirection: .constant(.up)) { _ in } onAction: { _ in }
}
