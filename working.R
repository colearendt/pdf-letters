library(rvest)

raw_page <- read_html("https://mrprintables.com/alphabet-coloring-pages.html")

raw_page %>%
  html_nodes(".download_now_button_submit") %>%
  as.list() %>%
  View()

#all_downloads <- fs::dir_ls("~/Downloads") %>%
#  stringr::str_subset("\\.pdf$") %>%
#  stringr::str_subset("-upper-") %>%
#  fs::file_move(.,fs::path("./upper/", fs::path_file(.)))
all_downloads <- fs::dir_ls("./upper")

reticulate::use_python("/usr/local/bin/python3")

pd <- reticulate::import("PyPDF2")

mrg <- pd$PdfFileMerger()

lapply(as.list(all_downloads), function(x){
  mrg$append(x)
})

mrg$write("upper.pdf")
