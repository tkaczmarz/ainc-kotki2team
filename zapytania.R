library(ggplot2)

library(ggmap)

library(shadowtext)

options(scipen=5)


## ZAPYTANIE 1

## 50 najbardziej popularnych lotnisk - wg. liczby pasa¿erów

plik =  'wynik1plot.csv'

podtytul = 'by the sum of passengers'



# read data

data = data.frame(read.table(plik))[c(2,4)]

limit = nrow(data)

tytul = sprintf('Top %i most popular airports', limit)



# rename columns

colnames(data) = c('ID', 'Sum')



# sort factor cities by frequency

data$ID = factor(data$ID, levels = data$ID[order(data$Sum, decreasing = T)])



png('images/plot1.png',width=800,height=600) 



# barplot

ggplot(data=data, aes(x=ID, y=Sum)) +

  geom_bar(stat="identity", fill='steelblue') +

  theme(axis.text.x = element_text(angle = 90, hjust = 1),

        axis.ticks=element_blank(),

        axis.title.x=element_blank(), axis.title.y=element_blank(),

        plot.title = element_text(size=22),

        plot.subtitle = element_text(size=15)) +

  scale_y_continuous(expand = c(0,0)) + 

  ggtitle(tytul, subtitle = podtytul)

dev.off()

## ZAPYTANIE 2

## 50 najbardziej popularnych lotnisk - wg. liczby lotów

plik =  'wynik2plot.csv'

podtytul = 'by the sum of flights'



# read data

data = data.frame(read.table(plik))[c(2,4)]

limit = nrow(data)

tytul = sprintf('Top %i most popular airports', limit)



# rename columns

colnames(data) = c('ID', 'Sum')



# sort factor cities by frequency

data$ID = factor(data$ID, levels = data$ID[order(data$Sum, decreasing = T)])


png('images/plot2.png',width=800,height=600) 



# barplot

ggplot(data=data, aes(x=ID, y=Sum)) +

  geom_bar(stat="identity", fill='steelblue') +

  theme(axis.text.x = element_text(angle = 90, hjust = 1),

        axis.ticks=element_blank(),

        axis.title.x=element_blank(), axis.title.y=element_blank(),

        plot.title = element_text(size=22),

        plot.subtitle = element_text(size=15)) +

  scale_y_continuous(expand = c(0,0)) + 

  ggtitle(tytul, subtitle = podtytul)

dev.off()



## ZAPYTANIE 3

## Liczba pasa¿erów z lotniska Atlanta wg. lat

plik =  'wynik3plot.csv'

tytul = 'Number of passengers by years'

podtytul = 'from Atlanta airport'



# read data

data = data.frame(read.table(plik))[c(5,7)]



# rename columns

colnames(data) = c('ID', 'Sum')



# sort factor cities by frequency

data$ID = factor(data$ID, levels = data$ID[order(data$Sum, decreasing = T)])


png('images/plot3.png',width=800,height=600) 



# barplot

ggplot(data=data, aes(x=ID, y=Sum)) +

  geom_bar(stat="identity", fill='steelblue') +

  theme(

    #axis.text.x = element_text(angle = 90, hjust = 1),

    axis.ticks=element_blank(),

    axis.title.x=element_blank(), axis.title.y=element_blank(),

    plot.title = element_text(size=22),

    plot.subtitle = element_text(size=15)) +

  scale_y_continuous(expand = c(0,0)) + 

  ggtitle(tytul, subtitle = podtytul)

dev.off()


## ZAPYTANIE 4

## Liczba lotów z lotniska Atlanta wg. lat



plik =  'wynik4plot.csv'

tytul = 'Number of flights by years'

podtytul = 'from Atlanta airport'



# read data

data = data.frame(read.table(plik))[c(5,7)]



# rename columns

colnames(data) = c('ID', 'Sum')



# sort factor cities by frequency

data$ID = factor(data$ID, levels = data$ID[order(data$Sum, decreasing = T)])


png('images/plot4.png',width=800,height=600) 



# barplot

ggplot(data=data, aes(x=ID, y=Sum)) +

  geom_bar(stat="identity", fill='steelblue') +

  theme(

    #axis.text.x = element_text(angle = 90, hjust = 1),

    axis.ticks=element_blank(),

    axis.title.x=element_blank(), axis.title.y=element_blank(),

    plot.title = element_text(size=22),

    plot.subtitle = element_text(size=15)) +

  scale_y_continuous(expand = c(0,0)) + 

  ggtitle(tytul, subtitle = podtytul)

dev.off()



## ZAPYTANIE 5

## Amerykañskie lotniska na mapie



plik =  'wynik5map.csv'

tytul = 'American airports on the map'



