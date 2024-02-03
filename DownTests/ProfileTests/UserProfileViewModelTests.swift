//
//  UserProfileViewModelTests.swift
//  DownTests
//
//  Created by Pablo Martinez Piles on 2/2/24.
//

import XCTest
@testable import Down

@MainActor class ZappingViewModelTests: XCTestCase {
    var mockRepository: MockUserRepository!
    var viewModel: ZappingViewModel!

    override func setUpWithError() throws {
        mockRepository = MockUserRepository()
        viewModel = ZappingViewModel(useCase: UserProfileUseCase(repository: mockRepository))
    }

    override func tearDownWithError() throws {
        mockRepository = nil
        viewModel = nil
    }

    func testLoadProfilesSuccess() async throws {
        await viewModel.loadProfiles()
        XCTAssertTrue(mockRepository.fetchUserProfilesCalled, "fetchUserProfiles was not called")
        XCTAssertTrue(viewModel.profiles.count > 0, "Should have loaded 1 profile")
    }

    func testLoadProfilesFailure() async throws {
        mockRepository.shouldReturnError = true
        await viewModel.loadProfiles()
        XCTAssert(viewModel.profiles.count == 0)
    }

    func testHandleAction() async throws {
        // Load initial profiles
        await viewModel.loadProfiles()
        XCTAssertEqual(viewModel.currentIndex, 0)

        // Swipe on the first profile
        let profileToSwipe = viewModel.profiles.first!
        await viewModel.handleAction(direction: .up, for: profileToSwipe)

        XCTAssertEqual(viewModel.currentIndex, 1)
    }
}
