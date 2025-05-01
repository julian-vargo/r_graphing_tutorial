# R Graphing Tutorial Demo Script
# Julian Vargo (2025)
# Department of Spanish & Portuguese
# University of California, Berkeley

###################

# If you want to clear your environment before starting
rm(list = ls())

# Let's first begin by loading in the required packages
# install.packages("readr")
# install.packages("ggplot2")
# install.packages("mgcv")
# install.packages("ggthemes")
# install.packages("plotly")
# install.packages("gganimate")
# install.packages("dplyr")
# install.packages("maps")
# install.packages("ggtext")
library(readr) #this package allows us to install csv's online
library(ggplot2) #this package let's us graph - yippeee!
library(mgcv) #if you're making gam's to plot smooth curves, this will give you some more flexibility
library(ggthemes) # additional themes and color palettes
library(plotly) # 3d graphing, additional geoms, animations
library(gganimate) # animations
library(dplyr) # piping, summaries, lots of stuff
library (maps) # loads in lots of map outline data
library(ggtext) # Allows you to create text geoms anywhere

# Now let's load in all of our datasets, you can do this manually or with an internet connection
# Disclaimer: all of the data in this tutorial is fabricated, so use this graphs for inspirational purposes only.
krio_heritage_vowels <- read_csv("https://raw.githubusercontent.com/julian-vargo/r_graphing_tutorial/refs/heads/main/test_datasets/krio_heritage_vowels_scatterplot.csv")
spanish_nasal_stops <- read_csv("https://raw.githubusercontent.com/julian-vargo/r_graphing_tutorial/refs/heads/main/test_datasets/us_spanish_nasal_stops_violin.csv")
venezuelan_liquid_trajectories <- read_csv("https://raw.githubusercontent.com/julian-vargo/r_graphing_tutorial/refs/heads/main/test_datasets/venezuelan_liquid_trajectories_quantile_smooth.csv")
mexican_seloismo <- read_csv("https://raw.githubusercontent.com/julian-vargo/r_graphing_tutorial/refs/heads/main/test_datasets/mexican_seloismo_histogram.csv")
secret_message <- read_csv("https://raw.githubusercontent.com/julian-vargo/r_graphing_tutorial/refs/heads/main/test_datasets/secret_message_scatterplot.csv")
pitch_contour <- read_csv("https://raw.githubusercontent.com/julian-vargo/r_graphing_tutorial/refs/heads/main/test_datasets/pitch_countour_gam.csv")
romanian_want <- read_csv("https://raw.githubusercontent.com/julian-vargo/r_graphing_tutorial/refs/heads/main/test_datasets/romanian_want.csv")
dataset4answer <- "https://raw.githubusercontent.com/julian-vargo/r_graphing_tutorial/refs/heads/main/test_datasets/dataset4answer.txt"
dataset4answer <- readLines(dataset4answer, warn = FALSE)
catalan_laterals <- read_csv("https://raw.githubusercontent.com/julian-vargo/r_graphing_tutorial/refs/heads/main/test_datasets/catalan_laterals.csv")

####################
## UNIT 1: BASICS ##
####################

## DATASET 0: SECRET MESSAGE
# Let's start with a warmup - we have a secret message that we want to decode
# We have two layers, ggplot() and geom_point()
secret_message_plot <- ggplot(secret_message, aes(x=x, y=y)) +
geom_point()
print(secret_message_plot)

# Let's try out geom quantile (this finds trend lines)
plot <- ggplot(secret_message, aes(x=x, y=y)) +
geom_quantile()
print(plot)

plot <- ggplot(secret_message, aes(x=x, y=y)) +
geom_quantile() + geom_point()
print(plot)

plot <- ggplot(secret_message, aes(x=x, y=y)) +
geom_quantile(quantiles = 0.5) + geom_point()
print(plot)

# Now let's try out the "rug" geom
plot <- ggplot(secret_message, aes(x=x, y=y)) +
geom_rug(sides = "bl")
print(plot)

plot <- ggplot(secret_message, aes(x=x, y=y)) +
geom_rug(sides = "bl") + geom_point()
print(plot)

# Let's try out the "smooth" geom
plot <- ggplot(secret_message, aes(x=x, y=y)) +
geom_smooth(method = "lm") + geom_point()
print(plot)

## DATASET 1: KRIO HERITAGE SPEAKER VOWEL SPACE
# Now let's move onto some linguistic data
krio_plot <- ggplot(krio_heritage_vowels, aes(x=inverse_f2, y=inverse_f1, color = speaker_group))
krio_plot <- krio_plot + geom_point()
print(krio_plot)

