#!/bin/bash

tests:put input <<EOF
# @name Project Name
# @brief Brief

# @description func_with_caution
# Function with a caution message.
# @caution This is a caution message.
func_with_caution() {
}
EOF

tests:put expected <<EOF
# Project Name

Brief

## Overview

func_with_caution
Function with a caution message.

## Index

* [func_with_caution](#funcwithcaution)

### func_with_caution

func_with_caution
Function with a caution message.

> [!CAUTION]
> This is a caution message.

EOF

assert
