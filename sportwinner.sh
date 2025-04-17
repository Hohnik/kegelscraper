curl 'https://bskv.sportwinner.de/php/bskv/service.php' \
  -H 'Referer: https://bskv.sportwinner.de/' \
  --data-raw 'command=GetSpielerInfo&id_saison=2&id_spiel=8107' \
  # --compressed \
  # --output service.php

