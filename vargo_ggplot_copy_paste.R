## R Graphing Copy-and-Paste
# Julian Vargo (2025)
# Department of Spanish & Portuguese
# University of California, Berkeley

###################

# Layer 1: ggplot()

ggplot(data = )


# Layer 2: geoms
geom_area(aes(x = , y = ))
geom_sf(aes())
geom_density(aes(x = ))
geom_sf_text(aes())
geom_dotplot(aes(x = ))
geom_sf_label(aes())
geom_freqpoly(aes(x = , y = ))
geom_contour(aes(x = , y = , z = ))
geom_histogram(aes(x = ))
geom_contour_filled(aes(x = , y = , z = ))
geom_qq(aes(sample = ))
geom_raster(aes(x = , y = , fill = ))
geom_bar(aes(x = , y = ))
geom_tile(aes(x = , y = , fill = ))
geom_label(aes(x = , y = , label = ))
geom_blank(aes(x = , y = ))
geom_point(aes(x = , y = ))
geom_curve(aes(x = , y = , xend = , yend = ))
geom_quantile(aes(x = , y = ))
geom_path(aes(x = , y = ))
geom_rug(aes(x = , y = ))
geom_polygon(aes(x = , y = ))
geom_smooth(aes(x = , y = ))
geom_rect(aes(xmin = , xmax = , ymin = , ymax = ))
geom_text(aes(x = , y = , label = ))
geom_ribbon(aes(x = , ymin = , ymax = ))
geom_col(aes(x = , y = ))
geom_abline(aes(intercept = , slope = ))
geom_boxplot(aes(x = , y = ))
geom_hline(aes(yintercept = ))
geom_dotplot(aes(x = ))
geom_vline(aes(xintercept = ))
geom_violin(aes(x = , y = ))
geom_segment(aes(x = , y = , xend = , yend = ))
geom_count(aes(x = , y = ))
geom_spoke(aes(x = , y = , angle = , radius = ))
geom_jitter(aes(x = , y = ))
geom_crossbar(aes(x = , ymin = , ymax = ))
geom_bin2d(aes(x = , y = ))
geom_errorbar(aes(x = , ymin = , ymax = ))
geom_density_2d(aes(x = , y = ))
geom_linerange(aes(x = , ymin = , ymax = ))
geom_density_2d_filled(aes(x = , y = ))
geom_errorbarh(aes(y = , xmin = , xmax = ))
geom_hex(aes(x = , y = ))
geom_area(aes(x = , y = ))
geom_linerange(aes(x = , ymin = , ymax = ))
geom_line(aes(x = , y = ))
geom_pointrange(aes(x = , ymin = , ymax = ))
geom_step(aes(x = , y = ))

# Layer 2.5: Positional Adjustments, not a layer, but part of a geom
position = "dodge"
position = "fill"
position = "identity"
position = "jitter"
position = "nudge"
position = "stack"
  #You can also adjust the width and height of your positional modifications
  position = position_dodge(width=1, height=2)

# Layer 3: Coordinate Function
coord_cartesian(xlim = , ylim = )
coord_fixed(ratio = , xlim = , ylim = )
coord_flip()
coord_polar(theta = , start = , direction = )
coord_trans(x = , y = , xlim = , ylim = )
coord_quickmap()
coord_map(projection = "ortho", orientation = c(41, -74, 0))

# Layer 4: Faceting (printing multiple graphs)
facet_grid(cols = vars(IV))
facet_grid(rows = vars(IV))
facet_wrap(vars(IV))
  # You can also use the less intuitive ~. notation
  facet_grid(IV ~.)
  facet_grid(.~ IV)

# Layer 5: Labels and Legends
labs(
x = ""
y = ""
title = ""
subtitle = ""
caption = ""
alt = ""
)
annotate(geom = "text", x = 8, y = 9, label = "A")
guides(x = guide_axis(n.dodge = 2))
guides(
fill = "none"
colorbar ="none"
legend = "none"
)
theme(legend.position = "bottom, top, left, right")
scale_fill_discrete(
name = "Title",
labels = c("A", "B", "C", "D", "E")
)

# Layer 6: Themes
  #Prebuilt into ggplot2
theme_bw()
theme_gray()
theme_dark()
theme_classic()
theme_light()
theme_linedraw()
theme_minimal()
theme_void()

  #ggthemes
theme_wsj()
theme_tufte()
theme_stata()
theme_solid()
theme_solarized()
theme_map()
theme_igray()
theme_hc()
theme_gdocs()
theme_fivethirtyeight()
theme_few()
theme_excel()
theme_economist()
theme_calc()

