Pod::Spec.new do |spec|
  spec.name                  = "IndicateKit"
  spec.module_name           = "Indicate"
  spec.version               = "1.0.3"
  spec.license               = { type: "MIT" }
  spec.homepage              = "https://github.com/pkluz/indicate"
  spec.authors               = { "Philip Kluz": "philip.kluz@gmail.com" }
  spec.summary               = "Notification pop-over (aka \"Toast\") modeled after the iOS AirPods and Apple Pencil indicator."
  spec.source                = { git: "https://github.com/pkluz/Indicate.git", tag: spec.version.to_s }
  spec.source_files          = "Indicate/**/*.{swift}"
  spec.resource_bundle       = { "IndicateKit": "Indicate/**/*.{xcassets}" }
  spec.swift_version         = "5.0"
  spec.ios.deployment_target = "12.0"
end
