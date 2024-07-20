#!/bin/bash

tests:put input <<EOF
# @name Project Name
# @brief Brief

# @description func_with_alerts
# Function with multiple alerts.
# @note This is a note message.
# @tip This is a tip message.
# @important This is an important message.
# @warning This is a warning message.
# @caution This is a caution message.
func_with_alerts() {
}
EOF

tests:put expected <<EOF
# Project Name

Brief

## Overview

func_with_alerts
Function with multiple alerts.

## Index

* [func_with_alerts](#funcwithalerts)

### func_with_alerts

func_with_alerts
Function with multiple alerts.

> [!NOTE]
> This is a note message.

> [!TIP]
> This is a tip message.

> [!IMPORTANT]
> This is an important message.

> [!WARNING]
> This is a warning message.

> [!CAUTION]
> This is a caution message.

EOF

assert
