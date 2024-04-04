#%%
import pandas as pd
from sqlalchemy import create_engine
from extract import extract_database
from load import con_sqlite
from load import load_df
    


if __name__ == '__main__':  
    # Extract data from CSV files
    df_bio_exec = extract_database(path='../data/biometry_execution.csv')
    df_bio = extract_database(path='../data/biometry.csv')
    df_drivers = extract_database(path='../data/drivers.csv')
    df_orders = extract_database(path='../data/orders.csv')
    
    # Establish connection to SQLite database
    con = con_sqlite(str_url='sqlite:///../data/if.db')
    
    # Load DataFrames into SQLite database
    load_df(df_bio_exec, 'biometry_execution', con)
    load_df(df_bio, 'biometry', con)
    load_df(df_drivers, 'drivers', con)
    load_df(df_orders, 'orders', con)



# %%
