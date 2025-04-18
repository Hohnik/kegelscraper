import time
import requests
import pandas as pd
from pathlib import Path


def export_data(url: str, data: dict):
    data_dir = Path("data")
    data_dir.mkdir(exist_ok=True)
    path = data_dir / url

    df = pd.DataFrame(data)
    df.to_csv(path, mode="w", header=True, index=False)
    return path


def get_saisons():
    """
    {
        "id": int,
        "jahr": int,
        "ist_abgeschlossen": int
    }
    """
    name = "saisons"
    saisons = sportwinner_api({"command": "GetSaisonArray"})
    mappedSaisons = [{"id": saison[0], "jahr": saison[1], "ist_abgeschlossen": saison[2]} for saison in saisons]
    export_data(name, mappedSaisons)
    return mappedSaisons


def get_ligen(saison_id, bezirk_id=0, kreis_id=0) -> dict:
    """
    {
        "id": int,
        "saison_id": int,
        "bezirk_id": int,
        "kreis_id": int,
        "name": str,
        "ist_aktiv": int,
        "spielleiter": str,
        "tel_1": str,
        "tel_2": str,
        "tel_3": str,
        "mail": str
    }
    """
    name = "ligen"
    ligen = sportwinner_api(
            {
                "command": "GetLigaArray",
                "id_saison": saison_id,
                "id_bezirk": bezirk_id,
                "id_kreis": kreis_id,
                "favorit": "",
                "art": 1,
            }
        )
    mappedLigen = [{
        "id": liga[0],
        "saison_id": saison_id,
        "bezirk_id": bezirk_id,
        "kreis_id": kreis_id,
        "name": liga[1],
        "ist_aktiv": liga[2],
        "spielleiter": liga[3],
        "tel_1": liga[4],
        "tel_2": liga[5],
        "tel_3": liga[6],
        "mail": liga[7],
    } for liga in ligen]
    export_data(name, mappedLigen)
    return mappedLigen


def get_bezirke(saison_id):
    """
    {
        "id": int,
        "saison_id": int,
        "name": str
    }
    """
    name = "bezirke"
    bezirke = sportwinner_api({"command": "GetBezirkArray", "id_saison": saison_id})
    mappedBezirke = [{
        "id": bezirk[0],
        "saison_id": saison_id,
        "name": bezirk[1]
    } for bezirk in bezirke]
    export_data(name, mappedBezirke)
    return mappedBezirke


def get_kreise(saison_id, mandant_id=1, land_id=1, bezirk_id=0):
    # id_land: 1 -> bayern
    # id_bezirk: 0 -> bskv, id_bezirk: 6 -> Niederbayern

    """
    {
        "id": int,
        "mandant_id": int,
        "saison_id": int,
        "land_id": int,
        "bezirk_id": int,
        "name": str
    }
    """
    name="kreise"
    kreise = sportwinner_api({
        "command": "GetKreisArray",
        "id_mandant": mandant_id,
        "id_saison": saison_id,
        "id_land": land_id,
        "id_bezirk": bezirk_id,
    })
    mappedKreise = [{
        "id": kreis[0],
        "mandant_id": mandant_id,
        "saison_id": saison_id,
        "land_id": land_id,
        "bezirk_id": bezirk_id,
        "name": kreis[1]
    } for kreis in kreise]
    export_data(name, mappedKreise)
    return mappedKreise


def get_spieltage(saison_id, liga_id):
    """
    {
        "id": int,
        "saison_id": int,
        "liga_id": int,
        "nummer": int,
        "name": str,
        "ist_abgeschlossen": int,
    }
    """
    name = "spieltage"
    spieltage = sportwinner_api({
        "command": "GetSpieltagArray",
        "id_saison": saison_id,
        "id_liga": liga_id,
    })
    mappedSpieltage = [{
        "id": spieltag[0],
        "saison_id": saison_id,
        "liga_id": liga_id,
        "nummer": spieltag[1],
        "name": spieltag[2],
        "ist_abgeschlossen": spieltag[3],
    } for spieltag in spieltage]
    export_data(name, mappedSpieltage)
    return mappedSpieltage


def get_spiele(saison_id, liga_id, spieltag_id, klub_id=0, bezirk_id=0, kreis_id=0):
    # art_bezirk: 0 -> bundesliga, art_bezirk: 1 -> bskv, art_bezirk: 2 -> regierungsbezirke
    # art_kreis: 0 -> bundesliga/bsvk, art_kreis: 1 -> unterfranken, oberfranken, mittelfranken, ...
    # art_liga: 0 -> immer
    # art_spieltag: 2 -> ???

    """
    {
        "id": int,
        "saison_id": int,
        "bezirk_id": int,
        "kreis_id": int,
        "liga_id": int,
        "spieltag_id": int,
        "datum": str,
        "uhrzeit": str,
        "heim_name": str,
        "heim_mp": int,
        "gast_name": str,
        "gast_mp": int,
        "status": str,
        "info": str,
        "stream_link": str
    }
    """
    name = "spiele"
    spiele = sportwinner_api({
        "command": "GetSpiel",
        "id_saison": saison_id,
        "id_klub": klub_id,
        "id_bezirk": bezirk_id,
        "id_kreis": kreis_id,
        "id_liga": liga_id,
        "id_spieltag": spieltag_id,
        "favorit": "",
        "art_bezirk": 1,
        "art_kreis": 0,
        "art_liga": 0,
        "art_spieltag": 2,
    })
    mappedSpiele = [{
        "id": spiel[0],
        "saison_id": saison_id,
        "bezirk_id": bezirk_id,
        "kreis_id": kreis_id,
        "liga_id": liga_id,
        "spieltag_id": spieltag_id,
        "datum": spiel[1],
        "uhrzeit": spiel[2],
        "heim_name": spiel[3],
        "heim_mp": spiel[4],
        "gast_name": spiel[6],
        "gast_mp": spiel[5],
        "status": spiel[9],
        "info": spiel[10],
        "stream_link": spiel[12]
    } for spiel in spiele]
    export_data(name, mappedSpiele)
    return mappedSpiele


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
