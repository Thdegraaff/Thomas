---
date: 2015-11-25
mathjax: true
title: "Drawing Edgeworth boxes with LaTeX"
categories:
- Interaction
- LaTeX
- Education
---

## Factor mobility and welfare

For educational purposes we teach in the second year's course *regional and urban economics* students the Edgeworth-Bowley box. At first sight the concept is quite simple, but because there are restrictions for the total amount of both labour and capital in both regions or countries, the intuition behind the model  and especially the drawing of the box is rather complex. Therefore, I once wrote a straightforward but elaborate LaTeX script invoking the Tikz package. 

The setting is as follows. We consider two regions, $A$ and $B$. The productionfunction of $A$ is $Y_A = K_A^{0.2}L_A^{0.8}$ and the productionfunction of $B$ is $Y_B = K_B^{0.6}L_B^{0.4}$. In the initial situation is the amount of capital in both regions equal to 1 ($K_A = K_B = 1$). The amount of labour is as well in both regions in the initial situation equal to 1 ($L_A = L_B = 1$). The next script shows how to draw an Edgeworth-Bowley box in $\LaTeX$.

```tex
% Edgeworth box---Optimal allocation of inputs for two economies
% Author: Thomas de Graaff
\documentclass{article} 
\usepackage{tikz, verbatim}
\usepackage{pgfplots}   %include other needed packages here    
\usepackage[active,tightpage]{preview}
\PreviewEnvironment{tikzpicture}
\setlength\PreviewBorder{0pt}%
\begin{comment}
:Title: Edgeworth box---Optimal allocation of inputs for two economies
:Tags: pgfplots, economics
:Author: Thomas de Graaff

This edgeworth box describes the optimal allocation (pareto efficient) of inputs for the Cobb-Douglas production functions of two countries/regions (A and B). In addition, it shows the initial endowments of inputs and the resulting area of patero improvements. Parameters that can be changes: capital intensity parameter region A/B, total amount of labour and capital in A and B, and initial endowment K and L in A.
\end{comment}
\begin{document}   

\begin{tikzpicture}[scale=1,thick]
\usetikzlibrary{calc, intersections}	       %allows coordinate calculations.

% Define parameters
\def\alpha{0.2}		% Capital intensity parameter for region A.
\def\beta{0.6}		% Capital intensity parameter for region B.
\def\L{2}		% Total amount of labour in economy.
\def\K{2}  		% Total amount of capital in economy.
\def\PK{0.5}		% Share K in A in initial endowment.
\def\PL{0.5}		% Share L in A in initial endowment.

% Define isoquants

\def\TotalY{(\L^\alpha)*(\K^(1-\alpha))}
\def\InitYA{((\PL*\L)^(1-\alpha))*((\PK*\K)^(\alpha))}		
\def\InitYB{(((1-\PL)*\L)^(1-\beta))*(((1-\PK)*\K)^(\beta))}
\def\InitYAfromB{\TotalY-\InitYB}	

\def\La{0.2*\L}
\def\Lb{0.4*\L}
\def\Lc{0.6*\L}
\def\Ld{0.8*\L}

\def\Ka{\alpha*(1-\beta)*\K*\La/((1-\alpha)*\beta*(\L-\La)+\alpha*(1-\beta)*\La)}
\def\Kb{\alpha*(1-\beta)*\K*\Lb/((1-\alpha)*\beta*(\L-\Lb)+\alpha*(1-\beta)*\Lb)}
\def\Kc{\alpha*(1-\beta)*\K*\Lc/((1-\alpha)*\beta*(\L-\Lc)+\alpha*(1-\beta)*\Lc)}
\def\Kd{\alpha*(1-\beta)*\K*\Ld/((1-\alpha)*\beta*(\L-\Ld)+\alpha*(1-\beta)*\Ld)}

\def\YAa{((\La)^(1-\alpha)*((\Ka)^\alpha)}
\def\YAb{((\Lb)^(1-\alpha)*((\Kb)^\alpha)}
\def\YAc{((\Lc)^(1-\alpha)*((\Kc)^\alpha)}
\def\YAd{((\Ld)^(1-\alpha)*((\Kd)^\alpha)}

\def\YBa{((\L-\La)^(1-\beta)*((\K-\Ka)^\beta)}
\def\YBb{((\L-\Lb)^(1-\beta)*((\K-\Kb)^\beta)}
\def\YBc{((\L-\Lc)^(1-\beta)*((\K-\Kc)^\beta)}
\def\YBd{((\L-\Ld)^(1-\beta)*((\K-\Kd)^\beta)}

\begin{axis}[
        restrict y to domain=0:\K,
        samples = 1000,     		
        xmin = 0, xmax = \L,
        ymin = 0, ymax = \K,
		xlabel=$L_A$,
		ylabel=$K_A$,
		axis y line=left,
        axis x line=bottom,
        y axis line style={-}, 
		x axis line style={-}
		]
		\def\LineA{(\InitYA/\x^(1-\alpha))^(1/\alpha))};
		\def\LineB {\K-(\InitYB/(\L-\x)^(1-\beta))^(1/\beta)};
		\def\LineAfromB{(\InitYAfromB/\x^(1-\alpha))^(1/\alpha))};
			
% color the area with all pareto improvements			
      \addplot [fill=orange!40, opacity=0.5, draw=none,domain=0:\L] {\LineB} \closedcycle;
      \addplot [fill=white, draw=none,domain=0:\L] {\LineA} |- (axis cs:0,0) -- (axis cs:0,\K)--cycle; 
      			
	  %Draw isoquants
      \addplot[thin, dotted, mark=none, domain=0:\L] {(\YAa/\x^(1-\alpha))^(1/\alpha)};
      \addplot[thin, dotted, mark=none, domain=0:\L] {(\YAb/\x^(1-\alpha))^(1/\alpha)};
      \addplot[thick, mark=none, domain=0:\L] {\LineA};     
      \addplot[thin, dotted, mark=none, domain=0:\L] {(\YAc/\x^(1-\alpha))^(1/\alpha)};
      \addplot[thin, dotted, mark=none, domain=0:\L] {(\YAd/\x^(1-\alpha))^(1/\alpha)};
   
      \addplot[thin, dotted, mark=none, domain=0:\L] {\K-(\YBa/(\L-\x)^(1-\beta))^(1/\beta)};
      \addplot[thin, dotted, mark=none, domain=0:\L] {\K-(\YBb/(\L-\x)^(1-\beta))^(1/\beta)};
      \addplot[thick, mark=none, domain=0:\L] {\LineB};
      \addplot[thin, dotted, mark=none, domain=0:\L] {\K-(\YBc/(\L-\x)^(1-\beta))^(1/\beta)};
      \addplot[thin, dotted, mark=none, domain=0:\L] {\K-(\YBd/(\L-\x)^(1-\beta))^(1/\beta)};
      
	  %Draw contractcurve
	  \addplot[mark=none, domain=0:\L, color=blue,thick]	{\alpha*(1-\beta)*\K*\x/((1-\alpha)*\beta*(\L-\x)+\alpha*(1-\beta)*\x)};
	  %Draw initial endowments
	 \addplot[thick, mark=*, fill=red!50] coordinates {(\L*\PL,\K*\PK)};
\end{axis}

% Draw mirrored axis
\begin{axis}[
        restrict y to domain=0:\K,
        minor tick num=1,
		xlabel=$L_B$,
		ylabel=$K_B$,
        xmin = 0, xmax = \L,
        ymin = 0, ymax = \K,
        axis y line=right, 
        axis x line=top,
        x dir=reverse,
        y dir=reverse,
        y axis line style={-}, 
		x axis line style={-}
		]
\end{axis}
\end{tikzpicture}
\end{document} 
```

This produces the following diagram:

<img src="/img/EdgeworthBox.png" width = 800>
<figcaption>The Edgeworth-Bowley box and the corresponding Pareto improving area.</figcaption>

Clearly, the initial situation (1,1) is not efficient and both regions
can increase their welfare by *both* migrating capital and
labour. Labour will move from $B$ to $A$ and capital will move from
$A$ to $B$. Note that the light grey area (should be light orange) area
denotes the area with all pareto improvements. 
