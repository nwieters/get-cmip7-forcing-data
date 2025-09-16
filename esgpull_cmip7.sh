#!/bin/bash
# 
# Get CMIP7 forcing data using esgpull
# 
# Reference doc: 
# https://esgf.github.io/esgf-download/
#
#
# It goes without saying that you need to install esgpull first
# 
# mamba env create -f esgpull_env.yml -p ./.conda_esgpull 
# mamba activate ./.conda_esgpull 
# 
# Then install esgpull on the machine
# esgpull self install
# 
# by default, it wants to install in HOME, which is no bueno. 
# I set
# Install location (/home/sm_joakj/.esgpull): /nobackup/rossby27/proj/rossby/joint_exp/ecearth/ece-4-data-cmip7 
#
# Data will end up in install location /data  
#
# I had some issues with the default node (IPSL), so I switched to DKRZ
# esgpull config api.index_node esgf-data.dkrz.de 
#
# To get most recent data, see the CMIP7_VERSION_SOURCE_IDs on 
# https://input4mips-cvs.readthedocs.io/en/latest/database-views/input4MIPs_delivery-summary.html
# and use those CMIP7_VERSION_SOURCE_ID below

# Set the one you want to 1, others to 0
solar=1
ghg_conc=0
o3=0
amip=0

CMIP7_VERSION_PROJECT="input4MIPs"

CMIP7_VERSION_MIP_ERA="CMIP7"

# 
# Get solar forcing
# 

if [ "x${solar}" == "x1" ] ; then

    # each data set, e.g. solar forcing, has a source ID
    CMIP7_VERSION_SOURCE_ID="SOLARIS-HEPPA-CMIP-4-6"

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

    CMIP7_VERSION_SOURCE_ID="CR-CMIP-1-0-0" 
    
    SEARCH_TAG="cmip7-${CMIP7_VERSION_SOURCE_ID}"
    
    # list available data
    search_cmd="esgpull search project:${CMIP7_VERSION_PROJECT} mip_era:${CMIP7_VERSION_MIP_ERA} source_id:${CMIP7_VERSION_SOURCE_ID}" 
    echo $search_cmd
    $search_cmd

    # get GHG data
    add_cmd="esgpull add --tag ${SEARCH_TAG} --track project:${CMIP7_VERSION_PROJECT} mip_era:${CMIP7_VERSION_MIP_ERA} source_id:${CMIP7_VERSION_SOURCE_ID}" 
    echo $add_cmd
    $add_cmd

    # if search has been done before, then update the search in case of updated data
    esgpull update -y --tag ${SEARCH_TAG}
    
    # download data
    esgpull download --tag ${SEARCH_TAG}
    
fi

#
# Get ozone concentrations
#
# NOTE: There are problems with this data.  
#
if [ "x${o3}" == "x1" ] ; then 

    export CMIP7_VERSION_SOURCE_ID="FZJ-CMIP-ozone-1-0" 

    export SEARCH_TAG="cmip7-${CMIP7_VERSION_SOURCE_ID}"

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
    CMIP7_VERSION_SOURCE_ID="PCMDI-AMIP-1-1-10" 
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

