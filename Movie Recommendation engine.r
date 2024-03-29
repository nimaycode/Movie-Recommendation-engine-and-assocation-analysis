---
title: "Movie recommendation engine"
author: "Nimay Srinivasan"
output:
  html_notebook:
    toc: yes
    toc_float: yes
  html_document:
    toc: yes
    df_print: paged
editor_options: 
  chunk_output_type: inline
---

### Part 2.2

```{r}
x <- 20472954 %% 671
paste("user", x)
```

```{r}
setwd("/Users/nimaysrinivasan")
set.seed(100)
movies <- read.csv("movies.csv", header=T, sep=",")
sample <- sample(1:nrow(movies), 10)
moviesample <- movies[sample, ]
moviesample$movieId
```

#### User profile

```{r}
userProfile <- read.csv("/Users/nimaysrinivasan/CS-422/CS-422 Homework 9/ml-latest-small/userProfile.csv", header=T, sep=",")
allGenere <- c("Action", "Adventure", "Animation", "Children", "Comedy", "Crime", "Documentary", "Drama", "Fantasy",
"Film-Noir", "Horror", "IMAX", "Musical", "Mystery", "Romance", "Sci-Fi", "Thriller", "War", "Western")
for (row in 1:nrow(userProfile)) {
  generes <- as.list(strsplit(toString(movies[movies$movieId == userprofile[row, ]$X, ]$genres),"[|]")[[1]])
  for (g in generes) {
    userProfile[row, g] = 1
  }
}
for (g in allGenere) {
    print(sum(userProfile[, g]))
    userProfile["avg", ] <- colMeans(userProfile)
}
userProfile <- userProfile[, 1:21]
userProfile
```


#### Movie profile

```{r}
movieProfile <- read.csv("/Users/nimaysrinivasan/CS-422/CS-422 Homework 9/ml-latest-small/movieprofile.csv", header=T, sep=",")
allGenere <- c("Action", "Adventure", "Animation", "Children", "Comedy", "Crime", "Documentary", "Drama", "Fantasy",
"Film-Noir", "Horror", "IMAX", "Musical", "Mystery", "Romance", "Sci-Fi", "Thriller", "War", "Western")
for (row in 1:nrow(movieProfile)) {
  generes <- as.list(strsplit(toString(movies[movies$movieId == movieProfile[row, ]$X, ]$genres),"[|]")[[1]])
  for (g in generes) {
    movieProfile[row, g] = 1
  }
}
movieProfile <- movieProfile[, 1:21]
movieProfile
```


#### Cosine similarity

```{r}
options("digits"=5)
for(i in 1:nrow(movieProfile)){
  score <- lsa::cosine(as.numeric(userProfile["avg",-1]), as.numeric(movieProfile[movieProfile$X == movieProfile[i,'X'],-1]))[[1]]
movieId <- movieProfile[movieProfile$X == movieProfile[i,'X'],1]
title <- as.vector(movies[movies$movieId == movieId,"title"])[1]
cat("Movie ", title, ", and similarity score ", score , "\n")
}
```
