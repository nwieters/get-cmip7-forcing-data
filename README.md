# Get CMIP7 forcing data

## Purpose

Retrieve forcing data, e.g. solar forcing, greenhouse-gas concentrations, ozone concentrations, etc, from ESGF. Intended for use with EC-Earth4. 

## Method

Using `esgpull` (https://esgf.github.io/esgf-download/) in a shell script. 

## Getting started

### Install esgpull 

Reference: https://esgf.github.io/esgf-download/

Install `esgpull` using pip: 

```bash
mamba env create -f esgpull_env.yml -p ./.conda_esgpull
mamba activate ./.conda_esgpull 
```

Then set up `esgpull` on the machine
```bash
esgpull self install
```

by default, it wants to install in HOME, which is "no bueno" on a HPC. Use some work directory instead.
On my own NSC account I set
```bash
Install location (/home/sm_joakj/.esgpull): /nobackup/rossby27/proj/rossby/joint_exp/ecearth/ece-4-data-cmip7 
```

data will now end up in `/nobackup/rossby27/proj/rossby/joint_exp/ecearth/ece-4-data-cmip7/data`. 

### Choosing ESGF node   

I had some issues with the default node (IPSL), so I switched to DKRZ
```bash
esgpull config api.index_node esgf-data.dkrz.de 
```

## Usage

### Find the source ID of the data

To get most recent data, see the CMIP7_VERSION_SOURCE_IDs on https://input4mips-cvs.readthedocs.io/en/latest/database-views/input4MIPs_delivery-summary.html and use those CMIP7_VERSION_SOURCE_ID below