# Agh, that's a really ugly graph, let's give it a clean, modern theme
krio_plot <- krio_plot + theme_minimal()
print(krio_plot)

## DATASET 2: U.S. SPANISH NASAL STOPS
# Now that we know how to do dotplots, let's try another set of graphs, boxplots and violin plots
nasal_plot <- ggplot(spanish_nasal_stops, aes(x = place_of_articulation, y = f2, color = ""))
nasal_plot <- nasal_plot + geom_boxplot()
nasal_plot <- nasal_plot + theme_minimal()
print(nasal_plot)

# Let's make the outlines black but the color differ based on the place of articulation
nasal_plot <- ggplot(spanish_nasal_stops,
aes(x = place_of_articulation, y = f2,fill = place_of_articulation))
nasal_plot <- nasal_plot + geom_boxplot()
nasal_plot <- nasal_plot + theme_minimal()
print(nasal_plot)

# Maybe violin plots are more of your speed - if so then substitute geom_boxplot for geom_violin
nasal_plot <- ggplot(spanish_nasal_stops, 
aes(x = place_of_articulation, y = f2,fill = place_of_articulation))
nasal_plot <- nasal_plot + geom_violin()
nasal_plot <- nasal_plot + theme_minimal()
print(nasal_plot)

# Bar charts via geom_col, requires plotting the mean value and then setting the geom inside of the stat layer
plot <- ggplot(spanish_nasal_stops, aes(x = place_of_articulation, y = f2, fill = place_of_articulation)) +
  stat_summary(fun = mean, geom = "col") +
  theme_minimal()
print(plot)

# Let's add error bars, we do this by creating two simultaneous geom layers
# But first, we need to calculate the mean and sd's for our data
spanish_nasal_summary <- spanish_nasal_stops %>%
group_by(place_of_articulation) %>%
mutate(mean_f2 = mean(f2, na.rm = TRUE),
sd_f2 = sd(f2, na.rm = TRUE)) %>%
ungroup()

plot <- ggplot(spanish_nasal_summary, aes(x = place_of_articulation, y = f2, fill = place_of_articulation)) +
  geom_errorbar(aes(ymin = mean_f2 - sd_f2, ymax = mean_f2 + sd_f2), width = 0.2) +
  stat_summary(fun = mean, geom = "col", alpha = 0.5) +
  theme_minimal()
print(plot)

## DATASET 3: PITCH CONTOURS
# To make the "smooth" geom use a curved line, use "loess" (logistically estimated scatterplot smoothing)
plot <- ggplot(pitch_contour, aes(x=time, y=pitch, group = speaker, colour = speaker)) +
geom_smooth(method = "loess") + geom_point()
print(plot)

# To make the "smooth" geom use a curved line, use "gam" (generalized additive model)
plot <- ggplot(pitch_contour, aes(x=time, y=pitch, group = speaker, colour = speaker)) +
geom_smooth(method = "gam") + geom_point()
print(plot)

# If you want to increase the "precision" of the gam, then let's introduce a new metric "k"
plot <- ggplot(pitch_contour, aes(x=time, y=pitch, group = speaker, colour = speaker)) +
geom_smooth(method = "gam", formula = y ~ s(x, k = 20)) + 
geom_point()
print(plot)

# The higher we turn up our "k", the more the line conforms to the data
plot <- ggplot(pitch_contour, aes(x=time, y=pitch, group = speaker, colour = speaker)) +
  geom_smooth(method = "gam", formula = y ~ s(x, k = 40)) + 
  geom_point()
print(plot)

# Let's reveal the line underneath without the scatterplot
plot <- ggplot(pitch_contour, aes(x=time, y=pitch, group = speaker, colour = speaker)) +
  geom_smooth(method = "gam", formula = y ~ s(x, k = 40))
print(plot)

## DATASET 4: MEXICAN SELOISMO
# Let's make some histograms to examine usage of seloismo
plot <- ggplot(mexican_seloismo, aes(x= age, y=number_of_speakers)) +
  geom_col() +
  coord_cartesian(xlim=c(18,80))
print(plot)

# as a side note, use geom_histogram if you have hundreds of rows,
# r will automatically add up the values for you
# today we are using geom_col since we've already calculated the frequency in the y column

# Let's group by variant and make the plot semi-transparent so everything is interpretable
plot <- ggplot(mexican_seloismo, aes(x= age, y=number_of_speakers)) +
  geom_col(pos = "identity", alpha = 0.5, aes(fill = variant)) +
  coord_cartesian(xlim=c(18,80)) +
  theme_minimal()
print(plot)

