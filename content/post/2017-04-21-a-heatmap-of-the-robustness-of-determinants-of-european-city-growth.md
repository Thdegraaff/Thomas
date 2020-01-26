---
title: A Heatmap of the Robustness of Determinants of European City growth
mathjax: true
author: Thomas de Graaf
date: '2017-04-21'
slug: a-heatmap-of-the-robustness-of-determinants-of-european-city-growth
highlightjsLang: "R"
categories:
  - Research
  - Reproducability
  - Heterogeneity
  - R
tags: []
---

## Introduction

Understanding what makes a city tick (e.g., the determinants that makes cities succesful in employment of economic growth) is vital for both policy makers and (regional) economists. Indeed, local policy makers usually want to know what they can contribute to the performance of their city or region. If policy makers can at all influence the performance, then most likely instruments vary between cities and regions. What is good for one city is not necessarily good for another. To analyse this, I ran many regressions of combinations of determinants and analyse their robustness (e.g., sign changes, changes in significance level and coefficients). The research is commissioned by the PBL Netherlands Environmental Assessment Agency.

## The problem

One way of looking at city or regional performance is to make use of growth models. Typically, an empirical growth model comes in the following shape:

$$
\ln(\frac{y_t}{y_0})=\ln(y_0)+\mathbf{X}\beta+\epsilon,
$$

where $y_t$ denotes a regional or city performance measure (gdp or employment), so $\ln(\frac{y_t}{y_0})$ denotes the growth rate of $y$ between $t$ and $0$. On the right hand side, typically one controls for the initial state of $y$ at time $0$ and for a whole bunch of other variables $\mathbf{X}$. And it is exactly these variables we are interested in:

>Which variables, if any, have a systematic and robust impact on the growth rate of $y$?

So, we estimate the model above multiple times where each time $\mathbf{X}$ is formed by a subset of all determinants (in our case we use for each regression 4 variables out of around 70). This yield a database of many regression results (actually two databased: one with the coefficients and one with the t-values). One way of assessing the robustness of a particular indicator is to look at how many times that indicator is signicant and display the percentage in a heatmap

## Creating a heat map of the regression results

