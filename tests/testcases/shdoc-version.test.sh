#!/bin/bash

# Prepare input and expected outputs
expected_version_regex="^[0-9]+\.[0-9]+\.[0-9]+$"

# Run shdoc version command
tests:eval ./shdoc v

# Assert that stdout matches the semantic version regex
tests:assert-re stdout "$expected_version_regex"
