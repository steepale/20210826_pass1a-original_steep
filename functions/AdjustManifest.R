#' AdjustManifest
#' A function to slim down, rename, and correct sample naming in pass1a manifest files
#' @param manifest_df the named pass1a metabolite manifest data from the UMICH metabolomics core
#' @return an adjusted manifest object
AdjustManifest <- function(manifest_df, sample_id = FALSE){
  # Adjust sample id
  if(sample_id){
    # Adjust the manifest_df
    manifest_df$sample_id <- manifest_df$`Sample Name`
    x <- str_split(unlist(manifest_df$`Data File`), pattern = '-', simplify = TRUE)
    for(i in 1:nrow(x)){
      if(substr(x[i,5], 1, 3) == 'S00'){
        manifest_df$sample_id[i] <- x[i,6]
      }
    }
  }
  return(manifest_df)
}