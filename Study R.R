source('Study.R',encoding = 'UTF-8')
install.packages("tidyverse")
library(tidyverse)
ggplot2::mpg
#1.2.2　创建ggplot图形
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) #displ放在x轴，hwy放在y轴：
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))#点的颜色class，揭示每辆汽车的类型
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)#分割成多个分面，显示数据子集，适合分类变量
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )+geom_point(mapping = aes(x = displ, y = hwy, color = drv))
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth()
demo <- tribble(
  ~a, ~b,
  "bar_1", 20,
  "bar_2", 30,
  "bar_3", 40
)
ggplot(data = demo) +
  geom_bar(
    mapping = aes(x = a, y = b), stat = "identity"
  )
#1.7绘制条形�?
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop..,group = 1))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, color = cut))
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))
#dodge分组绘制条形图比较各组的count
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity),position = "dodge")
#1.9坐标�?  
#绘制箱式�?
ggplot(data=mpg,mapping = aes(x = class, y = hwy))+geom_boxplot() 
#�?2�? 基础运算
#赋值语�? 用Alt�?-
this_is_a_really_long_name <- 2.5
#调用函数
seq(1,10)#生成数值序�?
y <- seq(1,10,length.out = 5)
y
#Alt+Shift+K呼出快捷键菜单栏
#�?3�? dplyr数值转�?
library(nycflights13)
library(tidyverse)
flights
#按条件筛选出观测子集
filter(flights,month==1, day==1)
(jan1 <- filter(flights,month==1,day==1))
near(sqrt(2)^2,2)

#&表示“与”、| 表示“或”�?! 表示“非�?
filter(flights,month==11 | month==12)#找出11 月或12 月出发的所有航�?
#  x %in% y ,这会选取出x 是y 中的一个值时的所有行
nov_dec <- filter(flights,month %in% c(11,12))
nov_dec
filter(flights,!(arr_delay>120 | dep_delay>120))#延误时间不多�?2小时的航�?
filter(flights,arr_delay<=120 | dep_delay<=120)
#练习
filter(flights,!arr_delay<2)#到达时间延误2 小时或更多的航班
filter(flights,dest == "IAH" | dest == "HOU")#飞往休斯顿（IAH 机场或HOU 机场）的航班
filter(flights,carrier %in% c("UA","AA","DL"))#由United、American、Delta运营的航�?
filter(flights,month %in% c(6,7,8))#夏季�?7 月�?8 月和9 月）出发的航�?
flights$sched_dep_time
?between
is.na(flights$dep_time)
#3.3 arrange函数
arrange(flights, year,month,day)#从小到大，升序排�?
arrange(flights,desc(arr_delay))#desc() 可以按列进行降序排序
df <- tibble(x = c(5,2,NA)) 
#练习
arrange(flights, desc(is.na(dep_time))) #使用is.na()将缺失值排在最前面
#对flights 排序以找出延误时间最长的航班。找出出发时间最早的航班
head(arrange(flights, desc(dep_delay)), 1)
head(arrange(flights,dep_delay))#提前出发就是出发时间最�?
#对flights 排序以找出速度最快的航班
head(arrange(flights,desc(distance / air_time)))
#哪个航班的飞行时间最长？哪个最短？
head(arrange(flights,air_time))
head(arrange(flights,desc(air_time)))
#3.4使用select()选择�?
select(flights, year, month, day)# 按名称选择�?
select(flights,!(year:day))# 选择不在“year”和“day”之间的所有列
rename(flights,tail_num = tailnum)#重新命名变量
select(flights,time_hour,day,everything())#保持其他变量不变，插入几个变量移到数据框开�?
#练习
colnames(flights)#查看变量�?
head(select(flights, dep_time, dep_delay, arr_time, arr_delay))#方式一
head(flights[c("dep_time", "dep_delay", "arr_time", "arr_delay")])#方式�?
head(select(flights, 4, 6, 7, 9))#方式�?
head(flights[c(4, 6, 7, 9)])#方法�?
head(select(flights, all_of(c("dep_time", "dep_delay", "arr_time", "arr_delay"))))#方法�?
head(select(flights, any_of(c("dep_time", "dep_delay", "arr_time", "arr_delay"))))#方法�?
#one_of() 函数结合select使用
vars <- c(  "year", "month", "day", "dep_delay", "arr_delay")
select(flights,one_of(vars))
#contains默认忽略大小�?
select(flights, contains("TIME"))
#3.5使用mutate()添加新变�?
#3.5.1新建数据集flights_sml 
flights_sml <- select(flights,year:day,ends_with("delay"),distance,air_time)
#运算并赋值新的变量gain和speech
mutate(flights_sml,gain = arr_delay - dep_delay,speed = distance / air_time * 60)
#进一步运算gain和speed并赋值新变量gain_per_hour
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours)
#只保留新变量
transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours)
#除法的运�?%/%（整数除法）�?%%（求余）
transmute(flights,dep_time,hour = dep_time%/%100,minutes = dep_time%%100)
#补充：mutate()和逻辑判断函数ifelse一起创造新变量
mutate(flights, type = ifelse(distance < 1000, 'close', 'far'))
#练习
transmute(flights,dep_time,sched_dep_time,dep_minutes = dep_time%%100+dep_time%/%100*60,sched_minutes = sched_dep_time%%100 + sched_dep_time%/%100 * 60)
transmute(flights, air_time, var = arr_time - dep_time)
arrange(transmute(flights,dep_rank = min_rank(desc(dep_time)),10))
#3.6　使用summarize()进行分组摘要
summarise(flights,delay=mean(dep_delay,na.rm = TRUE))
#按日期分�?
by_day <- group_by(flights,year,month,day)
summarise(by_day,delay = mean(dep_delay,na.rm=TRUE))#按日期分组后的平均延误时�?
#按目的地机场分组
by_dest <- group_by(flights,dest)
delay <- summarise(by_dest,
                   count=n(),
                   dist=mean(distance,na.rm = TRUE),
                   delay=mean(arr_delay,na.rm = TRUE))
