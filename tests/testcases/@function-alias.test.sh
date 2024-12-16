#!/bin/bash

tests:put input <<EOF
# @name Alias Example
# @description Demonstrates the alias annotation.

# @description Function to greet a user.
# @alias greet
say-hello() {
    echo "Hello!"
}

# @description Another function without alias
# @noargs
do-nothing() {
    :
}
EOF

tests:put expected <<EOF
# Alias Example

## Overview

Demonstrates the alias annotation.

## Index

* [greet](#greet)
* [do-nothing](#do-nothing)

### greet

Function to greet a user.

### do-nothing

Another function without alias

_Function has no arguments._
EOF

assert
