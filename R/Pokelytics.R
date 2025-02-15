#' Pokemon Names
#'
#' Outputs all Pokemon names
#'
#' @returns all Pokemon names
#' @export
#'
#' @examples
#' Pokemon_Names()
Pokemon_Names <- function(){
  tibble::tibble(JvD.Cheatsheet::Pokemon) |> dplyr::select("name")
}
