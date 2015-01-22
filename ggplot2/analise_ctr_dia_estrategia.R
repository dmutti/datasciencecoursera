#http://docs.ggplot2.org/current/scale_date.html
analise_ctr_dia_estrategia <- function() {
    Sys.setlocale("LC_TIME", "English")
    library(scales)
    library(dplyr)
    library(ggplot2)
    data = read.table("./ctr.tab.log", sep = "\t")
    data <- mutate(data, estrategia = as.factor(ifelse(V2 == "d7", "Global", ifelse(V2 == "e7", "Local", "Desconhecido"))), date = as.Date(V1, "%d-%b-%y"), ctr = V3)
    data <- select(data, date, ctr, estrategia)
    plot <- ggplot(data=data, aes(x=date, y=ctr, group=estrategia, colour=estrategia))
    plot <- plot + geom_line() + geom_point()
    plot <- plot + scale_x_date(minor_breaks="1 day", breaks="2 day", labels=date_format("%d/%m"))
    plot <- plot + scale_y_continuous(labels=comma)
    plot <- plot + xlab("Dia") + ylab("CTR") + scale_colour_hue(name="Estrat\u{E9}gia") #http://www.unicode.org/charts/PDF/U0080.pdf
    ggsave("./data_ctr_estrategia.png")
}
