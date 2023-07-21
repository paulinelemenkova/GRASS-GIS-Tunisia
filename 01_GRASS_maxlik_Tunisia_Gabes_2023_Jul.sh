#!/bin/sh
# 1. Import data
# listing the files

# g.mapset location=Tunisia mapset=PERMANENT

g.list rast
# importing the image subset with 7 Landsat bands and display the raster map
r.import input=/Users/polinalemenkova/grassdata/Tunisia/LC09_L2SP_191036_20230715_20230717_02_T1_SR_B1.TIF output=L8_2023j_01 resample=bilinear extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Tunisia/LC09_L2SP_191036_20230715_20230717_02_T1_SR_B2.TIF output=L8_2023j_02 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Tunisia/LC09_L2SP_191036_20230715_20230717_02_T1_SR_B3.TIF output=L8_2023j_03 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Tunisia/LC09_L2SP_191036_20230715_20230717_02_T1_SR_B4.TIF output=L8_2023j_04 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Tunisia/LC09_L2SP_191036_20230715_20230717_02_T1_SR_B5.TIF output=L8_2023j_05 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Tunisia/LC09_L2SP_191036_20230715_20230717_02_T1_SR_B6.TIF output=L8_2023j_06 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Tunisia/LC09_L2SP_191036_20230715_20230717_02_T1_SR_B7.TIF output=L8_2023j_07 extent=region resolution=region
#
g.list rast
#
# grouping data by i.group
# Set computational region to match the scene
g.region raster=L8_2023j_01 -p
# store VIZ, NIR, MIR into group/subgroup (leaving out TIR)
i.group group=L8_2023j subgroup=res_30m \
  input=L8_2023j_01,L8_2023j_02,L8_2023j_03,L8_2023j_04,L8_2023j_05,L8_2023j_06,L8_2023j_07
#
# 4. Clustering: generating signature file and report using k-means clustering algorithm
i.cluster group=L8_2023j subgroup=res_30m \
  signaturefile=cluster_L8_2023j \
  classes=10 reportfile=rep_clust_L8_2023j.txt --overwrite
# 5. Classification by i.maxlik module
#
i.maxlik group=L8_2023j subgroup=res_30m \
  signaturefile=cluster_L8_2023j \
  output=L8_2023j_cluster_classes reject=L8_2023j_cluster_reject --overwrite
#
# 6. Mapping
d.mon wx0
g.region raster=L8_2023j_cluster_classes -p
r.colors L8_2023j_cluster_classes color=roygbiv -e
# d.rast.leg L8_2014_cluster_classes
d.rast L8_2023j_cluster_classes
d.legend raster=L8_2023j_cluster_classes title="2023 July" title_fontsize=14 font="Helvetica" fontsize=12 bgcolor=white border_color=white
d.out.file output=TunisiaG_202307 format=jpg --overwrite
#
d.mon wx1
g.region raster=L8_2023j_cluster_classes -p
r.colors L8_2023j_cluster_reject color=haxby -e
d.rast L8_2023j_cluster_reject
d.legend raster=L8_2023j_cluster_reject title="2023 July" title_fontsize=14 font="Helvetica" fontsize=12 bgcolor=white border_color=white
d.out.file output=Tunisia_202307_reject format=jpg --overwrite
#d.rast.leg L8_2014_cluster_reject
#
# r.kappa - Calculates error matrix and kappa parameter for accuracy assessment of classification result.
g.region raster=L8_2015_cluster_classes -p
r.kappa -w classification=L8_2015_cluster_classes reference=L8_2014_cluster_classes

# export Kappa matrix as CSV file "kappa.csv"
r.kappa classification=L8_2015_cluster_classes reference=L8_2014_cluster_classes output=kappa.csv -m -h --overwrite
