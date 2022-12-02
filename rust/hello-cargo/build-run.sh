#! /bin/zsh

cargo build
target/debug/hello-cargo


<< NOT_RUN

cargo run  # cargo build + ./target/debug/hhelo_cargo
cargo check  # check if compilable
cargo build --release  # build for release

NOT_RUN
