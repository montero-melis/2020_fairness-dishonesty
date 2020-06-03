## A number of convenience functions used in the analysis script

library("tidyr")
library("scales")  # percent on y-axis in ggplots


# M & SD for different conditions (https://tidyeval.tidyverse.org/multiple.html)
grouped_mean <- function(.data, .summary_var, my_digits, ...) {
  .summary_var <- enquo(.summary_var)
  .group_vars <- enquos(...)
  .data %>%
    group_by(!!!.group_vars) %>%
    summarise(
      mean = mean(!!.summary_var),
      SD   = sd(!!.summary_var)
      ) %>%
    kable(digits = my_digits)
}

# similar to above but for proportions; assumes a binary variable with levels
# yes/no and shows the proportion of "yes"
grouped_prop <- function(.data, .summary_var, my_digits, ...) {
  .summary_var <- enquo(.summary_var)
  .group_vars <- enquos(...)
  .data %>%
    group_by(!!!.group_vars) %>%
    summarise(prop = mean(!!.summary_var == "yes", na.rm = TRUE)) %>%
    kable(digits = my_digits)
}



# Coding scheme; set contrast coding, sign allows to invert which value is
# mapped to 1 and -1 (by default it will be based on alphabetical order) 
set_contrast_coding <- function(df, var, contr_name, sign = 1) {
  df[[var]] <- factor(df[[var]])
  contrasts(df[[var]]) <- sign * contr.sum(2) / 2
  colnames(contrasts(df[[var]])) <- contr_name
  print(contrasts(df[[var]]))
  df
}

model_summaries <- function (fm, print_summary = TRUE) {
  if (print_summary) print(summary(fm))
  tab_model(fm, show.stat = TRUE)
}


## PLOTTING

# plots with error bars showing 95% C.I.
make_error_plot <- function(df, myx, myy, mycol) {

  myx   <- sym(myx)
  myy   <- sym(myy)
  mycol <- sym(mycol)

  p <- ggplot(
    df, aes(x = !!myx, y = !!myy, colour = !!mycol, shape = !!mycol)
    ) +
  	stat_summary(
  	  fun.data = mean_se, geom = "errorbar", width = err_bar_width,
      size = err_bar_size, fun.args = list(mult = 1.96), position = pd
      ) +
    stat_summary(
      fun.y = "mean", geom = "point", size = point_size, position = pd
      ) +
    stat_summary(
      aes(group = !!mycol),
      fun.y = "mean", geom = "line", position = pd, size = line_size
      ) +
    geom_point(
    	alpha = my_alpha,
    	position = position_jitterdodge(
    		jitter.width = jitter_width,
			  jitter.height = 0,
			  dodge.width = 0.4
			  )
    	) +
    xlab("pay rate")
  p
}

# Plot proportions as bar plots (adapted to Exp 1)
plot_proportion <- function(df, DV, myylab) {

  DV_sym <- sym(DV)

  df %>%
    group_by(justification, pay) %>%
    summarise(
      N  = n(),
      DV = sum(!!DV_sym == "yes") / N
      ) %>%
    ggplot(aes(x = pay, y = DV)) +
    geom_bar(stat = "identity") +
    facet_grid(. ~ justification) +
    scale_y_continuous(
      labels = percent, limits = c(0, 1),
      breaks = seq(.25, 1, .25)
      ) +
    xlab("pay rate") +
    ylab(myylab) +
    theme_bw()
}

# Plot proportions as bar plots (adapted to Exp 2)
plot_proportion2 <- function(df, DV, myylab, just2 = FALSE) {

  DV_sym <- sym(DV)

  # just2 in case we want to plot outcome and procedure, but not valence
  if (just2) {
    myaes   <- aes(x = procedure, y = DV)
    myfacet <- facet_grid(. ~ outcome)
  } else {
    myaes   <- aes(x = valence, y = DV)
    myfacet <- facet_grid(procedure ~ outcome)
  }

  df %>%
    filter(! is.na(!!DV_sym)) %>%  # exclude NAs
    # see https://stackoverflow.com/questions/30604107/r-conditional-evaluation-when-using-the-pipe-operator
    {if (just2) group_by(., outcome, procedure) else group_by(., outcome, procedure, valence)} %>%
    summarise(
      N  = n(),
      DV = sum(!!DV_sym == "yes") / N
    ) %>%
    ggplot(myaes) +
    geom_bar(stat = "identity") +
    myfacet +
    ylab(myylab) +
    scale_y_continuous(
      labels = percent, limits = c(0, 1),
      breaks = seq(.25, 1, .25)
      ) +
    theme_bw()
}

# save ggplot with global specifications
my_ggsave <- function(
  fig_name,
  type = ".png",
  mywidth  = 5,
  myheight = 3
  ) {
  fname <- paste0("myfigures/", fig_name, type)
  ggsave(filename = fname, plot = last_plot(), width = mywidth, height = myheight)
}

