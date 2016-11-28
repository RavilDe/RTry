# Мастецкий, Шитиков

?help.start

installed.packages(priority = "base") # базовые пакеты
installed.packages(priority = "recommended") # базовые пакеты

# копируем в буфер обмена список пакетов
packlist <- rownames(installed.packages())
write.table(packlist, "clipboard", sep = "\t", col.names = NA)

args(write.csv) # выводит аргументы функции

# ввод функции без скобок приводит к выводу исходного текста функции 
args 
sin
IQR

# вывод всех методов этой функции
methods("predict")
methods("as")
methods("plot")
methods("print")
methods("is")