After I have run all possible regressions (and there are many given the formula $\frac{71!}{4!(71-4)!}$, I can perform an ex-post analysis on the results. For my purpose, I have looked at city gdp for all sectors combined, and separately for 7 sectors and have created a dataset that consists of how many times (in percentages) a variable was significant in the regression above. This had led to the table below with sectors as variables and each determinant as an observation (alas, sector names and variables are in Dutch).

    > data
    # A tibble: 71 × 8
                          Variable    Totaal     Landbouw Constructie         fbs   Industrie
                             <chr>     <dbl>        <dbl>       <dbl>       <dbl>       <dbl>
    1                        Banen 0.9999791 0.6722262812 0.999937376 0.846926208 1.000000000
    2            Levensverwachting 1.0000000 0.9523640539 0.999519883 0.816386598 0.845819852
    3          Kwaliteit onderwijs 0.9756184 0.0577601503 0.694269909 0.998893644 0.579000104
    4                    Recreatie 0.5286922 0.0000000000 0.999874752 0.595031834 0.593695856
    5                 Natuurrampen 1.0000000 0.0002087465 0.082580106 0.985867863 0.006137146
    6            Clustering chemie 0.8412901 0.0003131197 0.027157917 0.291034339 0.034631041
    7       Specialisatie landbouw 0.9799395 0.0001878718 0.225634067 1.000000000 0.045360610
    8  Specialisatie electriciteit 0.9998956 0.0001669972 0.005531782 0.004905542 0.999645131
    9               Bereikbaarheid 0.9505062 0.2850224402 0.759482309 0.999979125 0.935392965
    10                     Cultuur 0.9457468 0.0352364054 1.000000000 0.973363949 0.828368646
    # ... with 61 more rows, and 2 more variables: `Niet markt diensten` <dbl>, wrtdchc <dbl>

To make a heat map I first have to create a tidy dataset using the gather function:

    > data <- gather(data, sector, waarde, -Variable)
    > data
    # A tibble: 497 × 3
                          Variable sector    waarde
                             <chr>  <chr>     <dbl>
    1                        Banen Totaal 0.9999791
    2            Levensverwachting Totaal 1.0000000
    3          Kwaliteit onderwijs Totaal 0.9756184
    4                    Recreatie Totaal 0.5286922
    5                 Natuurrampen Totaal 1.0000000
    6            Clustering chemie Totaal 0.8412901
    7       Specialisatie landbouw Totaal 0.9799395
    8  Specialisatie electriciteit Totaal 0.9998956
    9               Bereikbaarheid Totaal 0.9505062
    10                     Cultuur Totaal 0.9457468
    # ... with 487 more rows
    
To be able to sort the heat map based on average values, I create a new variable with the average of all the percentages, order it in descending order and refactor the sector names, so that it remains in the order I want in the heatmap:

    data <- data %>%
      group_by(Variable) %>%
      mutate(gemiddelde  = mean(waarde), 
        sector <- as.character(sector),
        sector <- factor(sector, 
                  levels=c("Totaal", "Landbouw", "Constructie", 
                           "fbs", "Industrie", "Niet markt diensten",
                           "wrtdchc"))) %>%
      arrange(desc(gemiddelde))

The data now looks like:

    > data
    # A tibble: 497 × 6
                Variable              sector    waarde gemiddelde `sector <- as.character(sector)`
                   <chr>              <fctr>     <dbl>      <dbl>                            <chr>
    1     Waarde in 1991              Totaal 1.0000000  1.0000000                           Totaal
    2     Waarde in 1991            Landbouw 1.0000000  1.0000000                         Landbouw
    3     Waarde in 1991         Constructie 1.0000000  1.0000000                      Constructie
    4     Waarde in 1991                 fbs 1.0000000  1.0000000                              fbs
    5     Waarde in 1991           Industrie 1.0000000  1.0000000                        Industrie
    6     Waarde in 1991 Niet markt diensten 1.0000000  1.0000000              Niet markt diensten
    7     Waarde in 1991             wrtdchc 1.0000000  1.0000000                          wrtdchc
    8  Levensverwachting              Totaal 1.0000000  0.9134179                           Totaal
    9  Levensverwachting            Landbouw 0.9523641  0.9134179                         Landbouw
    10 Levensverwachting         Constructie 0.9995199  0.9134179                      Constructie
    # ... with 487 more rows, and 1 more variables: `sector <- factor(sector, levels =
    #   c("...` <fctr>
    
With the `geom_tile` aesthetic from `ggplot2` I can now create the heat map I want as follows (note that I used the package `RColorBrewer` for my colour palette):

      # Note that for ggplot I still have to reorder the variable I want based on the gemiddelde
      p <- ggplot(data,aes(x = sector, y = reorder(Variable,gemiddelde))) +  
      	 geom_tile(aes(fill = waarde),colour = "white") + 
      	 scale_fill_distiller("Percentage\nsignificant", 
      	                      palette = "Spectral") +
      	 theme_grey(base_size = 9) + 
      	 labs(x = "",y = "") + 
      	 scale_x_discrete(expand = c(0, 0)) +
           scale_y_discrete(expand = c(0, 0)) + 
           theme(axis.ticks = element_blank(), 
      		axis.text.x = element_text(size = 9 *0.8, 
      		angle = 330, hjust = 0, colour = "grey50"))

Which finally produces the following plot.

{{< figure src="/img/heatmap_gva.png" title="Heatmap of percentage significance of indicators on European city growth.">}}

## Implications
When looking at the plot above, it is remarkable that most of the variables are not significant at all times. Worse, most of them are not even significant 75% or even 50% of all cases. This casts great doubt upon the robustness and even validity of most of the determinants oftentimes used in these type of analyses. On the other hand, some of the determinants of city growth may only be important in combination with other determinants. So the next step, would be to look at the impact conditional on other determinants.