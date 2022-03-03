#' ExtractNamedAbundanceDF1A
#' A function to create a dataframe with viallabels and metabolite names for named metabolites
#' @param export_df the named metabolite data from the UMICH metabolomics core
#' @param manifest_df the sample info from the UMICH metabolomics core
#' @param transpose logical: whether to transpose the dataframe. If transpose = FALSE, then metabolites and arrange by row and samples by column
#' @return a dataframe with viallabels and metabolite names for named metabolites
ExtractNamedAbundanceDF1A <- function(export_df, manifest_df, transpose = FALSE){
  # Remove necessary fields
  area_cols <- names(export_df)[grepl("\\[Area\\]", names(export_df))]
  export_df <- export_df %>% select(Name, all_of(area_cols))
  names(export_df) <- str_remove_all(names(export_df), pattern = "\\[Area\\] ")
  # Adjust the manifest_df
  manifest_df$viallabel <- manifest_df$`Sample Name`
  x <- str_split(unlist(manifest_df$`Data File`), pattern = '-', simplify = TRUE)
  for(i in 1:nrow(x)){
    if(substr(x[i,5], 1, 3) == 'S00'){
      manifest_df$viallabel[i] <- x[i,6]
    }
  }
  # Convert names in matrix to viallabels
  name_df <- manifest_df %>% select(viallabel, `Data File`)
  names(export_df)[1] <- 'Metabolite_Name' 
  for(i in 2:length(names(export_df))){
    if(names(export_df)[i] %in% name_df$`Data File`){
      names(export_df)[i] <- filter(name_df, `Data File` == names(export_df)[i])$viallabel
    }
  }
  if(transpose){
    # transpose the Matrix
    export_df <- export_df %>%
      pivot_longer(-Metabolite_Name) %>% 
      pivot_wider(names_from=Metabolite_Name, values_from=value)
    names(export_df)[1] <- "viallabel"
  }
  return(export_df)
}