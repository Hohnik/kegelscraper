import time
from hashlib import md5
import requests
import pandas as pd
from sqlalchemy import create_engine, text
from sqlalchemy.exc import IntegrityError
from itertools import count

engine = create_engine("sqlite:///database.db", echo=False)
inf = count()


def export_data(table_name: str, data: list):
    df = pd.DataFrame(data)
    with engine.begin() as con:
        try:
            old = pd.read_sql_table(table_name, con=con)
            df = pd.concat([old, df], ignore_index=True)
            df = df.drop_duplicates(subset=["id"])
            df.to_sql(name=table_name, con=con, if_exists="append", index=False)
        except IntegrityError:
            # Duplicates
            pass


def get_saisons():
    """
    {
        "id": int,
        "jahr": int,
        "ist_abgeschlossen": int
    }
    """
    saisons = sportwinner_api({"command": "GetSaisonArray"})
    name = "saisons"
    mappedSaisons = [
        {"id": saison[0], "jahr": saison[1], "ist_abgeschlossen": saison[2]}
        for saison in saisons
    ]
    if mappedSaisons:
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
    mappedLigen = [
        {
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
        }
        for liga in ligen
    ]
    if mappedLigen:
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
    mappedBezirke = [
        {"id": bezirk[0], "saison_id": saison_id, "name": bezirk[1]}
        for bezirk in bezirke
    ]
    if mappedBezirke:
        export_data(name, mappedBezirke)
    return mappedBezirke


def get_kreise(saison_id, mandant_id=1, land_id=1, bezirk_id=0):
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
    name = "kreise"
    kreise = sportwinner_api(
        {
            "command": "GetKreisArray",
            "id_mandant": mandant_id,
            "id_saison": saison_id,
            "id_land": land_id,
            "id_bezirk": bezirk_id,
        }
    )
    mappedKreise = [
        {
            "id": kreis[0],
            "mandant_id": mandant_id,
            "saison_id": saison_id,
            "land_id": land_id,
            "bezirk_id": bezirk_id,
            "name": kreis[1],
        }
        for kreis in kreise
    ]
    if mappedKreise:
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
    spieltage = sportwinner_api(
        {
            "command": "GetSpieltagArray",
            "id_saison": saison_id,
            "id_liga": liga_id,
        }
    )
    mappedSpieltage = [
        {
            "id": spieltag[0],
            "saison_id": saison_id,
            "liga_id": liga_id,
            "nummer": spieltag[1],
            "name": spieltag[2],
            "ist_abgeschlossen": spieltag[3],
        }
        for spieltag in spieltage
    ]
    if mappedSpieltage:
        export_data(name, mappedSpieltage)
    return mappedSpieltage


def get_spiele(saison_id, liga_id, spieltag_id, klub_id=0, bezirk_id=0, kreis_id=0):
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
    spiele = sportwinner_api(
        {
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
        }
    )
    mappedSpiele = []
    for spiel in spiele:
        spiel_id = spiel[0]
        mappedMannschaften = get_spiel_info(saison_id, spiel_id)
        mappedSpiel = {
            "id": spiel[0],
            "saison_id": saison_id,
            "bezirk_id": bezirk_id,
            "kreis_id": kreis_id,
            "liga_id": liga_id,
            "spieltag_id": spieltag_id,
            "datum": spiel[1],
            "uhrzeit": spiel[2],
            "heim_name": spiel[3],
            "heim_gesamt": mappedMannschaften["heim_mannschaft"]["gesamt"],
            "heim_mp": spiel[4],
            "heim_sp": mappedMannschaften["heim_mannschaft"]["sp"],
            "gast_name": spiel[6],
            "gast_gesamt": mappedMannschaften["gast_mannschaft"]["gesamt"],
            "gast_mp": spiel[5],
            "gast_sp": mappedMannschaften["gast_mannschaft"]["sp"],
            "status": spiel[9],
            "info": spiel[10],
            "stream_link": spiel[12],
        }
        mappedSpiele.append(mappedSpiel)
    if mappedSpiele:
        export_data(name, mappedSpiele)
    return mappedSpiele


def insert_spieler(engine, spieler_data):
    insert_sql = text("""
        INSERT INTO spieler (
            id, name, bahn_1, bahn_2, bahn_3, bahn_4, gesamt, sp, mp, spiel_id
        ) VALUES (
            :id, :name, :bahn_1, :bahn_2, :bahn_3, :bahn_4, :gesamt, :sp, :mp, :spiel_id
        )
    """)
    if isinstance(spieler_data, dict):
        spieler_data = [spieler_data]
    with engine.begin() as con:
        for row in spieler_data:
            try:
                con.execute(insert_sql, row)
            except IntegrityError:
                # Duplicates
                pass


def get_spiel_info(saison_id, spiel_id):
    """
    {
        "heim_mannschaft": {
            "gesamt": int,
            "mp": float,
            "sp": float
        },
        "gast_mannschaft": {
            "gesamt": int,
            "mp": float,
            "sp": float
        }
    }
    """
    duelle = sportwinner_api(
        {
            "command": "GetSpielerInfo",
            "id_saison": saison_id,
            "id_spiel": spiel_id,
        }
    )
    mappedMannschaften = {
        "heim_mannschaft": {
            "gesamt": duelle[-1][5],
            "mp": duelle[-1][6],
            "sp": duelle[-1][7],
        },
        "gast_mannschaft": {
            "gesamt": duelle[-1][10],
            "mp": duelle[-1][9],
            "sp": duelle[-1][8],
        },
    }
    for duell in duelle[1:-1]:
        mappedHeimSpieler = {
            "id": md5(f"{spiel_id}-{duell[0]}-h".encode("utf-8")).hexdigest()[:10],
            "spiel_id": spiel_id,
            "name": duell[0],
            "bahn_1": duell[1],
            "bahn_2": duell[2],
            "bahn_3": duell[3],
            "bahn_4": duell[4],
            "gesamt": duell[5],
            "sp": duell[6],
            "mp": duell[7],
        }
        mappedGastSpieler = {
            "id": md5(f"{spiel_id}-{duell[15]}-g".encode("utf-8")).hexdigest()[:10],
            "spiel_id": spiel_id,
            "name": duell[15],
            "bahn_1": duell[14],
            "bahn_2": duell[13],
            "bahn_3": duell[12],
            "bahn_4": duell[11],
            "gesamt": duell[10],
            "sp": duell[9],
            "mp": duell[8],
        }
        insert_spieler(engine, mappedHeimSpieler)
        insert_spieler(engine, mappedGastSpieler)
    return mappedMannschaften


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
