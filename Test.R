pacman::p_load("tidyverse", "magrittr", "nycflights13", "gapminder",
               "Lahman", "maps", "lubridate", "pryr", "hms", "hexbin",
               "feather", "htmlwidgets", "broom", "pander", "modelr",
               "XML", "httr", "jsonlite", "lubridate", "microbenchmark",
               "splines", "ISLR", "MASS", "testthat",  "carat", "gbm",
               "RSQLite", "class", "babynames", "nasaweather", "pls",
               "fueleconomy", "viridis", "boot", "devtools", "tree", "leaps",
               "glmnet", "gam", "akima", "factoextra", "randomForest",  
               "ggrepel", "GGally", "fmsb", "sjPlot", "rcompanion",
               "haven", "readxl")

brugere <- read_csv("daily-website-visitors.csv", 
                    col_types = cols(Date = col_date(format = "%Y/%m/%d")))
view(brugere)

sum(website_brugere$Returning.Visits)
