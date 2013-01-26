#!/bin/bash

testSimpleCorrectUndistracted() {
  assertEqual "$(../pdftitle samples/001.pdf)" "The Ecology of West Nile Virus in South Africa and the Occurrence of Outbreaks in Humans"
}

source bashunit.bash
