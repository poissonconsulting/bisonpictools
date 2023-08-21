#' Data Checks based on the Template
#' 
#' Confirms the columns types match the template, the values follow the allowed
#' ranges of the template and tables can be joined appropriately. 
#'
#' @param event A data frame of event data.
#' @param location A data frame of location data.
#' @param complete A flag indicating if all data frames need to be supplied.
#'
#' @return List of data frames
#'
#' @examples
#' \dontrun{
#' data <- bpt_check_data(
#'   event = event_data(), location = location_data(), complete = TRUE
#' )
#' location <- bpt_check_data(location = location_data(), complete = FALSE)
#' event <- bpt_check_data(event = event_data(), complete = FALSE)
#' event <- bpt_check_data(event = event_data(), complete = TRUE)
#' }
bpt_check_data <- function(event = NULL, location = NULL, complete = FALSE) {
  chk_datas(
    event = event,
    location = location,
    template = bisonpictools::template,
    complete = complete
  )
}

### move this to a package
chk_datas <- function(..., template, joins = NULL, complete = FALSE) {
  data <- list(...)
  
  template_names <- names(template)
  
  data[vapply(data, is.null, FUN.VALUE = TRUE)] <- NULL
  data_names <- names(data)
  
  if (!any(data_names %in% template_names)) {
    chk::abort_chk(
      "Table name(s) doesn't match template sheet names"
    )
  }
  

  
  # check individual datasets
  data <- check_column_types(data, template)
  data <- check_template_ranges(data, template)

  # if complete = TRUE then must have all names represented
  if (complete) {
    if (!all(template_names %in% data_names)) {
      stop("All sheets must be present")
    }
    
    check_template_join(data, template)
    
  }
  
  # if complete = TRUE then check joins
  
  data
}

events <- bisonpictools::event_data()
# try a bad value
events[2, 7] <- 1004
# change column type
events$f1 <- as.character(events$f1)


location <- bisonpictools::location_data()
location[2, 1] <- "RLBH008"
dat1 <- bpt_check_data(location = location, complete = FALSE)


dat <- bpt_check_data(event = events, location = location, complete = TRUE)
dat <- bpt_check_data(event = events, location = location_data(), complete = FALSE)
dat1 <- bpt_check_data(location = location_data(), complete = TRUE)
dat1 <- bpt_check_data(location = location_data(), complete = FALSE)
dat2 <- bpt_check_data(event = events, complete = TRUE)
dat2 <- bpt_check_data(event = events, complete = FALSE)
# 
# 
# dat2

# # prep below
# bpt_check_data <- function(data) {
# 
#   data <- check_column_types(data, template)
#   data <- check_template_ranges(data, template)
#   chk_tbl_join(data)
# 
#   data
# }


chk_tbl_join <- function(data) {
  location <- data[["Locations"]]
  event <- data[["Events"]]

  if (!chk::vld_join(event, location, by = c("location_id"))) {
    chk::abort_chk(
      "Not all `location_id` values in the event table are in the locations
      table. Ensure all `location_id` are in the Locations table."
    )
  }
}

check_column_types <- function(data, template) {
  for (i in names(data)) {
    data[[i]] <- check_types(data[[i]], template[[i]])
  }
  data
}

check_types <- function(data, template) {
  x <- template[-1]
  chk::chk_superset(names(data), names(x), x_name = "column names in data")
  extra <- setdiff(names(data), names(x))
  data <- data[c(names(x), extra)]

  type_vals <- chktemplate::chkrow_to_type(template[template$name == "chk", ])

  integer_cols <- names(data)[which(type_vals == "integer")]
  numeric_cols <- names(data)[which(type_vals == "numeric")]
  char_cols <- names(data)[which(type_vals == "character")]

  for (i in integer_cols) {
    data[[i]] <- safe_as_integer(data[[i]], i)
  }

  for (i in numeric_cols) {
    data[[i]] <- safe_as_numeric(data[[i]], i)
  }

  for (i in char_cols) {
    data[[i]] <- as.character(data[[i]])
  }

  data
}

safe_as_integer <- function(x, name) {
  bad <- unique(x[!is.na(x) & suppressWarnings(is.na(as.integer(x)))])
  if (length(bad) > 0) {
    chk::abort_chk(paste0(
      "The following values in column '", name,
      "' should be a integer: ", chk::cc(bad, " and ")
    ))
  }
  as.integer(x)
}

safe_as_numeric <- function(x, name) {
  bad <- unique(x[!is.na(x) & suppressWarnings(is.na(as.numeric(x)))])
  if (length(bad) > 0) {
    chk::abort_chk(paste0(
      "The following values in column '", name,
      "' should be a number: ", chk::cc(bad, " and ")
    ))
  }
  as.numeric(x)
}

check_template_values <- function(data, template, name) {
  x <- template[-1]
  chk_values <- chktemplate::chkrow_to_expression(template)
  key_values <- which(as.logical(as.vector(
    template[template$name == "pkey", ][-1]
  )))
  key_values <- names(x)[key_values]
  chk::check_data(data, values = chk_values, key = key_values, x_name = name)
  if ("unique" %in% template$name) {
    unique_values <- which(as.logical(as.vector(
      template[template$name == "unique", ][-1]
    )))
    unique_values <- names(x)[unique_values]
    if (length(unique_values)) {
      for (i in unique_values) {
        chk::chk_unique(data[[i]], x_name = p0("column '", i, "' of data"))
      }
    }
  }
  data
}

