#numeros negativos indicam que essa quantidade de colunas deve ser ignorada
#fonte: https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
x <- read.fwf("./getdata-wksst8110.for", skip=4, widths = c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4))
