import Foundation
import Quick
import Nimble

@testable import Szimpla

class SzimplaSpec: QuickSpec {
    override func spec() {
        
        var subject: Szimpla!
        var requestFetcher: MockRequestFetcher!
        
        beforeEach {
            requestFetcher = MockRequestFetcher()
            subject = Szimpla(requestsToSnapshotAdapter: RequestsToSnapshotAdapter(), snapshotValidator: DefaultValidator(), requestFetcher: requestFetcher, snapshotFetcher: SnapshotFetcher.withPath)
        }
        
        afterEach {
            try! subject.record(path: "test")
        }
        
        describe("-start") {
            it("should tear up the request fetcher") {
                try! subject.start()
                expect(requestFetcher.tearUpCalled).to(beTrue())
            }
        }
        
        describe("-record:name:filter") {
            it("should tear down the request fetcher") {
                try! subject.start()
                try! subject.record(path: "test")
                expect(requestFetcher.tearDownCalled).to(beTrue())
            }
        }
    }
}


// MARK: - Mocks

private class MockRequestFetcher: RequestFetcher {
    var tearUpCalled: Bool = false
    var tearDownCalled: Bool = false
    override func tearUp() throws {
        self.tearUpCalled = true
        try super.tearUp()
    }
    override func tearDown(filter filter: RequestFilter!) -> [NSURLRequest] {
        self.tearDownCalled = true
        return super.tearDown()
    }
}