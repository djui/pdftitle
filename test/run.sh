#!/bin/bash

BASEDIR="$(dirname $0)/.."

cd "$BASEDIR"

########################################################################
# Argument tests
########################################################################

testPositiveArgumentsHelp() {
    assertReturn "$(./pdftitle -h)" 0
    assertReturn "$(./pdftitle --help)" 0
}

testPositiveArgumentsVersion() {
    assertReturn "$(./pdftitle -v 2> /dev/null)" 0
    assertReturn "$(./pdftitle --version 2> /dev/null)" 0
    assertEqual "$(./pdftitle -v 2>&1)" "pdftitle 1.3"
    assertEqual "$(./pdftitle --version 2>&1)" "pdftitle 1.3"
}

########################################################################
# Return value tests
########################################################################

testNegativeNotFound() {
    assertEqual "$(./pdftitle ./test/samples/026.pdf 2>&1)" \
        "Error: No title found"
    assertReturn "$(./pdftitle ./test/samples/026.pdf 2> /dev/null)" 1
}

testNegativeArgumentsNoFile() {
    assertReturn "$(./pdftitle 2> /dev/null)" 2
}

testNegativeArgumentsUnknown() {
    assertReturn "$(./pdftitle --foo foobar 2> /dev/null)" 2
}

testNegativeArgumentsInvalid() {
    assertReturn "$(./pdftitle -t -1 foobar 2> /dev/null)" 2
    assertReturn "$(./pdftitle --top -1 foobar 2> /dev/null)" 2
}

testNegativeFileNotFound() {
    assertReturn "$(./pdftitle foobar 2> /dev/null)" 3
    assertEqual "$(./pdftitle foobar 2>&1)" "Error: No such file"
}

testNegativePDFTOHTMLNotFound() {
    # Skip reason: Hard to simulate
    skip assertReturn "$(./pdftitle foobar 2> /dev/null)" 4
}

testNegativeCouldNotConvertPDFToXML() {
    assertReturn "$(./pdftitle ./test/samples/029.pdf 2> /dev/null)" 5
    assertEqual "$(./pdftitle ./test/samples/029.pdf 2>&1)" \
        "Error: Could not convert PDF to XML"
}

testNegativePasswordProtected() {
    assertReturn "$(./pdftitle ./test/samples/027.pdf 2> /dev/null)" 5
    assertEqual "$(./pdftitle ./test/samples/027.pdf 2>&1)" \
        "Error: Could not convert PDF to XML"
}

testNegativeCouldNotParseXML() {
    # Skip reason: Does not fail under lxml
    skip assertReturn "$(./pdftitle ./test/samples/025.pdf 2> /dev/null)" 6
    skip assertEqual "$(./pdftitle ./test/samples/025.pdf 2>&1)" \
        "Error: Could not parse XML"
}

testNegativeUnknownError() {
    # Skip reason: Hard to simulate
    skip assertReturn "$(./pdftitle foobar 2> /dev/null)" 8
}

########################################################################
# Misc tests
########################################################################

testSimpleCorrectUndistracted() {
    assertEqual "$(./pdftitle ./test/samples/001.pdf)" \
        "The Ecology of West Nile Virus in South Africa and the Occurrence of Outbreaks in Humans"
}

testSimpleMultiline() {
    assertEqual "$(./pdftitle ./test/samples/009.pdf)" \
        "The Ecology of West Nile Virus in South Africa and the Occurrence of Outbreaks in Humans"
}

testTwoColumns() {
    assertEqual "$(./pdftitle ./test/samples/002.pdf)" \
        "Outbreak of West Nile Virus Infection in Greece, 2010"
}

testNotHighestFont() {
    # Skip reason: Skips lines
    skip assertEqual "$(./pdftitle ./test/samples/011.pdf)" \
        "Genetic Differences Between Culex pipiens f\. molestus and Culex pipiens pipiens \(Diptera: Culicidae\) in New York"
}

testMixedFormatting() {
    # Skip reason: Skips lines
    skip assertEqual "$(./pdftitle ./test/samples/011.pdf)" \
        "Genetic Differences Between Culex pipiens f\. molestus and Culex pipiens pipiens \(Diptera: Culicidae\) in New York"
}

testSlightDifferentSizeForSameFont() {
    # Skip reason: Skips lines
    skip assertEqual "$(./pdftitle ./test/samples/019.pdf)" \
        "HpaII endonuclease distinguishes between two species in the Anopheles funestus group"
}

testHiddenText() {
    # Skip reason: Skips lines
    skip assertEqual "$(./pdftitle ./test/samples/023.pdf)" \
        "Phylogeny of fourteen Culex mosquito species, including the Culex pipiens complex, inferred from the internal transcribed spacers of ribosomal DNA"
}

testInvalidXML() {
    assertEqual "$(./pdftitle ./test/samples/024.pdf 2> /dev/null)" \
        "Spread of the West Nile virus vector Culex modestus and the potential malaria vector Anopheles hyrcanus in central Europe"
}

testCopyProtected() {
    assertEqual "$(./pdftitle ./test/samples/028.pdf)" \
        "Pogosta Disease: Clinical Observations During An Outbreak In The Province Of North Karelia, Finland"
}

########################################################################
# Filter tests
########################################################################

