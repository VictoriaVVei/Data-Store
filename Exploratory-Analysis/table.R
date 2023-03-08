## package
library(dplyr)
library(ggplot2)
library(patchwork)
library(rmarkdown)
library(tidyverse)
library(stringr)

## read data
pacific <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/pacific.csv?token=GHSAT0AAAAAAB6RUHXG4MSOK7BGP37UM4RSZAIAVRQ")
atlantic <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/atlantic.csv?token=GHSAT0AAAAAAB6RUHXHFSMCPABYBWN3ERVIZAIAWEQ")
earthquake <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/4311c5ad91b1ff6c0ac59fb3a843dea03767be71/dataset/database.csv?token=GHSAT0AAAAAAB6RUHXGVYIC5UIYWQEFTDYMZAIBETQ")

## extract num
earthquake_num <- earthquake %>% 
  mutate(year = as.numeric(gsub("[^()]*\\/", "", Date))) %>%
  group_by(year) %>%
  filter(!is.na(year)) %>%
  summarise(earthquake_num = n())
  
atlantic_num <- atlantic %>% 
  mutate(year = as.numeric(str_sub(Date, 1, 4))) %>%
  group_by(year) %>%
  filter(!is.na(year)) %>%
  summarise(atlantic_num = n())

pacific_num <- pacific %>% 
  mutate(year = as.numeric(str_sub(Date, 1, 4))) %>%
  group_by(year) %>%
  filter(!is.na(year)) %>%
  summarise(pacific_num = n())

## final graph
merge_disaster <- atlantic_num %>%
  inner_join(pacific_num) %>%
  inner_join(earthquake_num)
disaster <-  merge_disaster[36:51,]
colnames(disaster) <- c("Year",
                              "Number of Atlantic",
                              "Number of Pacific", 
                              "Number of Earthquake")


