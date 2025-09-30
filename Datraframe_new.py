import pandas as pd
import pandas as pd
import numpy as np
from IPython.display import display

pd.set_option('display.max_rows', 100)
pd.set_option('display.max_columns', 50)
pd.set_option('display.width', 1000)

# Cria DataFrame a partir de arquivos Excel
# df_gdp = pd.read_csv("GDP_pc_Maddison_2020.csv", encoding='latin-1', delimiter=';', decimal=',', thousands='.', header=0)
df_gdp = pd.read_excel('GDP_pc_Maddison_2020.xlsx', thousands='.')

# Filtra DataFrame
df_gdp[['year', 'Brazil']]

print(df_gdp[['year','Brazil']])
df_gdp_filtrado = df_gdp.iloc[10:50,0:10]
print(df_gdp.iloc[3,0:3])
print(df_gdp.loc[10:15,['year','Brazil','Argentina','Angola']])

print(df_gdp['year']>=2000)
df_gdp[df_gdp['year']>=2000]

df_gdp_filtrado = df_gdp.loc[df_gdp['year']>=2000,['year','Brazil','United States']]

print(df_gdp.loc[(df_gdp['year']>=2000) & (df_gdp['year']<=2005), ['year','Brazil','Argentina']])

# Ordena Valores
#df_gdp = df_gdp.sort_values(['Argentina'], ascending=False)

lista_nomes = ['Fernarda', 'Joao', 'Maria']
lista_numeros = ['8283928382', '2381209381', '874218741']

lista_nomes[1]

dict = {'Fernarda':'8283928382', 'Joao':'2381209381', 'Maria':'874218741'}

dict['Fernarda']

a=1
# Renomeia Colunas
# df_gdp.rename(columns={'United States':'US','Brazil':'BR'}, inplace=True)

# Adiciona Novos Valores
print(df_gdp['Brazil']/df_gdp['United States'])

#df_gdp.insert(1,'Razão PIB', df_gdp['Brazil']/df_gdp['United States'])

countries = ['Brazil', 'Argentina', 'Germany', 'France', 'Japan']
df_gdp_ratio = pd.DataFrame(df_gdp['year'])
for country in countries:
    df_gdp_ratio.insert(len(df_gdp_ratio.columns), country, df_gdp[country] / df_gdp['United States'])

['Fora da armadilha' if item>=0.5 else 'Na armadilha' for item in df_gdp_ratio['Brazil']]

# Deleta Coluna
df_gdp_ratio.drop(columns=['Brazil'],inplace=True)

# Groupby
scholar = pd.read_excel('Scholar_Amostra.xlsx', thousands='.')

grouped = scholar.groupby('PUB_YEAR').size()
display(grouped)

print(scholar.groupby('SCHOLAR_AUTHOR_ID').size())
print(scholar.groupby(['SCHOLAR_AUTHOR_ID', 'PUB_YEAR']).size())

print(scholar.groupby('SCHOLAR_AUTHOR_ID').sum()['NUM_CITATIONS'])
print(scholar.groupby(['SCHOLAR_AUTHOR_ID','PUB_YEAR']).sum()['NUM_CITATIONS'])

{'NUM_CITATIONS': ['size','min', 'max', 'sum'], 'idx':'sum'}

print(scholar.groupby(['SCHOLAR_AUTHOR_ID','PUB_YEAR']).agg({'NUM_CITATIONS': ['size','min', 'max', 'sum']}))

tabela_final = (scholar.groupby(['SCHOLAR_AUTHOR_ID','PUB_YEAR'])
                .agg({'NUM_CITATIONS': ['size', 'min', 'max', 'sum'], 'IDX': 'sum'}))
tabela_final.to_excel('Tabela_Final.xlsx')

publicacoes_por_ano = scholar.groupby('PUB_YEAR').size()

a=1

