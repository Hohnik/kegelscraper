from api import get_saisons, get_ligen, get_spiele, get_spieler, get_spieltage
from utils import save_row, save_checkpoint, is_already_processed
from time import sleep


def main():
    for saison_id, saison in get_saisons().items():
        for liga_id, liga in get_ligen(saison_id).items():
            for spieltag_id, spieltag in get_spieltage(saison_id, liga_id).items():
                for spiel_id, spiel in get_spiele(
                    saison_id, liga_id, spieltag_id
                ).items():
                    meta_data = (saison, liga, spieltag)
                    if is_already_processed(spiel_id):
                        sleep(0.5)
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

                    save_checkpoint({spiel_id: meta_data})
                    sleep(1)


if __name__ == "__main__":
    # saison_id = 10 # 2025
    # liga_id = 3242 # Landeslige Ost
    # bezirks_id = 0 # bskv
    # kreis_id = 0 # None
    # spieltag_id = 73914 # 1. Spieltag
    saisons = get_saisons()
    print(saisons)

    # main()
