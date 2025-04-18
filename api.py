import time
import requests


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


session = requests.Session()
headers = {
    "Referer": "https://bskv.sportwinner.de/",
    "User-Agent": (
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) "
        "AppleWebKit/537.36 (KHTML, like Gecko) "
        "Chrome/122.0.0.0 Safari/537.36"
    ),
    "Accept": "application/json, text/javascript, */*; q=0.01",
    "Accept-Language": "de,en-US;q=0.7,en;q=0.3",
    "Connection": "keep-alive",
}


def sportwinner_api(data: dict):
    response = session.post(
        "https://bskv.sportwinner.de/php/bskv/service.php",
        data=data,
        headers=headers,
    )
    if response.status_code != 200:
        print("HTTP error:", response.status_code)
        print(response.text[:500])
        time.sleep(10)  # Wait longer if blocked
        return []
    try:
        return response.json()
    except Exception as e:
        print("Failed to parse JSON!")
        print("Status code:", response.status_code)
        print("Response text:", response.text[:500])
        raise e
