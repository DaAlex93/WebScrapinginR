#Web scraping

library(rvest)
library(XML)
library(stringr)
library(stringi)

#IMDB
#Extracts words from file in pc
text = readLines("/") #path of file
docs = Corpus(VectorSource(txt))
inspect(docs)
#Can use to conduct sentiment analysis

#Extracting from url
url="http://www.imdb.com/search/title?year=2017&title_type=feature&"  
#Reading the HTML code from the website using package XML  
webpage = read_html(url)  

#CSS Selector to scrape
rank_data_html = html_nodes(webpage,'.text-primary')
class(rank_data_html)

#Converting ranking data to text
rank_data = html_text(rank_data_html)
class(rank_data)

#Look at rank
head(rank_data)

#converto to numerical format
rank_data=as.numeric(rank_data)
class(rank_data)

head(rank_data)
  
#CSS Selector to scrape title
title_data_html = html_nodes(webpage,'.lister-item-header a')

#Converting title data to text
title_data = html_text(title_data_html)
head(title_data)


#CSS Selector to scrape runtime
runtime_data_html = html_nodes(webpage,".runtime")
runtime_data = html_text(runtime_data_html)
head(runtime_data)
runtime_data = gsub(" min","",runtime_data)
runtime_data = as.numeric(runtime_data)
head(runtime_data)


genre_data_html = html_nodes(webpage,'.genre')  
#Converting the genre data to text  
genre_data = html_text(genre_data_html)  
#Let's have a look at the runtime  
head(genre_data)  
genre_data=gsub("\n","",genre_data)  
#Data-Preprocessing: removing excess spaces  
genre_data=gsub(" ","",genre_data)  
#taking only the first genre of each movie  
genre_data=gsub(",.*","",genre_data)
head(genre_data)

#Convert to factor
genre_data = as.factor(genre_data)
head(genre_data)


#Combine into df
movies_df = data.frame(Rank = rank_data, Title=title_data,
                       Genre=genre_data,duration=runtime_data)

head(movies_df)
barplot(table(movies_df$Genre))

#######

#Extracting Text file from internet - MLK Speech
url = "https://www.americanrhetoric.com/speeches/mlkihaveadream.htm"

#reading HTML code - XML
speechage = read_html(url)

text = html_nodes(speechpage,"p:nth-child(25) font")
#we chose a specific paragraph for this ^^^

#######

#Amazon
url='https://www.amazon.com/s/ref=s9_acss_bw_cts_AEElectr_T1_w?fst=as%3Aoff&amp;rh=n%3A172282%2Cp_n_shipping_option-bin%3A3242350011%2Cn%3A!493964%2Cn%3A281407&amp;bbn=493964&amp;ie=UTF8&amp;qid=1486423355&amp;rnid=493964&amp;pf_rd_m=ATVPDKIKX0DER&amp;pf_rd_s=merchandised-search-2&amp;pf_rd_r=T4ZYS36GSBSEG19XNG8Q&amp;pf_rd_t=101&amp;pf_rd_p=68fb4935-984a-403b-821e-a22c44e9af5a&amp;pf_rd_i=16225009011%27'
url='https://www.amazon.com/s/ref=s9_acss_bw_cts_AEElectr_T1_w?fst=as%3Aoff&rh=n%3A172282%2Cp_n_shipping_option-bin%3A3242350011%2Cn%3A!493964%2Cn%3A281407&bbn=493964&ie=UTF8&qid=1486423355&rnid=493964&pf_rd_m=ATVPDKIKX0DER&pf_rd_s=merchandised-search-2&pf_rd_r=T4ZYS36GSBSEG19XNG8Q&pf_rd_t=101&pf_rd_p=68fb4935-984a-403b-821e-a22c44e9af5a&pf_rd_i=16225009011'  
webpage <- read_html(url)  
allpdts_data_html <- html_nodes(webpage,".a-color-base.a-text-normal")  
allpdts_data <- html_text(allpdts_data_html)  
df <- do.call("rbind", lapply(allpdts_data, as.data.frame))  
View(df)
          
#Reviews
url='https://www.amazon.ae/Sony-PlayStation-500GB-Wireless-Controllers/dp/B07NY2V5B4/ref=sr_1_1?crid=26M7JGJJTFWND&keywords=sony+playstation+4&qid=1557737393&s=gateway&sprefix=sony+playstation%2Caps%2C243&sr=8-1'  
webpage <- read_html(url)  
review_data_html <- html_nodes(webpage,".a-expander-partial-collapse-content")  
review_data <- html_text(review_data_html)  
df <- do.call("rbind", lapply(review_data, as.data.frame))  
View(df)

#Review Stars Rating
review_star_html = html_nodes(webpage,'.review-rating')
class(review_star_html)

rank_data=html_text(review_star_html)
class(rank_data)

head(rank_data)