# read data

data = data.frame(read.table(plik))[c(3,5,7)]



# rename columns

colnames(data) = c('ID', 'lat', 'lon')



# map of the world

map_all = map_data("world")

colnames(map_all)[1] = 'lon'


png('images/plot5.png',width=800,height=600) 



# map plot

ggplot() + 

  geom_polygon(data = map_all, aes(x=lon, y=lat, group=group, fill=group)) +

  geom_point(data = data, aes(x=lon, y=lat), color='orange') +

  #scale_size(range = c(5, 10)) +

  geom_shadowtext(data=data, aes(x=lon, y=lat, label=ID), check_overlap = T, hjust=-0.2) +

  #geom_label(data=data, aes(x=lon, y=lat, label=City)) +

  theme(axis.line=element_blank(), axis.ticks=element_blank(),

        axis.text.x=element_blank(), axis.text.y=element_blank(),

        axis.title.x=element_blank(), axis.title.y=element_blank(),

        legend.position="none",

        plot.title = element_text(size=22)) +

  coord_cartesian(xlim = c(-160, -50), ylim = c(20, 70)) +

  ggtitle(tytul)

dev.off()


## ZAPYTANIE 6

## Najbardziej popularne loty

plik =  'wynik6map.csv'

limit = 20

tytul = sprintf('Top %i most popular routes', limit)

podtytul = 'by the number of flights in both directions'



# read data

data = data.frame(read.table(plik))[c(3, 5, 7, 9, 11, 13, 15)]



# rename columns

colnames(data) = c('from_ID', 'to_ID', 'from_lat', 'from_lon', 'to_lat', 'to_lon', 'Sum')



# remove flights where origin is destination

data = data[!((data$from_lat==data$to_lat) & (data$from_lon==data$to_lon)),]



# convert from_ID and to_ID from factors to character

data = transform(data, from_ID = as.character(data$from_ID), to_ID = as.character(data$to_ID))



# compare copy

data0 = data



# rearrange from_ID and to_ID alphabetically

data = transform(data, from_ID = pmin(from_ID, to_ID), to_ID = pmax(from_ID, to_ID))



# select the rows that has been rearranged

select = !data$from_ID==data0$from_ID

remove(data0)



# temporary data frame

tmp = data



# swap coordinates of rearranged rows

tmp[select,]$from_lat = data[select,]$to_lat

tmp[select,]$from_lon = data[select,]$to_lon

tmp[select,]$to_lat = data[select,]$from_lat

tmp[select,]$to_lon = data[select,]$from_lon

data = tmp

remove(tmp, select)



# aggregate by flights in both ways

data2 = aggregate(Sum ~ from_ID + to_ID, data, sum)



# add coordinates

data = merge(data, data2, by=c('from_ID', 'to_ID'))

remove(data2)



# remove duplcates

data = data[!duplicated(data[c("from_ID","to_ID")]), ]



# remove invalid column

data = data[-7]



# rename column

colnames(data)[7] = 'Sum'



# calculate longtitue distance for curvature

dist = abs(data$from_lon - data$to_lon)

dist = dist / max(dist)

data = data.frame(data, dist)



# sort by flights

data = data[order(data$Sum, decreasing = T),]



# limit data

data_all =

data = data[1:limit,]



# map of the world

map_all = map_data("world")

colnames(map_all)[1] = 'lon'


png('images/plot6.png',width=800,height=600) 


# map plot

ggplot() + 

  geom_polygon(data = map_all, aes(x=lon, y=lat, group=group, fill=group)) +

  geom_curve(data = data, color='orange', aes(x=from_lon, y=from_lat, xend=to_lon, yend=to_lat), size=1.2, curvature = 0.2) +

  geom_point(data = data, aes(x=from_lon, y=from_lat), color='darkorange', size=3) +

  geom_shadowtext(data=data, aes(x=from_lon, y=from_lat, label=from_ID), size=3, check_overlap = T, hjust=-0.2) +

  geom_point(data = data, aes(x=to_lon, y=to_lat), color='darkorange', size = 3) +

  geom_shadowtext(data=data, aes(x=to_lon, y=to_lat, label=to_ID), size=3, check_overlap = T, hjust=-0.2) +

  theme(axis.line=element_blank(), axis.ticks=element_blank(),

        axis.text.x=element_blank(), axis.text.y=element_blank(),

        axis.title.x=element_blank(), axis.title.y=element_blank(),

        legend.position="none",

        plot.title = element_text(size=22),

        plot.subtitle = element_text(size=15)) +

  coord_cartesian(xlim = c(-160, -50), ylim = c(20, 70)) +

  ggtitle(tytul, subtitle = podtytul)
dev.off()
