from api import get_saisonen, get_ligen, get_spiele, get_spieler
from utils import save_row, save_checkpoint, is_already_processed
from time import sleep


def main():
    for saison_id, saison in get_saisonen().items():
        for liga_id, liga in get_ligen(saison_id).items():
            for spiel_id, spiel in get_spiele(saison_id, liga_id).items():
                meta_data = (saison_id, liga_id, spiel_id)
                key = f"{saison_id}-{liga_id}-{spiel_id}"
                if is_already_processed(key):
                    continue

                spieler = get_spieler(saison_id, spiel_id)
                for s in spieler:
                    if not s["name"]:
                        continue
                    row = {
                        "saison_id": saison_id,
                        "saison": saison,
                        "liga_id": liga_id,
                        "liga": liga,
                        "spiel_id": spiel_id,
                        "datum": spiel["datum"],
                        "heim": spiel["heim"],
                        "gast": spiel["gast"],
                        "name": s["name"],
                        "bahn1": s["bahn1"],
                        "bahn2": s["bahn2"],
                        "bahn3": s["bahn3"],
                        "bahn4": s["bahn4"],
                        "gesammt": s["gesammt"],
                    }
                    save_row(row)


                save_checkpoint(
                    {key: meta_data}
                )
                sleep(1)


if __name__ == "__main__":
    main()
