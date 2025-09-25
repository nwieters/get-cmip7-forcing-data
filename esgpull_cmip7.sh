#!/bin/bash
# 
# Retrieve CMIP7 forcing data using esgpull 
#
# See README.md for instructions on how to install esgpull etc. 
#
# IMPORTANT: Currently, this only works with if esgpull is set to search an index node
# To set this up: 
# esgpull config api.index_node esgf-node.ornl.gov/esgf-1-5-bridge
# See: https://github.com/ESGF/esgf-download/issues/101 
#
# Author: Joakim Kjellsson, September 2025
#

# Set the one you want to 1, others to 0
solar=0
ghg_conc=0
o3=0
amip=0

CMIP7_VERSION_PROJECT="input4MIPs"

CMIP7_VERSION_MIP_ERA="CMIP7"

# 
# Get solar forcing
# 

if [ "x${solar}" == "x1" ] ; then

    # Note: Due to a bug in esgpull, the source_id must have quotation marks. 
    # This means we must prevent bash from removing the "" from the string, hence the \"  
    # The following works for me at least. 
    CMIP7_VERSION_SOURCE_ID=\"SOLARIS-HEPPA-CMIP-4-6\"

    SEARCH_TAG="cmip7-${CMIP7_VERSION_SOURCE_ID}"

    # search and list data
    search_cmd="esgpull search project:${CMIP7_VERSION_PROJECT} mip_era:${CMIP7_VERSION_MIP_ERA} source_id:${CMIP7_VERSION_SOURCE_ID}" 
    echo $search_cmd
    $search_cmd

    # track data
    add_cmd="esgpull add --tag ${SEARCH_TAG} --track project:${CMIP7_VERSION_PROJECT} mip_era:${CMIP7_VERSION_MIP_ERA} source_id:${CMIP7_VERSION_SOURCE_ID}" 
    echo $add_cmd
    $add_cmd

    # if search has been done before, then update the search in case of updated data
    esgpull update -y --tag ${SEARCH_TAG}
    
    # download data
    esgpull download --tag ${SEARCH_TAG}

fi


# 
# Get greenhouse-gas concentrations
#  
if [ "x${ghg_conc}" == "x1" ] ; then 

    CMIP7_VERSION_SOURCE_ID=\"CR-CMIP-1-0-0\" 
    
    # we dont want it all, just some GHGs for now
    for varid in cfc11eq cfc12 ch4 co2 n2o ; do 

        CMIP7_VARIABLE_ID=$varid

        SEARCH_TAG="cmip7-${CMIP7_VERSION_SOURCE_ID}-${CMIP7_VARIABLE_ID}"

        # list available data
        search_cmd="esgpull search project:${CMIP7_VERSION_PROJECT} mip_era:${CMIP7_VERSION_MIP_ERA} source_id:${CMIP7_VERSION_SOURCE_ID} variable_id:${CMIP7_VARIABLE_ID}" 
        echo $search_cmd
        $search_cmd

        # get GHG data
        add_cmd="esgpull add --tag ${SEARCH_TAG} --track project:${CMIP7_VERSION_PROJECT} mip_era:${CMIP7_VERSION_MIP_ERA} source_id:${CMIP7_VERSION_SOURCE_ID} variable_id:${CMIP7_VARIABLE_ID}" 
        echo $add_cmd
        $add_cmd

        # if search has been done before, then update the search in case of updated data
        esgpull update -y --tag ${SEARCH_TAG}

        # download data
        esgpull download --tag ${SEARCH_TAG}
    
    done

fi

#
# Get ozone concentrations
#
# NOTE: There are problems with this data.  
#
if [ "x${o3}" == "x1" ] ; then 

    CMIP7_VERSION_SOURCE_ID=\"FZJ-CMIP-ozone-1-0\" 

    SEARCH_TAG="cmip7-${CMIP7_VERSION_SOURCE_ID}"

    search_cmd="esgpull search project:${CMIP7_VERSION_PROJECT} mip_era:${CMIP7_VERSION_MIP_ERA} source_id:${CMIP7_VERSION_SOURCE_ID}"
    echo $search_cmd 
    $search_cmd

    add_cmd="esgpull add --tag ${SEARCH_TAG} --track project:${CMIP7_VERSION_PROJECT} mip_era:${CMIP7_VERSION_MIP_ERA} source_id:${CMIP7_VERSION_SOURCE_ID}"
    echo $add_cmd
    $add_cmd 
    
    esgpull update -y --tag ${SEARCH_TAG}
    
    esgpull download --tag ${SEARCH_TAG}

fi 

#
# Get AMIP SST and sea ice 
# 
if [ "x${amip}" == "x1" ] ; then

    CMIP7_VERSION_MIP_ERA="CMIP7"
    CMIP7_VERSION_SOURCE_ID=\"PCMDI-AMIP-1-1-10\" 
    SEARCH_TAG="cmip7-${CMIP7_VERSION_SOURCE_ID}"

    search_cmd="esgpull search project:${CMIP7_VERSION_PROJECT} mip_era:${CMIP7_VERSION_MIP_ERA} source_id:${CMIP7_VERSION_SOURCE_ID}"
    echo $search_cmd 
    $search_cmd

    add_cmd="esgpull add --tag ${SEARCH_TAG} --track project:${CMIP7_VERSION_PROJECT} mip_era:${CMIP7_VERSION_MIP_ERA} source_id:${CMIP7_VERSION_SOURCE_ID}"
    echo $add_cmd
    $add_cmd 
    
    esgpull update -y --tag ${SEARCH_TAG}
    
    esgpull download --tag ${SEARCH_TAG}

fi 

