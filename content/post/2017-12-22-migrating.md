---
title: "Migrating from Jekyll to Hugo"
date: 2017-12-22T14:08:26+01:00
draft: false
categories: ["hugo"]
---

### Introduction 

For quite some time I have been thinking about migrating my (very small) website to the [Hugo](https://gohugo.io/) platform. Mostly because I admire the information rich structure of [Kieran Healy's](kieranhealy.org) website and he converted already from [Jekyll](https://jekyllrb.com/) to Hugo a while ago. Because my website is indeed quite small, it does not suffer from Jekyll oftentimes being slow. However, I needed some additional features of my Jekyll site (e.g., converting bibtex to a reference list), which could not automatically be rendered by [Github](github.com) which is my choice of deployment. Therefore, I used a rakefile which I did not completely understand, but resulting in asynchronous versions of source code and published website, which is undesirable. Finally, I have read somewhere that I can deploy my beloved `.org` files as well using Hugo, which seems almost brilliant.

### Choosing a template

So I decided to convert my website to Hugo with a website design close to that of Kieran Healy. Interestingly, Kieran Healy based his website on Greg Restall's [consequently.org](consequently.org). There is a large amount of Hugo templates by now and the [Hugo-Finite](https://github.com/lambdafu/hugo-finite) came closest to what I wanted (actually, this template is based on that of Greg Restall). Unfortunately, it still needed quite a lot of (css) work to get it in the shape I wanted. Then, by sheer accident, I stumbled upon the website of [Rob J Hyndman](https://robjhyndman.com/), who had already worked on the Hugo-Finite template to make it look more like Kieran Healy's website. Moreover, his template works in combination with [bookdown](https://bookdown.org/yihui/bookdown/), which might be handy, if I want to convert `.rmd` files in the future (say for education purposes), therefore I decided to copy his template and adapt it to my own needs.

### The process & the result

To be honest, it took me quite a while to understand the structure of a Hugo template, especially with the various lay-outs. Moreover, it turned out that I had to make a `markdown` file for each publication separately, which is rather cumbersome. So, especially the seminars and publication sections still need quite some work. Moreover, adapting small things (get syntax highlighting correct for `R`, appropriately adapting the footer, starting to tamper with the css files), took me quite some time. However, the result looks already good (alhough still quite like that of Rob J Hyndman in terms of css). So I imagine that in the coming weeks I will work on this further and start change small pieces here and there. At the moment I am still quite unhappy about two things:

* Deployment: At the moment I have to add, commit and push twice to Github (once for my source code and once for my published site). I need to change this by or using a Makefile or a shell script.
* I need to think about how and whether to include a software page (for `R` packages and `LaTeX` chunks).