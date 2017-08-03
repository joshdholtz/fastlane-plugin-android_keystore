# android_keystore plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-android_keystore)

## Getting Started

This project is a [fastlane](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-android_keystore`, add it to your project by running:

```bash
fastlane add_plugin android_keystore
```

## About android_keystore

Generate an Android keystore file. The default directory where the keystore will be placed is `.android_signing` but this can be changed in the action arguments.

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

### With environment variables

```sh
ANDROID_KEYSTORE_KEYSTORE_NAME = fastlanescreencast.keystore
ANDROID_KEYSTORE_ALIAS_NAME = fastlanescreencast
ANDROID_KEYSTORE_PASSWORD = supersecret
ANDROID_KEYSTORE_KEY_PASSWORD = supersecret
ANDROID_KEYSTORE_FULL_NAME = Fastlane Screencast
ANDROID_KEYSTORE_ORG = fastcast
ANDROID_KEYSTORE_ORG_UNIT = fastcast
ANDROID_KEYSTORE_CITY_LOCALITY = Chicago
ANDROID_KEYSTORE_STATE_PROVINCE = IL
ANDROID_KEYSTORE_COUNTRY = US
```

```rb
android_keystore
```

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using `fastlane` Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About `fastlane`

`fastlane` is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
