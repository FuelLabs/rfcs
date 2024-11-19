# Building and Linting

CI should enforce the following criteria across all Rust projects:

* Pull requests should be blocked if the build action fails.
* The build action should deny all warnings.
* Code formatting should pass `cargo fmt --all -- --check`
* Code must pass `cargo clippy`

## Clippy Lints

While clippy is a powerful tool, some lints may be incorrect or worse than the actual
implementation. Each project should have its own `clippy.toml` file to maintain
the set of lints are needed. Once the core sets of lints are configured for a
project, `#[allow(...)]` exceptions should be placed nearest to the lint 
failure rather than globally at the `clippy.toml` file. An example of this may
be when a Rust upgrade causes codegen from a macro to fail the updated lints.

## Standard Lints

These lints are considered standard for every crate in the Fuel ecosystem.

```rust
#![warn(missing_docs)]
#![forbid(unsafe_code)]
```

## Unused Dependencies

Each repo should have CI rules to prevent unused dependencies.
This can be automated using the tool [cargo-udeps](https://github.com/est31/cargo-udeps).
