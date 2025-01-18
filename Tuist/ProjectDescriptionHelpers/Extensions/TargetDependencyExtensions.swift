import ProjectDescription

public extension TargetDependency {
    static let composableArchitecture = Self.external(name: "ComposableArchitecture")
    static let snapshotTesting = Self.external(name: "SnapshotTesting")
}
