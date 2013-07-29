#!/usr/bin/env sh
# vim:ts=2 sw=2 et
# Edward G.J. Lee <edt1023@cle.linux.org.tw> (2006.03.29)
# Modified U+89D2-U+89FF to fit Taiwan's convention.(2006.10.10)
# Add GBK virtual fonts.(2006.10.11)
# Install New Kai type 1 fonts for GNU/Linux/*BSD LaTeX CJK.
# Upgrade to 1.4.2.(2007.03.20)

BASEN="`basename $0`"
FONTN=nkai
VER="1.4.2"

if [ ! $# -eq 0 ]; then
  echo
  echo "${BASEN%.sh} New Kai type1 1.4.2 for GNU/Linux/*BSD LaTeX CJK."
  echo "Site1: ftp://cle.linux.org.tw/pub2/tex/cjk/fonts/nkait1"
  echo "Site2: http://edt1023.sayya.org/fonts/tex"
  echo
  echo "Usage: ./`basename $0`"
  echo
  exit
fi

if [ "`id -u`" = "0" ]; then
  echo
  echo "Don't use root to do install, abort!"
  echo
  exit
fi

MYTEXMF=$HOME/texmf
MYFONT=$MYTEXMF/fonts
T1DIR=$MYFONT/type1/CJK/$FONTN
TFMDIR=$MYFONT/tfm/CJK/$FONTN
AFMDIR=$MYFONT/afm/CJK/$FONTN
ENCDIR=$MYFONT/enc/CJK/$FONTN
VFDIR=$MYFONT/vf/CJK/$FONTN
MAPDIR=$MYFONT/map/dvips/CJK
LTXDIR=$MYTEXMF/tex/latex/CJK

if [ "$BASEN" != "uninstall.sh" ]; then
  kpsewhich ${FONTN}u01.pfb > /dev/null
  if [ $? = 0 ]; then
    echo
    echo "You already install New Kai Type 1 font, abort!"
    echo
    exit
  fi

  mkdir -p $T1DIR $TFMDIR $AFMDIR $ENCDIR $VFDIR $MAPDIR $LTXDIR/UTF8 $LTXDIR/Bg5 $LTXDIR/GB
  cp -f *.map $MAPDIR
  cp -f ${FONTN}u/*.tfm $TFMDIR
  cp -f ${FONTN}u/*.afm $AFMDIR
  cp -f ${FONTN}u/*.enc $ENCDIR
  cp -f ${FONTN}u/*.pfb $T1DIR
#  cp -f ${FONTN}s/*.pfb $T1DIR
  for i in t s k
  do
    cp -f ${FONTN}$i/*.tfm $TFMDIR
    cp -f ${FONTN}$i/*.vf $VFDIR
  done
  cp -f c70*.* $LTXDIR/UTF8
  cp -f c00*.* $LTXDIR/Bg5
  cp -f c10*.* c19*.* $LTXDIR/GB

  texhash
  echo "Please wait..."
  updmap --enable Map ${FONTN}u.map
  echo
  echo "New Kai Type 1 font $VER Install completely."
  echo "Please use the fontname: $FONTN"
  echo "For example:"
  echo "\begin{CJK}{UTF8}{$FONTN}"
  echo
  echo "You can remove it using uninstall.sh"
  echo
else
  kpsewhich ${FONTN}u01.pfb > /dev/null
  if [ $? = 1 ]; then
    echo
    echo "You didn't install New Kai Type 1."
    echo "Or you are not install by install.sh from"
    echo "New Kai 1.4.2, abort!"
    echo
    exit
  fi

  rm -f $MAPDIR/${FONTN}u.map
  rm -rf $TFMDIR $T1DIR $VFDIR $AFMDIR $ENCDIR
  rm -f $LTXDIR/UTF8/c70${FONTN}.*
  rm -f $LTXDIR/Bg5/c00${FONTN}.*
  rm -f $LTXDIR/GB/c10${FONTN}.*
  rm -f $LTXDIR/GB/c19${FONTN}.*

  texhash
  echo "Please wait..."
  updmap --disable ${FONTN}u.map
  echo
  echo "Uninstall New Kai Type 1 finish."
  echo
fi
