#!/bin/bash

tests:put input <<EOF
# @name Project Name
# @brief Brief

# @description func_with_warning
# Function with a warning message.
# @warning This is a warning message.
func_with_warning() {
}
EOF

tests:put expected <<EOF
# Project Name

Brief

## Overview

func_with_warning
Function with a warning message.

## Index

* [func_with_warning](#funcwithwarning)

### func_with_warning

func_with_warning
Function with a warning message.

> [!WARNING]
> This is a warning message.

EOF

assert
