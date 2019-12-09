# main <- https://www.rottentomatoes.com/top/bestofrt/?year=2019
# moviePage <- https://www.rottentomatoes.com/m/영화제목
# 영화제목, User ratings, Genre 를 추출

# xpath ver.
# nodes <- html_nodes(tmMain,
#                     xpath = '//*[@id="top_movies_main"]/div/table/tr[1]/td[3]/a')
# //*[@id="top_movies_main"]/div/table/tbody/tr[1]/td[3]/a
# => tbody 삭제해야 인식

install.packages("rvest")
library(rvest)
library(stringr)


tmMain_url <- "https://www.rottentomatoes.com/top/bestofrt/?year=2019"
    
tmMain <- read_html(tmMain_url)
    
nodes <- html_nodes(tmMain,
                    "tr>td>a.unstyled.articleLink")
    
title <- vector(mode = "character", length = 100)
user_rating <- vector(mode = "character", length = 100)
genre <- vector(mode = "character", length = 100)
    
for(i in 1:100) {
    link <- html_attr(nodes, name = "href")
        
    movie_url <- str_c("https://www.rottentomatoes.com", link)
        
    tmp <- movie_url[i]
        
    title_text <- html_text(html_nodes(read_html(tmp),
                                        "h1"),
                            trim = TRUE)
    title[i] = title_text
        
    user_rating_text <- html_text(html_nodes(read_html(tmp),
                                            "strong.mop-ratings-wrap__text--small")[2],
                                  trim = TRUE)
    user_rating[i] = user_rating_text
        
        
    genre_text <- html_text(html_nodes(read_html(tmp),
                                       "div.meta-value>a[href*=genres]"),
                            trim = TRUE)
        
    genre[i] = paste(genre_text, collapse = ",")
        
}
    
result_df <- data.frame(title, user_rating, genre)

View(result_df)

write.csv(result_df,
          file = "C:/R_Lecture/data/rottenTomato.csv",
          quote = TRUE)
