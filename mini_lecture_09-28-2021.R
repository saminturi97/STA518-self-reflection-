library(tidyverse)
library(gapminder)
gapminder

wide_measures <- gapminder %>% 
  filter(year == 1952) %>% 
  group_by(continent) %>% 
  summarise(
    med_LE = median(lifeExp),
    mean_LE = mean(lifeExp)
  )

wide_measures %>% 
  pivot_longer(
    cols = ends_with("_LE"),
    names_to = "measure",
    values_to = "values"
  ) %>% 
  ggplot(aes(x = continent, y = values,
             group = measure, color = measure)) +
  geom_line()

long_measures <- wide_measures %>% 
  pivot_longer(
    cols = ends_with("_LE"),
    names_to = "measure",
    values_to = "values"
  )

long_measures %>% 
  pivot_wider(
    names_from = continent,
    values_from = values
  )
