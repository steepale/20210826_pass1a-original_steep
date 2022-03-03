#' ExtractNamedAbundance1A
#' A function to create a matrix with viallabels (or bids) and metabolite names for named metabolites
#' @param export_df the named metabolite data from the UMICH metabolomics core
#' @param manifest_df the sample info from the UMICH metabolomics core
#' @param transpose logical: whether to transpose the dataframe. If transpose = FALSE, then metabolites and arrange by row and samples by column
#' @param sample_id which sample identifier to use for labeling experimental samples (excludes references). Choices include: "viallabel" or "bid"
#' @param format_out the object output format. One of "df" or "mat"
#' @return an object with viallabels and metabolite names for named metabolites
ExtractNamedAbundance1A <- function(export_df, manifest_df, transpose = TRUE, sample_id = "viallabel", format_out = "mat"){
  # Remove necessary fields
  area_cols <- names(export_df)[grepl("\\[Area\\]", names(export_df))]
  export_df <- export_df %>% select(Name, all_of(area_cols))
  names(export_df) <- str_remove_all(names(export_df), pattern = "\\[Area\\] ")
  # Convert names in matrix to viallabels
  name_df <- manifest_df %>% select(sample_id, raw_file)
  names(export_df)[1] <- 'Metabolite_Name' 
  names(export_df)[!names(export_df) %in% name_df$raw_file]
  for(i in 2:length(names(export_df))){
    if(names(export_df)[i] %in% name_df$raw_file){
      names(export_df)[i] <- filter(name_df, raw_file == names(export_df)[i])$sample_id
    }
  }
  if(transpose & sample_id == 'viallabel'){
    # transpose the Matrix
    export_df <- export_df %>%
      pivot_longer(-Metabolite_Name) %>% 
      pivot_wider(names_from=Metabolite_Name, values_from=value)
    names(export_df)[1] <- "viallabel"
  }
  if(transpose & sample_id == 'bid'){
    export_df <- export_df %>%
      mutate(bid = ifelse(substr(viallabel, 1, 2) == '90', substr(viallabel, 1, 5), viallabel)) %>%
      select(-viallabel) %>% select(bid, !bid)
  }else if(!transpose & sample_id == 'bid'){
    for(i in 2:length(names(export_df))){
      if(substr(names(export_df)[i], 1, 2) == '90'){
        names(export_df)[i] <- substr(names(export_df)[i], 1, 5)
      }
    }
  }
  if(format_out == "df"){
      export <- export_df
  }else if(format_out == 'mat'){
      export <- export_df %>%
        column_to_rownames(names(export_df)[1]) %>%
        as.matrix()
  }
  return(export)
}