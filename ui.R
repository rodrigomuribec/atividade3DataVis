library(shiny)
library(shinydashboard)
library(DT)
library(dplyr)
require(devtools)
require(rCharts)
require(reshape2)
require(scales)

dashboardPage(
  dashboardHeader(title = "Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Parâmetros",tabName = "Parametros", icon = icon("dashboard"))
    ),
    uiOutput("radioApp"),
    uiOutput("seletorCurso"),
    uiOutput("seletorPeriodo"),
    uiOutput("seletorDisciplina")
    ),
  dashboardBody(
    #Visao Geral
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "ajustes.css")
    ),
    conditionalPanel("input.aplicacao == 1",
                     fluidRow(
                       column(
                         class = "coluna",
                         width=8,
                         tabBox(
                           id = "tabGeral",side = "left", width = 12,
                           selected = "1",
                           tabPanel("Geral",value = "1" , HTML("<center><h3>Média dos Indicadores</h3></center>"),showOutput("graficoGeral", "nvd3")),
                           tabPanel("Indicadores",value = "2", 
                                    conditionalPanel("input.indicadoresGeral_rows_selected == 0", h5("Nenhum indicador selecionado")),
                                    conditionalPanel("input.indicadoresGeral_rows_selected != 0", showOutput("graficoGeralIndicadores", "highcharts"), tags$h5(style = "text-align: center;", "Clique e arraste sobre uma região para Zoom"))
                            ),
                           tabPanel("Alunos",value = "3", 
                                    plotly::plotlyOutput('graficoGeralAlunos'),
                                    tags$h5(style = "text-align: center;", "Clique e arraste sobre uma região para Zoom")
                                    )
                         )
                       ),
                       column(
                         class = "coluna4",
                         width = 4,
                         box(
                           width = 12, title = "Indicadores",status = "primary",solidHeader = TRUE ,collapsible = TRUE,
                           dataTableOutput("indicadoresGeral")
                         ),
                         box(
                           width=12,title = "Alunos",status = "primary",solidHeader = TRUE ,collapsible = TRUE,
                           dataTableOutput("alunosGeral")
                         )
                       )
                     )
                     ),
    #Analise de desempenho
    conditionalPanel("input.aplicacao == 2",
                     fluidRow(
                       column(
                         class = "coluna",
                         width=8,
                         valueBoxOutput("SatisfatorioBox", width = 6),
                         valueBoxOutput("InsatisfatorioBox",width = 6),
                         tabBox(
                           id="tabDesempenho",side = "left", width = 12,
                           selected = "1",
                           tabPanel("Geral",value= "1", 
                                    showOutput("graficoDesempenhoGeral", "nvd3")
                                    ),
                           tabPanel("Indicadores",value="2" ,
                                    conditionalPanel("input.indicadoresDesempenho_rows_selected == 0", h5("Nenhum indicador selecionado")),
                                    conditionalPanel("input.indicadoresDesempenho_rows_selected != 0", showOutput("graficoDesempenhoInd", "highcharts"), tags$h5(style = "text-align: center;", "Clique e arraste sobre uma região para Zoom"))
                           ),
                        
                           tabPanel("Alunos",value="3" ,
                                    plotly::plotlyOutput('graficoDesempenhoAlunos'),
                                    tags$h5(style = "text-align: center;", "Clique e arraste sobre uma região para Zoom")
                                    )
                         )
                       ),
                       column(
                         class = "coluna4",
                         width = 4,
                         box(
                           width = 12, title = "Indicadores",status = "primary",solidHeader = TRUE ,collapsible = TRUE,
                           conditionalPanel("input.tabDesempenho == '1'", uiOutput("seletorConsDesGer")),
                           conditionalPanel("input.tabDesempenho == '3'", uiOutput("seletorConsDesAlu")),
                           dataTableOutput("indicadoresDesempenho")
                         ),
                         box(
                           width=12,title = "Alunos",status = "primary",solidHeader = TRUE ,collapsible = TRUE,
                           dataTableOutput("alunosDesempenho")
                         )
                       )
                     )),
    #Analise de Evasao
    conditionalPanel("input.aplicacao == 3",
                     fluidRow(
                       column(
                         class = "coluna",
                         width=8,
                         valueBoxOutput("BaixoRiscoBox",width = 6),
                         valueBoxOutput("AltoRiscoBox", width = 6),
                         tabBox(
                           id="tabEvasao",side = "left", width = 12,
                           selected = "1",
                           tabPanel("Geral",value = "1",
                                    showOutput("graficoEvasao", "nvd3")
                           ),
                           tabPanel("Indicadores",value = "2" ,
                                    conditionalPanel("input.indicadoresEvasao_rows_selected == 0", h5("Nenhum indicador selecionado")),
                                    conditionalPanel("input.indicadoresEvasao_rows_selected != 0", showOutput("graficoEvasaoInd", "highcharts"), tags$h5(style = "text-align: center;", "Clique e arraste sobre uma região para Zoom"))
                           ),
                           tabPanel("Alunos",value = "3" ,
                                    plotly::plotlyOutput('graficoEvasaoAlunos'),
                                    tags$h5(style = "text-align: center;", "Clique e arraste sobre uma região para Zoom")
                                    )
                         )
                       ),
                       column(
                         class = "coluna4",
                         width = 4,
                         box(
                           width = 12, title = "Indicadores",status = "primary",solidHeader = TRUE ,collapsible = TRUE,
                           conditionalPanel("input.tabEvasao == '1'", uiOutput("seletorConsEvaGer")),
                           conditionalPanel("input.tabEvasao == '3'", uiOutput("seletorConsEvaAlu")),
                           dataTableOutput("indicadoresEvasao")
                         ),
                         box(
                           width=12,title = "Alunos",status = "primary",solidHeader = TRUE ,collapsible = TRUE,
                           dataTableOutput("alunosEvasao")
                         )
                       )
                     ))
  )
)