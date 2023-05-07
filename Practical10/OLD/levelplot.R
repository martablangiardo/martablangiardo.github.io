seq.x.grid <- seq(
  range(gridnysptime$Longitude)[1],
  range(gridnysptime$Longitude)[2],
  length = 100
)

seq.y.grid <- seq(
  range(gridnysptime$Latitude)[1],
  range(gridnysptime$Latitude)[2],
  length = 100
)

# Create prediction map
print(
  levelplot(
    x = lp_grid_mean,
    row.values = seq.x.grid,
    column.values = seq.y.grid,
    # ylim = c(4875, 5159),
    # xlim = c(309, 529),
    col.regions = fields::tim.colors(64),  # gray(seq(0.9, 0.2, l = 100)),
    aspect = "iso",
    contour = TRUE,
    labels = FALSE,
    pretty = TRUE, 
    xlab = "Longitude", ylab = "Latitude",
    main = format(as.Date(as.character(which_date), '%d/%m/%y'), '%B %d, %Y')
  )
)
trellis.focus("panel", 1, 1, highlight = FALSE)
#lpoints(borders, col = 1, cex = 0.25)

lpoints(coords$Longitude, coords$Latitude, col = "magenta", lwd = 1, pch = 21)
