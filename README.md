# Get CMIP7 forcing data

## Purpose

Retrieve CMIP7 forcing data from ESGF. Intended for use with EC-Earth4 but applicable to other models as well. 

Currently set up for

* Solar forcing
* SST and sea ice for AMIP
* GHG concentrations (CO2, N2O, CH4 etc) 
* Ozone 

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
On my own HPC account I set
```bash
Install location (/home/sm_joakj/.esgpull): /nobackup/rossby27/proj/rossby/joint_exp/ecearth/ece-4-data-cmip7 
```

data will now end up in `/nobackup/rossby27/proj/rossby/joint_exp/ecearth/ece-4-data-cmip7/data`. 

### Choosing ESGF node   

I had some issues with getting some data from some nodes. Best option seems to be a bridge node
```bash
esgpull config api.index_node esgf-node.ornl.gov/esgf-1-5-bridge
```
It finds everything, both on US and EU servers. 

Normally one should be fine with any EU node, e.g. DKRZ or IPSL, but sometimes `esgpull` will not work with them and sometimes they can't find some data. The bridge node above is currently the best option. 
See also: https://github.com/ESGF/esgf-download/issues/101 

## Usage

### Configure 

The top part of the script contains the following lines
```bash
# Set the one you want to 1, others to 0
solar=0
ghg_conc=0
o3=0
amip=0
```

Simply change to `1` for the data you wish to retrieve. 

### Run

```bash
./esgpull_cmip7.sh 
```

### Post 

The data will be organised into a bunch of subdirectories, e.g. `ece-4-data-cmip7/data/input4MIPs/CMIP7/CMIP/SOLARIS-HEPPA/SOLARIS-HEPPA-CMIP-4-6/atmos/mon/Multiple/gn/v20250219/` which is not ideal. For EC-Earth, you should create a directory structure like 
```bash
ls cmip7-data/
amip
ghg
ozone
solar
```

and then move the solar data into `solar` etc. EC-Earth expects to find solar data under `cmip7-data/solar`, CO2 data under `cmip7-data/ghg/` etc. 

### Adding another dataset?

See https://input4mips-cvs.readthedocs.io/en/latest/database-views/input4MIPs_delivery-summary.html to find the `CMIP7_VERSION_SOURCE_ID` of other datasets. 



