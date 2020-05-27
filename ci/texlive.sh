#!/usr/bin/env sh

export PATH=/tmp/texlive/bin/x86_64-linux:$PATH

# Check for cached version
if ! command -v texlua > /dev/null; then
  # Obtain TeX Live
  curl -LO http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
  tar -xzf install-tl-unx.tar.gz
  cd install-tl-20*

  # Install a minimal system
  ./install-tl --profile=../texlive.profile

  cd ..
fi

# Update infra first
tlmgr update --self

# Install all the required packages
tlmgr install \
      atbegshi \
      atveryend \
      bigintcalc \
      bitset \
      carlisle \
      dvips \
      ec \
      epstopdf-pkg \
      etexcmds \
      geometry \
      gettitlestring \
      graphics \
      graphics-def \
      hycolor \
      hyperref \
      iftex \
      infwarerr \
      intcalc \
      keyval \
      kvdefinekeys \
      kvoptions \
      kvsetkeys \
      latex \
      latex-bin \
      letltxmacro \
      listings \
      ltxcmds \
      luaotfload \
      luatex \
      luatexbase \
      metafont \
      mfware \
      pdfescape \
      pdftexcmds \
      pgf \
      refcount \
      rerunfilecheck \
      texlive-scripts \
      uniquecounter \
      url \
      xcolor \
      xetex

# Keep no backups (not required, simply makes cache bigger)
tlmgr option -- autobackup 0

# Update the TL install but add nothing new
tlmgr update --self --all --no-auto-install

# Install PGF
tlmgr init-usertree --usertree `realpath ..`
export TEXMFHOME=`realpath ..`
