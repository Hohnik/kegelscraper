from requests import post
from pprint import pprint


def main():
    for saison_id, saison in get_saisonen().items():
        print(f"\nSaison-{saison_id}: {saison}")

        for liga_id, liga in get_ligen(saison_id).items():
            print(f"Liga-{liga_id}: {liga}")

            for spiel_id, spiel in get_spiele(
                saison_id=saison_id, liga_id=liga_id
            ).items():
                print(f"Spiel-{spiel_id}: {spiel}")
                spieler = get_spieler(saison_id, spiel_id)
                pprint(spieler)

            return


def get_saisonen():
    saisonen = {
        int(year[0]): year[1] for year in sportwinner_api({"command": "GetSaisonArray"})
    }
    return saisonen


def get_ligen(saison_id, bezirk_id=0, kreis_id=0) -> dict:
    ligen = {
        int(liga[0]): liga[1]
        for liga in sportwinner_api(
            {
                "command": "GetLigaArray",
                "id_saison": saison_id,
                "id_bezirk": bezirk_id,
                "id_kreis": kreis_id,
                "favorit": "",
                "art": 1,
            }
        )
    }
    return ligen


def get_spiele(saison_id, liga_id, klub_id=0, bezirk_id=0, kreis_id=0, spieltag_id=0):
    """
    id, datum, uhrzeit, verein,
    """
    spiele_data = {
        "command": "GetSpiel",
        "id_saison": saison_id,
        "id_klub": klub_id,
        "id_bezirk": bezirk_id,
        "id_kreis": kreis_id,
        "id_liga": liga_id,
        "id_spieltag": spieltag_id,
        "favorit": "",
        "art_bezirk": 0,
        "art_kreis": 0,
        "art_liga": 0,
        "art_spieltag": 0,
    }

    spiele = {}
    for spiel in sportwinner_api(spiele_data):
        spiele.update(
            {spiel[0]: {"datum": spiel[1], "heim": spiel[3], "gast": spiel[6]}}
        )
    return spiele


def get_spieler(saison_id, spiel_id):
    spiel_data = {
        "command": "GetSpielerInfo",
        "id_saison": saison_id,
        "id_spiel": spiel_id,
    }
    body = sportwinner_api(spiel_data)
    spieler = []
    for match in body:
        spieler.append(
            {
                "name": match[0],
                "bahn1": match[1],
                "bahn2": match[2],
                "bahn3": match[3],
                "bahn4": match[4],
                "gesammt": match[5],
            }
        )
        spieler.append(
            {
                "name": match[-1],
                "bahn1": match[-2],
                "bahn2": match[-3],
                "bahn3": match[-4],
                "bahn4": match[-5],
                "gesammt": match[-6],
            }
        )

    return spieler


def sportwinner_api(data: dict):
    header = {"Referer": "https://bskv.sportwinner.de/"}
    response = post(
        "https://bskv.sportwinner.de/php/bskv/service.php",
        data=data,
        headers=header,
    )
    return response.json()


if __name__ == "__main__":
    main()
