<p align="center">
    <img src="https://github.com/pkluz/Indicate/blob/master/Example/Resources/demo.gif?raw=true" alt="Demo" />
</p>

<p align="center">
    <img src="https://img.shields.io/badge/iOS-12+-blue.svg" />
    <img src="https://img.shields.io/badge/Swift-5.0+-brightgreen.svg" />
    <a href="https://twitter.com/pkluz">
        <img src="https://img.shields.io/badge/Contact-@pkluz-lightgrey.svg?style=flat" alt="Twitter: @pkluz" />
    </a>
</p>

Interactive notification pop-over (aka "Toast) modeled after the iOS AirPods and Apple Pencil indicator.

## Installation

> The recommended way is to use CocoaPods. 

### CocoaPods

To install Indicate for Swift 5.0+, include the following in your Podfile

```ruby
pod 'IndicateKit', '~> 1.0.3'
```

### Carthage

To integrate Indicate into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "pkluz/Indicate" ~> 1.0.3
```

Run `carthage update` to build the framework and drag the resulting `Indicate.framework` into your Xcode project.

## How To

After adding the framework to your project, you need to import the module
```swift
import Indicate
```

Afterwards presenting an indicator is a three-step process.

1. Define the content.
2. Configure the presentation.
3. Present the indicator on any view.

Here's an example:

```swift
// STEP 1: Define the content
let content = Indicate.Content(title: .init(value: "Hello World", alignment: .natural),
                               subtitle: .init(value: "Indicate", alignment: .natural),
                               attachment: .emoji(.init(value: "🌼", alignment: .natural)))

// STEP 2: Configure the presentation
let config = Indicate.Configuration()
    .with(tap: { controller in
        controller.dismiss()
    })
        
// STEP 3: Present the indicator
let controller = Indicate.PresentationController(content: content, configuration: config)
controller.present(in: view)
```

## LICENSE

The MIT License (MIT)

Copyright (c) 2021 Philip Kluz (philip.kluz@gmail.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
