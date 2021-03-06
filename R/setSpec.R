# ####
#' @title Create (or update) specification list for cluster analysis 
#' 
#' @description Create (or update) specification list for cluster analysis.
#'   Currently developed for using predictions from GAM results. (Future updates
#'   for WRTDS files.)
#'   
#' @details See \code{\link{c.specQC}} for list of variables needed to be passed. 
#' 
#' TBD: expand to include list of variables added to the list
#' 
#' @param c.spec list for storing specifications for cluster analysis 
#' @param ... specifications needed to run cluster analysis -- see details for
#'   list of needed variables
#' 
#' @examples 
#' \dontrun{
#' #TBD
#' 
#' }
#' 
#' @return list
#' 
#' @seealso \code{\link{calcQuanClass}}
#' 
#' @importFrom rlang .data := 
#' @importFrom lubridate %m+% %m-% ymd decimal_date yday year month make_date floor_date ceiling_date is.Date
#' @importFrom dplyr %>% mutate select filter bind_rows case_when rename group_by
#' @importFrom dplyr distinct relocate left_join arrange between pull summarise ungroup
#' @importFrom tibble tibble as_tibble 
#' 
#' @export
#'
setSpec <- function(c.spec = list(), ...) {
  
  # ----< Create list of arguments passed in function >----
  {
    c.spec2 <- grabFunctionParameters()      
    c.spec2$c.spec <- NULL                # drop c.spec from list
  }
  
  # ----< Find updates of existing variables >----
  {
    # find common variable names between arguments passed to those in original c.spec ####
    varCommon <- intersect(names(c.spec2), names(c.spec))
    
    # down-select common variables to those with updates ####
    chk <- logical(length = length(varCommon))
    for (k1 in 1:length(varCommon)) {
      var = varCommon[k1]
      chk[k1] = length(unlist(c.spec[var])) != length(unlist(c.spec2[var])) ||
        unlist(c.spec[var]) != unlist(c.spec2[var])
    }
    
    # variables with updates ####    
    varCommonDifferent <- varCommon[chk]
    
  }
  
  # ----< Find new variables >---- 
  {
    varNew <- setdiff(names(c.spec2), names(c.spec))
  }
  
  # ----< Update c.spec >----
  {
    # updates based on changed variables and new variables 
    c.spec[c(varCommonDifferent, varNew)] <- c.spec2[c(varCommonDifferent, varNew)]
  }
  
  # ----< Create table of changes >---- 
  {
    # create table
    df <- tibble(Variable = c(varCommonDifferent, varNew)) %>%
      left_join(., c.specQC, by = "Variable") %>%
      select(., Variable, Description) %>%
      mutate(., Settings = NA_character_)
    
    for (k1 in 1:NROW(df)) {
      df[k1, "Settings"] <- vec.strg(as.character(unlist(c.spec[[unlist(df[k1, "Variable"])]])))
    }
    
    # print the updates out ####
    FT <- tblFT1(df)
  }
  
  # ----< Check c.spec >----
  {
    setSpecChk(c.spec)
  }
  
  # ----< build out c.spec >----
  {
    c.spec <- setSpecCmp(c.spec)
  }
  
  return(c.spec)
  
} # end ~ function: setSpec