testFilterImageAbove() {
    skip assertEqual "$(./pdftitle ./test/samples/003.pdf)" \
        "A Comparison of Gravid and Under-House CO2-Baited CDC Light Traps for Mosquito Species of Public Health Importance in Houston, Texas"
}

testFilterNotLargestFound() {
    assertEqual "$(./pdftitle ./test/samples/005.pdf)" \
        "Asymmetric introgression between sympatric molestus and pipiens forms of Culex pipiens \(Diptera: Culicidae\) in the Comporta region, Portugal"
}

testFilterTooShort() {
    assertEqual "$(./pdftitle ./test/samples/006.pdf)" \
        "West Nile Fever in Czechland"
}

testFilterTooLong() {
    assertEqual "$(./pdftitle ./test/samples/020.pdf)" \
        "A study of mosquito fauna \(Diptera: Culicidae\) and the phenology of the species recorded in Wilanów \(Warsaw, Poland\)"
}

testFilterVertical() {
    assertEqual "$(./pdftitle ./test/samples/031.pdf)" \
        "Stratified B-trees and versioning dictionaries"
}

testFilterTooFarDistanceWithEqualFont() {
    assertEqual "$(./pdftitle ./test/samples/016.pdf)" \
        "Mosquito species distribution in mainland Portugal 2005-2008"
}

testFilterOnLowerHalfOfFirstPage() {
    assertEqual "$(./pdftitle ./test/samples/021.pdf)" \
        "Scandinavian Journal of Rheumatology"
}

testFilterInitialCapital() {
    assertEqual "$(./pdftitle ./test/samples/022.pdf)" \
        "Syndromic Surveillance in The Netherlands for the Early Detection of West Nile Virus Epidemics"
}

########################################################################
# Formatter tests
########################################################################

testFormatUpperCase() {
    assertEqual "$(./pdftitle ./test/samples/004.pdf)" \
        "Influence Of Landscape Structure On Mosquitoes \(Diptera: Culicidae\) And Dytiscids \(Coleoptera: Dytiscidae\) At Five Spatial Scales In Swedish Wetlands"
}

testFormatWeirdCase() {
    assertEqual "$(./pdftitle ./test/samples/030.pdf)" \
        "Atomic Broadcast: A Fault-Tolerant Token Based Algorithm And Performance Evaluations"
}

testFormatSpaceCase() {
    # Skip reason: Word boundaries swallowed
    skip assertEqual "$(./pdftitle ./test/samples/033.pdf)" \
        "A High-Level Framework for Distributed Processing of Large-Scale Graphs"
}

testFormatUpperCaseMixedFormatting() {
    assertEqual "$(./pdftitle ./test/samples/008.pdf)" \
        "Evaluation Of Six Mosquito Traps For Collection Of Aedes Albopictus And Associated Mosquito Species In A Suburban Setting In North Central Florida"
}

testFormatSubscript() {
    # Skip reason: Chemical expression incorrectly handled
    skip assertEqual "$(./pdftitle ./test/samples/010.pdf)" \
        "Validation Of CO2 Trap Data In Three European Regions"
}

testFormatLinebreakDash() {
    assertEqual "$(./pdftitle ./test/samples/012.pdf)" \
        "The prevalence of antibodies against Sindbis-related \(Pogosta\) virus in different parts of Finland"
}

testFormatPeriod() {
    assertEqual "$(./pdftitle ./test/samples/031.pdf)" \
        "Stratified B-trees and versioning dictionaries"
}

testFormatAsterik() {
    assertEqual "$(./pdftitle ./test/samples/032.pdf)" \
        "Ecophysiological and morphological variations in mosquitoes of the Culex pipiens complex \(Diptera: Culicidae\)"
}

testFormatLigatures() {
    # Skip reason: pdftohtml produces gibberish
    skip assertEqual "$(./pdftitle ./test/samples/017.pdf)" \
        "Mitochondrial DNA cytochrome oxidase I gene: potential for distinction between immature stages of some forensically important fly species \(Diptera\) in western Australia"
}

testFormatQuotes() {
    # Skip reason: Quotes are not correctly detected
    skip assertEqual "$(./pdftitle ./test/samples/013.pdf)" \
        "“Coi”-like Sequences Are Becoming Problematic In Molecular Systematic And Dna Barcoding Studies"
}

testFormatMultipleSpaces() {
    # Skip reason: No good pdf found to test the feature
    skip assertEqual "$(./pdftitle ./test/samples/0XX.pdf 2> /dev/null)" ""
}

testFormatFormattingSwitchOnNewLine() {
    # Skip reason: Skips a word
    skip assertEqual "$(./pdftitle ./test/samples/014.pdf)" \
        "Rapid Assay To Identify The Two Genetic Forms Of Culex \(Culex\) Pipiens L\. \(Diptera: Culicidae\) And Hybrid Populations"
}

testFormatTwoCharacterEncoding() {
    skip assertEqual "$(./pdftitle ./test/samples/018.pdf)" \
        "Serological Examination of Songbirds \(Passeriformes\) for Mosquito-Borne Viruses Sindbis, Ťahynǎ, and Batai in a South Moravian Wetland \(Czech Republic\)"
}

########################################################################

source "./test/bashunit.bash"
