# %%
from sqlalchemy import create_engine

def con_sqlite(str_url):
    # Tem que gerara a string de conexao, criar a engine e depois conectar na engina para criar a db
    engine = create_engine(str_url)
    con = engine.connect()
    return con

def load_df(df, table_name, con):
    df.to_sql(table_name, con)
    return table_name

# %%
