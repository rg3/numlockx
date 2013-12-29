#! /bin/sh

aclocal \
&& automake -acf \
&& autoconf \
&& autoheader \
&& rm -r autom4te.cache 
if [ -f config.h.in~ ]
then
	rm config.h.in~
fi