delay <- filter(delay,count>20,dest!="HNL")
ggplot(data = delay,mapping = aes(x=dist,y=delay))+
  geom_point(aes(size=count),alpha=1/3)+
  geom_smooth(se=FALSE)
#(1) 按照目的地对航班进行分组�?
#(2) 进行摘要统计，计算距离、平均延误时间和航班数量�?
#(3) 通过筛选除去噪声点和火奴鲁鲁机�?
delays <- flights %>%
  group_by(dest) %>%
  summarise(
    count=n(),
    dist=mean(distance,na.rm = TRUE),
    delay=mean(arr_delay,na.rm = TRUE)
    )%>%
    filter(count>20,dest!="HNL")
#3.6.2　缺失�?
#在计算前除去缺失值然后分组摘要平均延误时�?
flights %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay,na.rm=TRUE))
#先排空再分组摘要平均延误时间
not_cancelled <- flights%>%
  filter(!is.na(dep_delay),!is.na(arr_delay))
not_cancelled%>%
  group_by(year,month,day)%>%
  summarize(mean(dep_delay))
#3.6.3　计数
#最长平均延误时间的飞机（通过机尾编号进行识别�?
delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarize(delay = mean(arr_delay))
ggplot(data = delays, mapping = aes(x = delay)) +
  geom_freqpoly(binwidth = 10)
#航班数量n和平均延误时间delay的散点图
delays <- not_cancelled%>%
  group_by(tailnum)%>%
  summarize(delay=mean(arr_delay,na.rm=TRUE),n=n())
ggplot(data=delays,mapping = aes(x = n,y = delay))+
  geom_point(alpha=1/10)
#筛选掉那些观测数量n非常少的分组,并通过%>%将ggplot2集成到dplyr�?
delays %>% filter(n > 25) %>%
  ggplot(mapping = aes(x = n,delay))+
  geom_point(alpha=1/10)
#3.6.4　常用的摘要函�?
not_cancelled%>%
  group_by(year,month,day)%>%
  summarize(
    # 平均延误时间�?
    avg_delay1 = mean(arr_delay),
    # 平均正延误时间：
    avg_delay2 = mean(arr_delay[arr_delay>0])
    )
# 为什么到某些目的地的距离比到其他目的地更多变？按机场分组计算distance的标准差
not_cancelled%>%
  group_by(dest)%>%
  summarize(distance_sd = sd(distance))%>%
  arrange(desc(distance_sd))
# 每天最早和最晚的航班何时出发�?
not_cancelled%>%
  group_by(year,month,day)%>%
  summarise(
    first = min(dep_time),
    last = max(dep_time))
