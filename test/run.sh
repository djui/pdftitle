#!/bin/bash

########################################################################
# Argument tests
########################################################################


testPositiveArgumentsHelp() {
  assertReturn "$(../pdftitle -h)" 0
  assertReturn "$(../pdftitle --help)" 0
}

testPositiveArgumentsVersion() {
  assertReturn "$(../pdftitle -v)" 0
  assertReturn "$(../pdftitle --version)" 0
  assertEqual "$(../pdftitle -v)" "1.1"
  assertEqual "$(../pdftitle --version)" "1.1"
}

########################################################################
# Return value tests
########################################################################

testNegativeNotFound() {
  assertEqual "$(../pdftitle samples/026.pdf 2>&1)" "No title found"
  assertReturn "$(../pdftitle samples/026.pdf 2> /dev/null)" 1
}

testNegativeArgumentsNoFile() {
  assertReturn "$(../pdftitle 2> /dev/null)" 2
}

testNegativeArgumentsUnknown() {
  assertReturn "$(../pdftitle --foo foobar 2> /dev/null)" 2
}

testNegativeArgumentsInvalid() {
  assertReturn "$(../pdftitle -t -1 foobar 2> /dev/null)" 2
  assertReturn "$(../pdftitle --top -1 foobar 2> /dev/null)" 2
}

testNegativeFileNotFound() {
  assertReturn "$(../pdftitle foobar 2> /dev/null)" 3
  assertEqual "$(../pdftitle foobar 2>&1)" "No such file"
}

testNegativePDFTOHTMLNotFound() {
  skip assertReturn "$(../pdftitle foobar 2> /dev/null)" 4
}

testNegativeCouldNotConvertPDFToXML() {
  assertReturn "$(../pdftitle samples/029.pdf 2> /dev/null)" 5
  assertEqual "$(../pdftitle samples/029.pdf 2>&1)" "Could not convert PDF to XML"
}

testNegativePasswordProtected() {
  assertReturn "$(../pdftitle samples/027.pdf 2> /dev/null)" 5
  assertEqual "$(../pdftitle samples/027.pdf 2>&1)" "Could not convert PDF to XML"
}

testNegativeCouldNotParseXML() {
  assertReturn "$(../pdftitle samples/025.pdf 2> /dev/null)" 6
  assertEqual "$(../pdftitle samples/025.pdf 2>&1)" "Could not parse XML"
}

testNegativeUnknownError() {
  skip assertReturn "$(../pdftitle foobar 2> /dev/null)" 8
}

########################################################################
# Misc tests
########################################################################

testSimpleCorrectUndistracted() {
  assertEqual "$(../pdftitle samples/001.pdf)" "The Ecology of West Nile Virus in South Africa and the Occurrence of Outbreaks in Humans"
}

testSimpleMultiline() {
  assertEqual "$(../pdftitle samples/009.pdf)" "The Ecology of West Nile Virus in South Africa and the Occurrence of Outbreaks in Humans"
}

testTwoColumns() {
  assertEqual "$(../pdftitle samples/002.pdf)" "Outbreak of West Nile Virus Infection in Greece, 2010"
}

testNotHighestFont() {
  assertEqual "$(../pdftitle samples/011.pdf)" "Genetic Differences Between Culex pipiens f\. molestus and Culex pipiens pipiens \(Diptera: Culicidae\) in New York"
}

testMixedFormatting() {
  assertEqual "$(../pdftitle samples/011.pdf)" "Genetic Differences Between Culex pipiens f\. molestus and Culex pipiens pipiens \(Diptera: Culicidae\) in New York"
}

testSlightDifferentSizeForSameFont() {
  assertEqual "$(../pdftitle samples/019.pdf)" "HpaII endonuclease distinguishes between two species in the Anopheles funestus group"
}

testHiddenText() {
  assertEqual "$(../pdftitle samples/023.pdf)" "Phylogeny of fourteen Culex mosquito species, including the Culex pipiens complex, inferred from the internal transcribed spacers of ribosomal DNA"
}

testInvalidXML() {
  assertEqual "$(../pdftitle samples/024.pdf 2> /dev/null)" "Spread of the West Nile virus vector Culex modestus and the potential malaria vector Anopheles hyrcanus in central Europe"
}