check_template_ranges <- function(data, template) {
  for (i in names(data)) {
    data[[i]] <- check_template_values(data[[i]], template[[i]], i)
  }
  data
}












check_template_join <- function(data, template) {
  for (i in names(template)) {
    if ("join" %in% template[[i]]$name) {
      
      x <- template[[i]][-1]
      
      join_by <- which(!is.na(as.vector(
        template[[i]][template[[i]]$name == "join", ][-1]
      )))
      join_by <- names(x)[join_by]
      if (length(join_by) == 0) {
        next()
      }
      
      # get the table name for the x table
      tbl_x <- unique(template[[i]][[join_by]][template[[i]]$name == "join"])
      
      # error if more then 1 table is listed 
      if (length(tbl_x) < 1) {
        stop("Only 1 table can be joined")
      } 
      
      l <- list(list(
        tbl_y = i,
        tbl_x = tbl_x,
        by = join_by
      ))
      
      names(l) <- i
      
      joins <- c(joins, l)
      
      if (!chk::vld_join(
        data[[joins[[i]]$tbl_y]], data[[joins[[i]]$tbl_x]], by = c(joins[[i]]$by)
      )) {
        
        no_match <- unique(
          data[[joins[[i]]$tbl_y]][!data[[joins[[i]]$tbl_y]][[joins[[i]]$by]] %in% 
                                     data[[joins[[i]]$tbl_x]][[joins[[i]]$by]],][[joins[[i]]$by]]
        )
        
        chk::abort_chk(
          "All ", joins[[i]]$by, " values in the ", joins[[i]]$tbl_y, 
          " table must be in the ", joins[[i]]$tbl_x, " table. The following value(s)
    are not in the ", joins[[i]]$tbl_x, " table:", chk::cc(no_match)
        )
      }
      
    }
  }
  
}



template <- bisonpictools::template

event <- bisonpictools::event_data()
location <- bisonpictools::location_data()
location[2, 1] <- "RLBH006"

data <- list(event = event, location = location)


check_template_join(data, template)




template <- bisonpictools::template
#template <- template[[2]]
#x <- template[-1]

for (i in names(template)) {
  if ("join" %in% template[[i]]$name) {
    
    x <- template[[i]][-1]
    join_by <- which(!is.na(as.vector(
      template[template$name == "join", ][-1]
    )))
    join_by <- names(x)[join_by]
    if (length(join_by) == 0) {
      return()
    }
    
    # get the table name for the x table
    tbl_x <- unique(template[[join_by]][template$name == "join"])
    
    # error if more then 1 table is listed 
    if (length(tbl_x) < 1) {
      stop("Only 1 table can be joined")
    } 
    
    l <- list(list(
      tbl_y = i,
      tbl_x = tbl_x,
      by = join_by
    ))
    
    names(l) <- i
    
    joins <- c(joins, l)
    
    if (!chk::vld_join(
      data[[joins[[i]]$tbl_y]], data[[joins[[i]]$tbl_x]], by = c(joins[[i]]$by)
    )) {
      
      no_match <- unique(
        data[[joins[[i]]$tbl_y]][!data[[joins[[i]]$tbl_y]][[joins[[i]]$by]] %in% 
                                   data[[joins[[i]]$tbl_x]][[joins[[i]]$by]],][[joins[[i]]$by]]
      )
      
      chk::abort_chk(
        "All ", joins[[i]]$by, " values in the ", joins[[i]]$tbl_y, 
        " table must be in the ", joins[[i]]$tbl_x, " table. The following value(s)
    are not in the ", joins[[i]]$tbl_x, " table:", chk::cc(no_match)
      )
    }
    
  }
}



i <- "event"

joins <- list()

join_by <- which(!is.na(as.vector(
  template[template$name == "join", ][-1]
)))
join_by <- names(x)[join_by]

# return if no join has been specified 
if (length(join_by) == 0) {
  return()
}

# get the table name for the x table
tbl_x <- unique(template[[join_by]][template$name == "join"])

# error if more then 1 table is listed 
if (length(tbl_x) < 1) {
  stop("Only 1 table can be joined")
} 

l <- list(list(
  tbl_y = i,
  tbl_x = tbl_x,
  by = join_by
))

names(l) <- i
l

joins <- c(
  joins, 
  l
)
joins


if (!chk::vld_join(
  data[[joins[[i]]$tbl_y]], data[[joins[[i]]$tbl_x]], by = c(joins[[i]]$by)
)) {
  
  no_match <- unique(
    data[[joins[[i]]$tbl_y]][!data[[joins[[i]]$tbl_y]][[joins[[i]]$by]] %in% 
        data[[joins[[i]]$tbl_x]][[joins[[i]]$by]],][[joins[[i]]$by]]
  )
  
  chk::abort_chk(
    "All ", joins[[i]]$by, " values in the ", joins[[i]]$tbl_y, 
    " table must be in the ", joins[[i]]$tbl_x, " table. The following value(s)
    are not in the ", joins[[i]]$tbl_x, " table:", chk::cc(no_match)
  )
}



