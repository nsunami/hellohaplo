library(tidyverse)
library(here)
library(lubridate)
# Load the saved data
all_applications <- read_rds(here("data/all_applications.rds"))


# Duplicates cleaning
all_applications <- all_applications |> 
  group_by(ref) |> 
  filter(n() == 1) |> 
  ungroup()
# Filter out the case where with_DMP is TRUE
all_applications <- all_applications |>
  filter(with_DMP != "TRUE")

# Convert the dates to date objects 
all_applications <- all_applications |> 
  mutate(across(c(created_at, opened_at),
                as.Date))
# Create weekly bins for dates for cross-year comparisons
all_applications <- all_applications |> 
  mutate(
    across(
      c(created_at, opened_at),
      list(day = day,
           week = week,
           month = month,
           year = year),
      .names = "{.col}_{.fn}"
    )
  )

# Year to year comparisons - Months
all_applications |> 
  group_by(opened_at_year, opened_at_month) |>
  summarize(n = n()) |>
  ggplot(aes(opened_at_month, n,
             group = opened_at_year,
             color = as.factor(opened_at_year))) +
  geom_line() +
  geom_point()

# Year-to-year comparisons - Weeks
all_applications |> 
  group_by(opened_at_year, opened_at_week) |>
  summarize(n = n()) |>
  ggplot(aes(opened_at_week, n,
             group = opened_at_year,
             color = as.factor(opened_at_year))) +
  geom_line() +
  geom_point() + 
  scale_colour_discrete(name = "Year")

# Over time
all_applications |> 
  count(opened_at_year, opened_at_week) |>
  mutate(date = paste0(opened_at_year, "-", opened_at_week, "-1")) |> 
  mutate(date_parsed = parse_date_time(date,  "%Y-%U-%u")) |>
  ggplot(aes(date_parsed, n)) + 
  geom_point() +
  geom_smooth()

# Filter out the automated approvals
auto_approved_applications <- all_applications |>
  filter(state == "approval_not_required")


# How many applicatiosn are have DMPs?
all_applications |> 
  count(state, with_DMP)

# RSM-E Automatically-Approved Applications with DMP
auto_approved_applications |> 
  ggplot(aes(x = as.Date(created_at),
             fill = with_DMP)) +
  geom_histogram() + 
  scale_x_date(name = "") + 
  ggtitle("RSM-E Automatically-Approved Applications") +
  ylab("Count") +
  scale_fill_discrete(name = "With DMP")


# All applications with DMPs?
all_applications |>
  ggplot(aes(x = as.Date(created_at),
             fill = with_DMP)) +
  geom_histogram() + 
  scale_x_date(name = "") + 
  ggtitle("RSM-E All Applications") +
  ylab("Count") +
  scale_fill_discrete(name = "With DMP")

