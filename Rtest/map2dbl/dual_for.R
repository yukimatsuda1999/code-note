library(tidyverse)


df_cns_brdsv_deg_2000_add_dist = read_csv("R/test/suzuemon/2022_11_16_cns_near_sv_TFBS_DHS.csv")

# 元コード ---------------------------------------------------------------------
filter_dist=seq(0,10000,1000)
for (i in seq(0,2000,200)) {
  li_flt_dist = c()
  li_flt_dist_tfbs =c()
  li_flt_dist_dhs =c()
  li_flt_dist_dhs_tfbs =c()
  
  df_flted_dist_cns_sv=df_cns_brdsv_deg_2000_add_dist %>% 
    dplyr::filter(Distance_between_CNS_and_SV <= i)
  for (a in seq(0,10000,1000)) {
    flt_dist =df_flted_dist_cns_sv %>% 
      filter(Distance_between_CNS_and_DEG <= a) %>%
      distinct(CNS_name) %>% 
      nrow()
    flt_dist_tfbs = df_flted_dist_cns_sv %>% 
      filter(Distance_between_CNS_and_DEG <= a) %>%
      filter(Distance_between_CNS_and_motif_TFBS == 0) %>% 
      distinct(CNS_name) %>% 
      nrow()
    flt_dist_dhs = df_flted_dist_cns_sv %>% 
      filter(Distance_between_CNS_and_DEG <= a) %>%
      dplyr::filter(Distance_between_CNS_and_plantDHS == 0|
                      Distance_between_CNS_and_callus_DHS == 0 |
                      Distance_between_CNS_and_seedling_DHS == 0) %>% 
      nrow()
    flt_dist_dhs_tfbs = df_flted_dist_cns_sv %>% 
      filter(Distance_between_CNS_and_DEG <= a) %>%
      filter(Distance_between_CNS_and_motif_TFBS == 0) %>%
      dplyr::filter(Distance_between_CNS_and_plantDHS == 0|
                      Distance_between_CNS_and_callus_DHS == 0 |
                      Distance_between_CNS_and_seedling_DHS == 0) %>% 
      nrow()
    li_flt_dist = c(li_flt_dist,c(flt_dist))
    li_flt_dist_tfbs =c(li_flt_dist_tfbs,c(flt_dist_tfbs))
    li_flt_dist_dhs =c(li_flt_dist_dhs,c(flt_dist_dhs))
    li_flt_dist_dhs_tfbs =c(li_flt_dist_dhs_tfbs,c(flt_dist_dhs_tfbs))
  }
  df_near_=data.frame(filter_dist,li_flt_dist,li_flt_dist_tfbs,li_flt_dist_dhs,li_flt_dist_dhs_tfbs) %>% 
    dplyr::mutate(rate_dist =  li_flt_dist_tfbs/li_flt_dist*100) %>% 
    dplyr::mutate(rate_dist_dhs = li_flt_dist_dhs_tfbs/li_flt_dist_dhs*100) %>% 
    dplyr::select(1,6,7)
  nam = base::paste("df_near_", i, sep="")
  assign(nam,df_near_)
}


# 高速化 -----------------------------------------------------------------------
calc_rate_dist = function(i, a) {
  
  df_filtered = df_cns_brdsv_deg_2000_add_dist %>%
    dplyr::filter(Distance_between_CNS_and_SV <= i)
  
  flt_dist = df_filtered %>% 
    filter(Distance_between_CNS_and_DEG <= a) %>%
    distinct(CNS_name) %>% 
    nrow()
  flt_dist_tfbs = df_filtered %>% 
    filter(Distance_between_CNS_and_DEG <= a) %>%
    filter(Distance_between_CNS_and_motif_TFBS == 0) %>% 
    distinct(CNS_name) %>% 
    nrow()
  return(flt_dist_tfbs/flt_dist*100)
}

calc_rate_dist_dhs = function(i, a) {
  
  df_filtered = df_cns_brdsv_deg_2000_add_dist %>%
    dplyr::filter(Distance_between_CNS_and_SV <= i)
  
  flt_dist_dhs = df_filtered %>% 
    filter(Distance_between_CNS_and_DEG <= a) %>%
    dplyr::filter(Distance_between_CNS_and_plantDHS == 0|
                    Distance_between_CNS_and_callus_DHS == 0 |
                    Distance_between_CNS_and_seedling_DHS == 0)
  
  flt_dist_dhs_tfbs = flt_dist_dhs %>% 
    filter(Distance_between_CNS_and_motif_TFBS == 0)

  return(nrow(flt_dist_dhs_tfbs)/nrow(flt_dist_dhs)*100)
}

i_lst = seq(0, 2000, 200)  # distance between CNS and SV
a_lst = seq(0, 10000, 1000)  # distance between CNS and DEG

df_for_facet = expand.grid(i_lst, a_lst) %>%
  mutate(filter_near = Var1,
         filter_dist = Var2,
         rate_dist = map2_dbl(Var1, Var2, calc_rate_dist),
         rate_dist_dhs = map2_dbl(Var1, Var2, calc_rate_dist_dhs)) %>%
  dplyr::select(filter_near, filter_dist, rate_dist, rate_dist_dhs)

map2_dbl(df_for_facet$Var1, df_for_facet$Var2, calc_rate_dist)
map2_dbl(df_for_facet$Var1, df_for_facet$Var2, calc_rate_dist_dhs)
