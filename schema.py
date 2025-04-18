# schema.py
from sqlalchemy import text


def create_all_tables(engine):
    with engine.begin() as con:
        con.execute(
            text("""
            CREATE TABLE IF NOT EXISTS saisons (
                id TEXT PRIMARY KEY,
                jahr TEXT,
                ist_abgeschlossen TEXT
            )
        """)
        )
        con.execute(
            text("""
            CREATE TABLE IF NOT EXISTS ligen (
                id TEXT PRIMARY KEY,
                saison_id TEXT,
                bezirk_id TEXT,
                kreis_id TEXT,
                name TEXT,
                ist_aktiv TEXT,
                spielleiter TEXT,
                tel_1 TEXT,
                tel_2 TEXT,
                tel_3 TEXT,
                mail TEXT,
                FOREIGN KEY (saison_id) REFERENCES saisons(id)
            )
        """)
        )
        con.execute(
            text("""
            CREATE TABLE IF NOT EXISTS bezirke (
                id TEXT PRIMARY KEY,
                name TEXT,
                saison_id TEXT,
                FOREIGN KEY (saison_id) REFERENCES saisons(id)
            )
        """)
        )
        con.execute(
            text("""
            CREATE TABLE IF NOT EXISTS kreise (
                id TEXT PRIMARY KEY,
                mandant_id TEXT,
                land_id TEXT,
                saison_id TEXT,
                bezirk_id TEXT,
                name TEXT,
                FOREIGN KEY (saison_id) REFERENCES saisons(id),
                FOREIGN KEY (bezirk_id) REFERENCES bezirke(id)
            )
        """)
        )
        con.execute(
            text("""
            CREATE TABLE IF NOT EXISTS spieltage (
                id TEXT PRIMARY KEY,
                saison_id TEXT,
                liga_id TEXT,
                nummer TEXT,
                name TEXT,
                ist_abgeschlossen TEXT,
                FOREIGN KEY (saison_id) REFERENCES saisons(id),
                FOREIGN KEY (liga_id) REFERENCES ligen(id)
            )
        """)
        )
        con.execute(
            text("""
            CREATE TABLE IF NOT EXISTS spiele (
                id TEXT PRIMARY KEY,
                saison_id TEXT,
                bezirk_id TEXT,
                kreis_id TEXT,
                liga_id TEXT,
                spieltag_id TEXT,
                datum TEXT,
                uhrzeit TEXT,
                heim_name TEXT,
                heim_gesamt TEXT,
                heim_mp TEXT,
                heim_sp TEXT,
                gast_name TEXT,
                gast_gesamt TEXT,
                gast_mp TEXT,
                gast_sp TEXT,
                status TEXT,
                info TEXT,
                stream_link TEXT,
                FOREIGN KEY (saison_id) REFERENCES saisons(id),
                FOREIGN KEY (bezirk_id) REFERENCES bezirke(id),
                FOREIGN KEY (kreis_id) REFERENCES kreise(id),
                FOREIGN KEY (spieltag_id) REFERENCES spieltage(id),
                FOREIGN KEY (liga_id) REFERENCES ligen(id)
            )
        """)
        )
        con.execute(
            text("""
            CREATE TABLE IF NOT EXISTS spieler (
                id TEXT PRIMARY KEY,
                name TEXT,
                bahn_1 TEXT,
                bahn_2 TEXT,
                bahn_3 TEXT,
                bahn_4 TEXT,
                gesamt TEXT,
                sp TEXT,
                mp TEXT,
                spiel_id TEXT,
                FOREIGN KEY (spiel_id) REFERENCES spiele(id)
            )
        """)
        )
