#!/bin/bash

tests:put input <<EOF
# @file example/filename.sh
# @version 1.2.3
# @description Test file for version_in_name functionality.

# @description Example function.
example_function() {
    echo "This is an example function."
}
EOF

tests:put Shdocfile <<EOF
version_in_name=true
EOF

tests:put expected <<EOF
# example/filename.sh (v1.2.3)

## Overview

Test file for version_in_name functionality.

## Index

* [example_function](#examplefunction)

### example_function

Example function.
EOF

tests:eval "./shdoc input > actual_output"
tests:assert-no-diff expected actual_output

tests:put Shdocfile <<EOF
version_in_name=false
EOF

tests:put expected <<EOF
# example/filename.sh

## Overview

Test file for version_in_name functionality.

## Index

* [example_function](#examplefunction)

### example_function

Example function.
EOF

tests:eval "./shdoc input > actual_output"
tests:assert-no-diff expected actual_output
