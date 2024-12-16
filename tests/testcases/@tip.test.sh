#!/bin/bash

tests:put input <<EOF
# @name Project Name
# @brief Brief

# @description func_with_tip
# Function with a tip message.
# @tip This is a tip message.
func_with_tip() {
}
EOF

tests:put expected <<EOF
# Project Name

Brief

## Overview

func_with_tip
Function with a tip message.

## Index

* [func_with_tip](#funcwithtip)

### func_with_tip

func_with_tip
Function with a tip message.

> [!TIP]
> This is a tip message.

EOF

assert
