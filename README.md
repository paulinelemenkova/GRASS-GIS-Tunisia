# GRASS GIS Scripts — Seasonal Monitoring of Saline Lakes in Tunisia

GRASS GIS shell scripts used to produce the figures in the peer-reviewed article by Polina Lemenkova. The scripts monitor seasonal land-use/land-cover fluctuations of the saline lakes (sebkhas) of northern Tunisia across the Gulf of Hammamet and Gulf of Gabès, using a seasonal Landsat 8-9 OLI/TIRS series (February, April and July of 2017 and 2023).

**Published in:** *Land* **2023**, *12*(11), 1995
**DOI:** https://doi.org/10.3390/land12111995
**Journal (open access):** https://www.mdpi.com/2073-445X/12/11/1995
**HAL:** https://hal.science/hal-04265828v1
**Zenodo:** https://doi.org/10.5281/zenodo.10057566
**SSRN:** https://ssrn.com/abstract=4618750

## Contents
Shell scripts calling GRASS GIS modules for raster import (r.import), band grouping (i.group), unsupervised clustering (i.cluster, k-means), maximum-likelihood classification (i.maxlik), rejection-probability mapping and accuracy assessment (r.kappa, error matrix and kappa coefficient), with mapping via r.colors, d.rast, d.legend and d.out.file. Scripts cover two regions (Tunisia and Gabès) across three seasons (February, April, July) for 2017 and 2023.

## LaTeX source
The LaTeX source (prose) of this article is in a separate repository: https://github.com/paulinelemenkova/grass-landcover-classification-tunisia

## Citation
Lemenkova, P. Monitoring Seasonal Fluctuations in Saline Lakes of Tunisia Using Earth Observation Data Processed by GRASS GIS. *Land* **2023**, *12*(11), 1995. https://doi.org/10.3390/land12111995
