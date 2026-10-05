# SPDX-FileCopyrightText: 2026 Alper Çelik <alper@alper-celik.dev>
#
# SPDX-License-Identifier: AGPL-3.0-or-later OR Apache-2.0

{
  stdenvNoCC,
  pandoc,
}:

stdenvNoCC.mkDerivation {
  name = "gitdersleri-site";
  src = ./.;
  nativeBuildInputs = [ pandoc ];
  buildPhase = ''
    mkdir -p $out
    for f in slides/*.md; do
      name=$(basename "$f" .md)
      pandoc --standalone --to=revealjs --output="$out/$name.html" "$f"
    done
    pandoc --standalone --css=style.css --output=$out/index.html index.md
    cp style.css $out/style.css
  '';
  dontInstall = true;
  dontFixup = true;
}
