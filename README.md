# RPGEngine-iOS v0.5.1

## GitHub Actions build

This version is prepared for **GitHub Actions + macOS runner**, so a Mac is not required locally.

The workflow:

1. checks out the repository
2. selects Xcode 16.4
3. installs XcodeGen
4. generates `RPGEngine.xcodeproj`
5. compiles the iOS target for iOS 16+
6. creates an unsigned IPA artifact
7. optionally signs and exports a personal IPA when signing secrets are configured

### Build without a Mac

Create a GitHub repository and upload this project. Then:

`Actions → iOS Build → Run workflow`

The artifact will be:

`RPGEngine-iOS-v0.5.1-unsigned`

### Important

An unsigned IPA is useful for build verification, but it is not directly installable on a normal iPhone.

For a personally signed IPA, configure these repository Actions secrets:

- `IOS_CERTIFICATE_BASE64`
- `IOS_CERTIFICATE_PASSWORD`
- `IOS_KEYCHAIN_PASSWORD`
- `IOS_PROVISION_PROFILE_BASE64`
- `IOS_TEAM_ID`
- `IOS_CODE_SIGN_IDENTITY`
- `IOS_PROVISIONING_PROFILE_NAME`
- `IOS_EXPORT_OPTIONS_PLIST_BASE64`

Use a provisioning profile and certificate that belong to your own Apple development/signing setup. Do not commit `.p12`, `.mobileprovision`, or private keys.

## iOS deployment target

`iOS 16.0`

## v0.5.1 scope

This release is a **buildable iOS host / Runtime Manager shell**. It does not claim that Ruby 1.9.x + RGSS3 is already fully executing. The actual arm64 Ruby/RGSS3 runtime remains the next native integration milestone.

## Runtime downloads

The runtime package manager verifies SHA-256 before accepting a package. Production runtime packages should additionally use a signed manifest and an audited archive extractor.

The app does not dynamically load arbitrary downloaded dylibs/frameworks. Runtime downloads are therefore treated as package data/resources and passed through the native runtime interfaces that are already part of the app.

## Project generation

The repository intentionally uses `project.yml` + XcodeGen rather than committing a large hand-edited `.pbxproj`. GitHub Actions generates the Xcode project on the macOS runner.
