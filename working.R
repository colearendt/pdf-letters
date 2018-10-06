library(rvest)

raw_page <- read_html("https://mrprintables.com/alphabet-coloring-pages.html")

raw_page %>%
  html_nodes(".download_now_button_submit") %>%
  as.list() %>%
  View()

# this is JavaScript... easier just to click download 26 times

#all_downloads <- fs::dir_ls("~/Downloads") %>%
#  stringr::str_subset("\\.pdf$") %>%
#  stringr::str_subset("-upper-") %>%
#  fs::file_move(.,fs::path("./upper/", fs::path_file(.)))
all_downloads <- fs::dir_ls("./upper")

# helpful SO post
# https://stackoverflow.com/questions/3444645/merge-pdf-files

reticulate::use_python("/usr/local/bin/python3")

# reticulate::py_install("PyPDF2")

pd <- reticulate::import("PyPDF2")

mrg <- pd$PdfFileMerger()

lapply(as.list(all_downloads), function(x){
  mrg$append(x)
})

mrg$write("upper.pdf")
