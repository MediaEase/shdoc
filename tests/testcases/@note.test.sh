#!/bin/bash

tests:put input <<EOF
# @name Project Name
# @brief Brief

# @description func_with_note
# Function with a note message.
# @note This is a note message.
func_with_note() {
}
EOF

tests:put expected <<EOF
# Project Name

Brief

## Overview

func_with_note
Function with a note message.

## Index

* [func_with_note](#funcwithnote)

### func_with_note

func_with_note
Function with a note message.

> [!NOTE]
> This is a note message.

EOF

assert