not_cancelled%>%
  group_by(year,month,day)%>%
  summarise(
    first_dep = first(dep_time),
    last_dep = last(dep_time))
# 哪个目的地具有最多的航空公司？n_distinct(x)计算出唯一值的数量
not_cancelled %>%
  group_by(dest) %>%
  summarize(carriers = n_distinct(carrier)) %>%
  arrange(desc(carriers))
# 多少架航班是在早�?5点前出发�?
not_cancelled%>%
  group_by(year,month,day)%>%
  summarise(n_early = sum(dep_time<500))
# 延误超过1小时的航班比例是多少�?
not_cancelled%>%
  group_by(year,month,day)%>%
  summarise(hour_per=mean(arr_delay>60))
#3.6.5　按多个变量分�?
daily <- group_by(flights,year,month,day)
(per_day <- summarise(daily,flights=n()))
(per_month <- summarise(per_day,flights=sum(flights)))
(per_year <- summarize(per_month, flights = sum(flights)))
#取消分组
daily %>%
  ungroup() %>% # 不再按日期分�?
  summarize(flights = n()) # 所有航�?
#3.6.7练习
not_cancelled %>% count(dest) 
not_cancelled %>% count(tailnum, wt = distance)
not_cancelled%>%
  group_by(dest)%>%
summarise(n=n())
#3.7
flights_sml%>%
  group_by(year,month,day)%>%
  filter(rank(desc(arr_delay))<10)
#找出大于某个阈值的所有分�?
popular_dests <- flights%>%
  group_by(dest)%>%
  filter(n()>365)
popular_dests %>%
  filter(arr_delay > 0) %>%
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>%
  select(year:day, dest, arr_delay, prop_delay)
#�?5�?
library(tidyverse)
#对连续型变量查看频率分布情况
diamonds%>%count(cut_width(carat,0.5))
#绘制直方图，描述变量在不同组段内的频�?
ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat), binwidth = 0.1)# binwid是x轴间隔参�?
#重量小于3 克拉的钻�?
smaller <- diamonds%>%filter(carat<3)
ggplot(data = smaller, mapping = aes(x = carat))+geom_histogram(binwidth = 0.1)
#绘制折线�?
ggplot(data = smaller, mapping = aes(x = carat,color=cut))+
  geom_freqpoly(binwidth=0.1)
#coord_cartesian中的ylim用于放大靠近y轴的数据
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50))
unusuall <- diamonds%>%
  filter(y<5 | y>20)%>%
  arrange(y)
unusuall
#练习
ggplot(data=diamonds)+geom_histogram(mapping = aes(x=price),binwidth = 2000)
diamonds%>%count(cut_width(price,2000))
ggplot(diamonds) + geom_density(aes(z))
head(diamonds)
diamonds %>%
  mutate(id = row_number()) %>%
  select(x, y, z, id) %>%
  gather(variable, value, -id)  %>%
  ggplot(aes(x = value)) +
  geom_density() +
  geom_rug() +
  facet_grid(variable ~ .)
#price的分�?
head(diamonds)
diamonds  %>% ggplot() + geom_histogram(aes(price),binwidth = 10)
#选取<2500的price分布
ggplot(filter(diamonds,price<2500)) + geom_histogram(aes(price),binwidth = 10)
#0.99 克拉的钻石有多少�? 1 克拉的钻石有多少�?
head(diamonds)
diamonds %>% filter(carat >= 0.99, carat <= 1) %>% count(carat)
# 发现0.99的比较少，是因为0.01的差别，1克拉卖的比较贵吗？可以看下其他类型的数量
diamonds %>% filter(carat >= 0.9, carat <= 1.1) %>%
  count(carat) %>% print(n=30)
#5.4　缺失�?
#使用缺失值来代替异常�?,逻辑判断函数ifelse
diamonds2 <- diamonds%>%
  mutate(y = ifelse(y<3|y>20,NA,y))
ggplot(diamonds2,mapping = aes(x=x,y=y))+geom_point(na.rm = TRUE)
#比较已取消航班和未取消航班的计划出发时间
nycflights13::flights %>%
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>%
  ggplot(mapping = aes(sched_dep_time)) +
  geom_freqpoly(
    mapping = aes(color = cancelled),
    binwidth = 1/4
  )

q()

