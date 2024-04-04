#%%
import pandas as pd

def extract_database(path):
    df = pd.read_csv(path, sep=';')    
    return df


# %%
