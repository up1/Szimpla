# Szimpla

[![CI Status](http://img.shields.io/travis/pepibumur/Szimpla.svg?style=flat)](https://travis-ci.org/pepibumur/Szimpla)
[![Version](https://img.shields.io/cocoapods/v/Szimpla.svg?style=flat)](http://cocoapods.org/pods/Szimpla)
[![License](https://img.shields.io/cocoapods/l/Szimpla.svg?style=flat)](http://cocoapods.org/pods/Szimpla)
[![Platform](https://img.shields.io/cocoapods/p/Szimpla.svg?style=flat)](http://cocoapods.org/pods/Szimpla)

![logo](https://github.com/pepibumur/Szimpla/blob/master/Assets/Logo.png?raw=true)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## :white_check_mark: TODO List
- [ ] Implement validator
- [ ] Support folders for snapshots
- [ ] Test missing components (Nimble Expectation, Szimpla Assertion, SnapshotFetcher)
- [ ] Add a example app

## Features backlog
- Support custom validators.
- Implement new filters for requests based on headers, parameters, ....

## Requirements

## Installation

Szimpla is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Szimpla"
pod "Szimpla/Nimbe" # If you're interested in Nimble matchers
```

## How to use it
### Adding a reference to the snapshots folder
Szimpla saves the snapshots in a folder that you specify using an environment variable, `SZ_REFERENCE_DIR`. Open your project scheme, and in the **Run** section, add the variable to the *Environment Variables* section. The value should be the folder where you would like your network snapshots to be saved.

|Name|Value|
|:---|:----|
|`SZ_REFERENCE_DIR`|`$(SOURCE_ROOT)/$(PROJECT_NAME)Tests/Szimpla`|

### Recording requests
The first step when testing Network requests is recording the requests in a `.json` file. This file will be used for validating future tests executions. Using Szimpla to get these requests saved is very simple:

```swift
import Szimpla

// Navigate to the point where you would like to start testing.
Szimpla.instance.start() // Starts recording
// Do all your UI tests steps
Szimpla.instance.record(name: "user_share_tracking") // Saves the recorded requests
```
Requests will be saved under `${SZ_REFERENCE_DIR}/user_share_tracking.json`

### Adapting requests

**Szimpla validates:**
- If the the same number of requests are sent
- If each request matches the definition in the json file. That is, the fields are present and match the value.

Since most of the time values might be relative, Szimpla support using regular expressions for your `.json` fields. Once you have your `.json` file with the requests recorded:

1. Remove these fields you are not interested in checking.
2. Update the ones that are dynamic a regular expression instead.

### Validating requests

The validation process is similar to the recording one. The only difference in this case is the method used to complete:

```swift
import Szimpla

// Navigate to the point where you would like to start testing.
Szimpla.instance.start() // Starts recording
// Do all your UI tests steps
Szimpla.instance.validate(name: "user_share_tracking") // Saves the recorded requests
```

It the validation fails, it'll assert using `XCTAssert` printing the validation error. :tada:

## Nimble :heart: Szimpla

Szimpla also provides expectations for [Nimble](https://github.com/quick/nimble) if you want to use it with your unit tests. Here's an example of how Szimpla would be used in that case:

```swift
// Recording requests
expect {
  sendRequest1()
  sendRequest2()
}.to(recordRequests(name: "my_test_requests"))

// Matching requests
expect{
  sendRequest1()
  sendRequest2()
}.to(matchRequests(name: "my_test_requests"))
```

## Filters
Since you might not be interested in all the requests you can decide which ones using filters. Filters conform the protocol `RequestFilter` and it's public, thus, you can create your own filters. When requests are **recorded** or **matched** you can provide a filter to be used instead of recording all the requests.

Szimpla also provides some default filters that you can use:

- **URLRequestFilter:** Filters all these URLs that match the base URL.

## References
- ios-snapshot-testing: [Link](https://github.com/facebook/ios-snapshot-test-case)
- UI Testing in Xcode: [Link](https://developer.apple.com/videos/play/wwdc2015/406/)

## Author

Pedro Piñera Buendía, pepibumur@gmail.com

## License

Szimpla is available under the MIT license. See the LICENSE file for more info.
