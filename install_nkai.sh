NKAI_DIR=nkait1-1.4.2
NKAI_ARCHIVE=$NKAI_DIR/nkaiu
TEXLIVE_DIR=/usr/local/texlive

sudo chown $USER $TEXLIVE_DIR
rm -rf ~/Library/texlive

PFB_DIR=$TEXLIVE_DIR/texmf-local/fonts/type1/nkaiu
TFM_DIR=$TEXLIVE_DIR/texmf-local/fonts/tfm/nkaiu
AFM_DIR=$TEXLIVE_DIR/texmf-local/fonts/afm/nkaiu
ENC_DIR=$TEXLIVE_DIR/texmf-local/fonts/enc/nkaiu
MAP_DIR=$TEXLIVE_DIR/texmf-local/fonts/map/dvips
FD_DIR=$TEXLIVE_DIR/texmf-local/tex/latex/cjk/UTF8

mkdir -p $PFB_DIR
mkdir -p $TFM_DIR
mkdir -p $AFM_DIR
mkdir -p $ENC_DIR
mkdir -p $MAP_DIR
mkdir -p $FD_DIR

find $NKAI_ARCHIVE -iname '*.pfb' -exec cp -v {} $PFB_DIR \;
find $NKAI_ARCHIVE -iname '*.tfm' -exec cp -v {} $TFM_DIR \;
find $NKAI_ARCHIVE -iname '*.afm' -exec cp -v {} $AFM_DIR \;
find $NKAI_ARCHIVE -iname '*.enc' -exec cp -v {} $ENC_DIR \;
cp -v $NKAI_DIR/nkaiu.map $MAP_DIR
cp -v $NKAI_DIR/c70nkai.fd $NKAI_DIR/c70nkai.fdx $FD_DIR

texhash
updmap --enable Map=nkaiu.map
