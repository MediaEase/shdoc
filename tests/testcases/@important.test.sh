#!/bin/bash

tests:put input <<EOF
# @name Project Name
# @brief Brief

# @description func_with_important
# Function with an important message.
# @important This is an important message.
func_with_important() {
}
EOF

tests:put expected <<EOF
# Project Name

Brief

## Overview

func_with_important
Function with an important message.

## Index

* [func_with_important](#funcwithimportant)

### func_with_important

func_with_important
Function with an important message.

> [!IMPORTANT]
> This is an important message.

EOF

assert
