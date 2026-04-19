#!/bin/bash
#
# Generate forcing for HighResMIP2 (control-1950). 
# We can use perpetual 1950 values for most files, but for 
# solar and ozone we need to average over years 1945-1955 to 
# average over a solar cycle. 
#
module load cdo

# average solar files 
cdo -L -ymonmean -select,startdate=1945-01-01T00:00:00,enddate=1955-12-31T23:00:00 multiple_input4MIPs_solar_CMIP_SOLARIS-HEPPA-CMIP-4-6_gn_185001-202312.nc multiple_input4MIPs_solar_HighResMIP2_SOLARIS-HEPPA-4-6_gn.nc

# average ozone files
cdo -L -ymonmean -select,startdate=1945-01-01T00:00:00,enddate=1955-12-31T23:00:00 vmro3_input4MIPs_ozone_CMIP_FZJ-CMIP-ozone-2-0_gn_??????-??????.nc vmro3_input4MIPs_ozone_CMIP_FZJ-HighResMIP2-ozone-2-0_gn_195001-195012-clim.nc

