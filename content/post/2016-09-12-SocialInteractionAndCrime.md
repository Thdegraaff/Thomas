---
date: 2016-09-12
title: "Social Interaction and Crime"
categories:
  - Interaction
  - Heterogeneity
  - R
---

## *Social Interaction and Crime: An Investigation Using Individual Offender Data in Dutch Neighborhoods* conditionally accepted in RESTAT

Just heard that my paper *Social Interactions and Crime Revisited: An Investigation Using Individual Offender Data in Dutch Neighborhoods* written together with Wim Bernasco, Jan Rouwendal and Wouter Steenbeek is conditionally accepted in the **Review of Economics and Statistics**. Im am rather happy with this result; especially given the fact that we have worked on this for more than 5 years (not consecutively but still). For those interested in the paper or forgotten what it is all about, here is the abstract:

>Using data on the age, sex, ethnicity and criminal involvement of more than 14 million residents of all ages residing in approximately 4,000 neighborhoods in the Netherlands, this article tests if an individual's criminal involvement is affected by the proportion of criminals living in their neighborhood of residence. We develop a binomial discrete choice model for criminal involvement and estimate it on individual data. We control for the endogeneity that may be related to the unobserved neighborhood characteristics and take into account possible biases that may result from sorting behavior. We find significant social interaction effects but in contrast to earlier results our findings do not imply multiple equilibria or large multiplier effects.

There is a Tinbergen Institute discussion paper but that is rather old. More will follow later with hopefully a link to the pre-print version.

### Follow-up

The paper is now (November 17th, 2016) fully accepted for publication.

### Heterogeneous impacts of crime

For creating heterogeneous impacts for each neighborhood, I wrote the
following `R` code which creates sigmoids, and thus different
equilibria conditional on neighborhood variables, for each neighborhood using
`ggplot2`. 


    makefig <- function(estoutput){

    # Plots all sigmoids for each neighborhood.
    #
    # Args:
    #   EstOutput: a list with outout from iteration2sls procedure
    #
    # Returns:
    #   A ggplot2 object

    EC <- seq(0,1,0.01)
    temp <- coef(estoutput$iv)["pfield"]*100 +
            coef(estoutput$iv)["interaction"]*100*addresdensity
    tempmat <- EC%*%t(temp) + rep(1,101)%*%(tail(estoutput$phi,1))
    ECmapping <- exp(tempmat)/(1+exp(tempmat))
    figdata <- data.frame(EC, ECmapping )
    figdata_long <- melt(figdata, id="EC")
    myplot <- ggplot(figdata_long, aes(x=EC,y=value, colour =variable))  +
              geom_line() +ylim(0,1)
    myplot <- myplot  + geom_line(aes(x=EC,y=EC), size =1, colour = "black") +
              theme_bw() +
    theme(legend.position = "none") + 
    labs(x = "IE", y = "f(IE)")

    return(myplot)
    }


Which produces the following plot. 

<figure>
  <a href="/img/equilibriaPropertyYoungNeigh.png"><img src="/img/equilibriaPropertyYoungNeigh.png"></a>
  <figcaption>Offender rates of property crime with
  neighborhood-specific variables and for the youth only.</figcaption>
</figure>