testCopyProtected() {
  assertEqual "$(../pdftitle samples/028.pdf)" "Pogosta Disease: Clinical Observations During An Outbreak In The Province Of North Karelia, Finland"
}

########################################################################
# Filter tests
########################################################################

testFilterImageAbove() {
  skip assertEqual "$(../pdftitle samples/003.pdf)" "A Comparison of Gravid and Under-House CO2-Baited CDC Light Traps for Mosquito Species of Public Health Importance in Houston, Texas"
}

testFilterNotLargestFound() {
  assertEqual "$(../pdftitle samples/005.pdf)" "Asymmetric introgression between sympatric molestus and pipiens forms of Culex pipiens \(Diptera: Culicidae\) in the Comporta region, Portugal"
}

testFilterTooShort() {
  assertEqual "$(../pdftitle samples/006.pdf)" "West Nile Fever in Czechland"
}

testFilterTooLong() {
  assertEqual "$(../pdftitle samples/020.pdf)" "A study of mosquito fauna \(Diptera: Culicidae\) and the phenology of the species recorded in Wilanów \(Warsaw, Poland\)"
}

testFilterVertical() {
  assertEqual "$(../pdftitle samples/031.pdf)" "Stratified B-trees and versioning dictionaries"
}

testFilterTooFarDistanceWithEqualFont() {
  assertEqual "$(../pdftitle samples/016.pdf)" "Mosquito species distribution in mainland Portugal 2005-2008"
}

testFilterOnLowerHalfOfFirstPage() {
  assertEqual "$(../pdftitle samples/021.pdf)" "Scandinavian Journal of Rheumatology"
}

testFilterInitialCapital() {
  assertEqual "$(../pdftitle samples/022.pdf)" "Syndromic Surveillance in The Netherlands for the Early Detection of West Nile Virus Epidemics"
}

########################################################################
# Formatter tests
########################################################################

testFormatCapitalized() {
  assertEqual "$(../pdftitle samples/004.pdf)" "Influence Of Landscape Structure On Mosquitoes \(Diptera: Culicidae\) And Dytiscids \(Coleoptera: Dytiscidae\) At Five Spatial Scales In Swedish Wetlands"
}

testFormatCapitalizedMixedFormatting() {
  assertEqual "$(../pdftitle samples/008.pdf)" "Evaluation Of Six Mosquito Traps For Collection Of Aedes Albopictus And Associated Mosquito Species In A Suburban Setting In North Central Florida"
}

testFormatSubscript() {
  skip assertEqual "$(../pdftitle samples/010.pdf)" "Validation Of CO2 Trap Data In Three European Regions"
}

testFormatQuotes() {
  skip assertEqual "$(../pdftitle samples/013.pdf)" "“Coi”-like Sequences Are Becoming Problematic In Molecular Systematic And Dna Barcoding Studies"
}

testFormatTrailingDash() {
  assertEqual "$(../pdftitle samples/012.pdf)" "The prevalence of antibodies against Sindbis-related \(Pogosta\) virus in different parts of Finland"
}

testFormatFormattingSwitchOnNewLine() {
  assertEqual "$(../pdftitle samples/014.pdf)" "Rapid Assay To Identify The Two Genetic Forms Of Culex \(Culex\) Pipiens L\. \(Diptera: Culicidae\) And Hybrid Populations"
}

testFormatLigatures() {
  assertEqual "$(../pdftitle samples/017.pdf)" "Mitochondrial DNA cytochrome oxidase I gene: potential for distinction between immature stages of some forensically important fly species \(Diptera\) in western Australia"
}

testFormatTwoCharacterEncoding() {
  skip assertEqual "$(../pdftitle samples/018.pdf)" "Serological Examination of Songbirds \(Passeriformes\) for Mosquito-Borne Viruses Sindbis, Ťahynǎ, and Batai in a South Moravian Wetland \(Czech Republic\)"
}

testFormatWeirdCase() {
  assertEqual "$(../pdftitle samples/030.pdf)" "Atomic Broadcast: A Fault-Tolerant Token Based Algorithm And Performance Evaluations"
}

########################################################################

source bashunit.bash
