import pandas as pd
import os
import json
from pathlib import Path


def save_row(row, filename="kegel_spieler.csv"):
    df = pd.DataFrame([row])
    if os.path.isfile(filename):
        df.to_csv(filename, mode="a", header=False, index=False)
    else:
        df.to_csv(filename, mode="w", header=True, index=False)


def save_checkpoint(data:dict, filename="checkpoint.json"):
    with open(filename, "r+") as f:
        try:
            file_data = json.load(f)
        except json.JSONDecodeError:
            file_data = {}

        file_data.update(data)
        f.seek(0)
        json.dump(file_data, f)
        f.truncate()



def is_already_processed(key):
    checkpoint = Path("checkpoint.json")
    if not checkpoint.exists():
        checkpoint.touch()
        checkpoint.write_text("{}")

    with open(checkpoint, "r") as f:
        processed = json.load(f)

        if key in processed:
            return True
        return False