## DATASET 5: FACETING WITH ROMANIAN VERBS

# Let's group by task type, with 3 columns
plot <- ggplot(romanian_want, aes(x=gender, y=number_of_dori))
plot <- plot + geom_col()
plot <- plot + facet_grid(.~ task_type)
print(plot)

plot <- ggplot(romanian_want, aes(x=gender, y=number_of_dori))
plot <- plot + geom_col()
plot <- plot + facet_grid(task_type ~.)
print(plot)

plot <- ggplot(romanian_want, aes(x=gender, y=number_of_dori))
plot <- plot + geom_col()
plot <- plot + facet_grid(education_level ~ task_type)
print(plot)

plot <- ggplot(romanian_want, aes(x=gender, y=number_of_dori))
plot <- plot + geom_col()
plot <- plot + facet_wrap(~ education_level)
print(plot)

## DATASET 6: TEST!!!
# Graph two lines that show the formant trajectories of Venezuelan liquids over time

# Only run the command if you are ready for the answer!
print(dataset4answer)

#################################################
## UNIT 2: PLOTTING A HIGH QUALITY VOWEL CHART ##
#################################################

# We're going to be working with real, high quality data.
data <- read_csv("https://raw.githubusercontent.com/julian-vargo/r_graphing_tutorial/refs/heads/main/test_datasets/muhsic_vowels.csv")

plot <- ggplot(data, aes(x = f2_50, y = f1_50)) + geom_point()
print(plot)

# That graph stinks! Let's narrow down our dataset
vowels <- data %>% filter(manner == "vowel", tenseness != "diphthong", stress == "primary")

#Gather the median f1, f2, f3 and then use the pythagorean theorem to calculate the distance from centroid
f1_centroid = median(vowels$f1_50)
f2_centroid = median(vowels$f2_50)
distance_from_centroid = sqrt((vowels$f1_50 - f1_centroid)^2 + (vowels$f2_50 - f1_centroid)^2)

# Add a new column to our sheet
vowels$distance_from_centroid = distance_from_centroid

# Set the threshold for removal by using 2 standard deviations
outlier_limit <- sd(vowels$distance_from_centroid, na.rm = TRUE) * 2

# Filter out vowels that are outliers greater than 2 std devs from centroid
vowels <- vowels %>% filter(distance_from_centroid < outlier_limit)

plot <- ggplot(vowels, aes(x = f2_50, y = f1_50))
plot <- plot + geom_point()
plot <- plot + theme_minimal()
print(plot)

# Oh no! That was no good. We removed vowels that were really far from schwa.
# We have to group by phoneme, so edge phonemes like /i/ and /a/ don't get removed.
vowels <- data %>% filter(manner == "vowel", tenseness != "diphthong", stress == "primary", phoneme != "ER")
vowels <- vowels %>%
  group_by(phoneme) %>%
  mutate(
    f1_centroid = median(f1_50, na.rm = TRUE),
    f2_centroid = median(f2_50, na.rm = TRUE),
    distance_from_centroid = sqrt(
      (f1_50 - f1_centroid)^2 + 
      (f2_50 - f2_centroid)^2),
    outlier_limit = sd(distance_from_centroid, na.rm = TRUE)
  ) %>%
  filter(distance_from_centroid < outlier_limit) %>%
  ungroup()

plot <- ggplot(vowels, aes(x = f2_50, y = f1_50))
plot <- plot + geom_point()
print(plot)

# That outlier removal was much better, so now we can customize our graph
plot <- ggplot(vowels, aes(x = f2_50, y = f1_50, color = phoneme)) +
  geom_point(alpha = 0.5) +
  scale_x_reverse() +
  scale_y_reverse() +
  theme_minimal() +
  labs(x = "F2 Midpoint", y = "F1 Midpoint", fill = "Phoneme", color = "Phoneme")

print(plot)

# Let's add some labels, which will be placed at the centroid of each vowel
centroids <- vowels %>%
  group_by(phoneme) %>%
  summarise(
    f1_mean = mean(f1_50, na.rm = TRUE),
    f2_mean = mean(f2_50, na.rm = TRUE))

# You'll get a warning message here about the colour palette not being sufficient.
# The dataset contains 9 vowels but the palette only supports 8 colours, so /u/ gets chopped off.
plot <- ggplot(vowels, aes(x = f2_50, y = f1_50, color = phoneme)) +
  geom_point(alpha = 0.1) +
  stat_ellipse(aes(group = phoneme, fill = phoneme),
               geom = "polygon", alpha = 0.1, level = 0.75) + 
  geom_label(data = centroids, aes(x = f2_mean, y = f1_mean, label = phoneme, fill = phoneme), 
             color = "white", fontface = "bold", alpha = 0.8) +
  scale_x_reverse() +
  scale_y_reverse() +
  theme_minimal() +
  scale_fill_colorblind() +
  scale_color_colorblind() +
  labs(x = "F2 Midpoint", y = "F1 Midpoint", fill = "Phoneme", color = "Phoneme")

print(plot)

# To make your own palette, use cbind and hex codes. Alternatively, ggplot supports a handful of preset colours.
custom_palette <- c(
  "AA" = "#1f77b4",
  "AE" = "#ff7f0e",
  "AH" = "#2ca02c",
  "AO" = "#d62728",
  "EH" = "#9467bd",
  "IH" = "#8c564b",
  "IY" = "#e377c2",
  "UH" = "#7f7f7f",
  "UW" = "#bcbd22"
)

# With our 9-colour palette
plot <- ggplot(vowels, aes(x = f2_50, y = f1_50, color = phoneme)) +
  geom_point(alpha = 0.1) +
  stat_ellipse(aes(group = phoneme, fill = phoneme),
               geom = "polygon", alpha = 0.1, level = 0.75) + 
  geom_label(data = centroids, aes(x = f2_mean, y = f1_mean, label = phoneme, fill = phoneme), 
  color = "white", fontface = "bold", alpha = 0.8) +
  scale_x_reverse() +
  scale_y_reverse() +
  guides(fill = guide_legend(override.aes = list(
  label = c("AA", "AE", "AH", "AO", "EH", "IH", "IY", "UH", "UW"),
  colour = "white"))) +
  theme_minimal() +
  scale_fill_manual(values = custom_palette)+
  scale_color_manual(values = custom_palette)

print(plot)

###########################
## UNIT 3: PLOTTING MAPS ##
###########################

# We have to load in some geolocation data
# We have the degree of raising for several participants, and the latitude and longitude of the sociolinguistic data

washington_data <- read_csv("https://raw.githubusercontent.com/julian-vargo/r_graphing_tutorial/refs/heads/main/test_datasets/washington_data_map.csv")
us_states <- map_data("state")
washington_outline <- subset(us_states, region == "washington")

# Try playing around with various settings to get a feel for what each command does.
ggplot() +
geom_polygon(data = washington_outline, aes(x = long, y = lat, group = group),
fill = NA, color = "darkgrey", size = 0.75) +
geom_point(data = washington_data, position="jitter",
aes(x = longitude, y = latitude, color = degree_of_raising, alpha = .1)) +
scale_color_viridis_c(option = "viridis") +
coord_fixed(1.3) +
theme_minimal() +
labs(title = "Washington Cities by degree of 'egginess'",
x = "Longitude",
y = "Latitude",
color = "Degree of raising") + 
#theme(axis.text = element_blank(),axis.ticks = element_blank(),panel.grid = element_blank()) +
labs(x="Longitude",y="Latitude woohoo")

####################################
## UNIT 4: LABELS & CUSTOMIZATION ##
####################################

# Try playing around with the theme and label settings!

ggplot(catalan_laterals, aes(x = lightness, fill = language, color = language)) +
  geom_histogram(position = "identity", alpha = 0.3, bins = 60) +
  theme_minimal() +
  labs(
    title = "Lateral lightness by Language",
    subtitle = "By piRates of Span 209",
    caption = "Figure 1. Really cool graph",
    fill = "Language Type"
  )

ggplot(catalan_laterals, aes(x = lightness, fill = language, color = language)) +
  geom_histogram(position = "identity", alpha = 0.3, bins = 60) +
  theme_minimal() +
  labs(
    title = "Lateral lightness by Language",
    subtitle = "By piRates of Span 209",
    caption = "Figure 1. Really cool graph"
  )+
  theme(legend.position = c(0.85, 0.8))

new_catalan_laterals <- c(catalan = "Catalan")

ggplot(catalan_laterals, aes(x = lightness, fill = language, color = language)) +
  geom_histogram(position = "identity", alpha = 0.3, bins = 60) +
  theme_minimal() +
  labs(
    title = "Lateral lightness by Language",
    subtitle = "By piRates of Span 209",
    caption = "Figure 1. Really cool graph",
    fill = "Language Type")+
  theme(legend.position = c(0.8, 0.2))+
  geom_textbox(
    aes(x = 5, y = 5, label = "**Catalan**"),
    width = unit(6, "cm"),
    fill = "lightblue",
    box.color = "gray40",
    size = 4,
    hjust = 0
    )

