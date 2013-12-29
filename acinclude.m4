##   -*- autoconf -*-
# $Id: acinclude.m4,v 1.9 2001/04/30 19:34:11 seli Exp $

dnl    Copyright (C) 1997 Janos Farkas (chexum@shadow.banki.hu)
dnl              (C) 1997,98,99 Stephan Kulow (coolo@kde.org)
dnl              (C) 2005 Martin-Eric Racine (q-funk@iki.fi)

dnl    This file is free software; you can redistribute it and/or
dnl    modify it under the terms of the GNU Library General Public
dnl    License as published by the Free Software Foundation; either
dnl    version 2 of the License, or (at your option) any later version.

dnl    This library is distributed in the hope that it will be useful,
dnl    but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
dnl    Library General Public License for more details.

dnl    You should have received a copy of the GNU Library General Public License
dnl    along with this library; see the file COPYING.LIB.  If not, write to
dnl    the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
dnl    Boston, MA 02111-1307, USA.

dnl ------------------------------------------------------------------------
dnl Find the header files and libraries for X-Windows. Extended the
dnl macro AC_PATH_X
dnl ------------------------------------------------------------------------
dnl
AC_DEFUN([K_PATH_X],
[
AC_REQUIRE([AC_PROG_CPP])
AC_MSG_CHECKING(for X)
AC_LANG_SAVE
AC_LANG_C
AC_CACHE_VAL(ac_cv_have_x,
[# One or both of the vars are not set, and there is no cached value.
if test "{$x_includes+set}" = set || test "$x_includes" = NONE; then
   kde_x_includes=NO
else
   kde_x_includes=$x_includes
fi
if test "{$x_libraries+set}" = set || test "$x_libraries" = NONE; then
   kde_x_libraries=NO
else
   kde_x_libraries=$x_libraries
fi

# below we use the standard autoconf calls
ac_x_libraries=$kde_x_libraries
ac_x_includes=$kde_x_includes

_AC_PATH_X_DIRECT
_AC_PATH_X_XMKMF
if test -z "$ac_x_includes"; then
ac_x_includes="."
fi
if test -z "$ac_x_libraries"; then
ac_x_libraries="/usr/lib"
fi
#from now on we use our own again

# when the user already gave --x-includes, we ignore
# what the standard autoconf macros told us.
if test "$kde_x_includes" = NO; then
  kde_x_includes=$ac_x_includes
fi

if test "$kde_x_includes" = NO; then
  AC_MSG_ERROR([Can't find X includes. Please check your installation and add the correct paths!])
fi

if test "$ac_x_libraries" = NO; then
  AC_MSG_ERROR([Can't find X libraries. Please check your installation and add the correct paths!])
fi

# Record where we found X for the cache.
ac_cv_have_x="have_x=yes \
         kde_x_includes=$kde_x_includes ac_x_libraries=$ac_x_libraries"
])dnl
eval "$ac_cv_have_x"

if test "$have_x" != yes; then
  AC_MSG_RESULT($have_x)
  no_x=yes
else
  AC_MSG_RESULT([libraries $ac_x_libraries, headers $kde_x_includes])
fi

if test -z "$kde_x_includes" || test "x$kde_x_includes" = xNONE; then
  X_INCLUDES=""
  x_includes="."; dnl better than nothing :-
 else
  x_includes=$kde_x_includes
  X_INCLUDES="-I$x_includes"
fi

if test -z "$ac_x_libraries" || test "x$ac_x_libraries" = xNONE; then
  X_LDFLAGS=""
  x_libraries="/usr/lib"; dnl better than nothing :-
 else
  x_libraries=$ac_x_libraries
  X_LDFLAGS="-L$x_libraries"
fi
all_includes="$X_INCLUDES"
all_libraries="$X_LDFLAGS"

AC_SUBST(X_INCLUDES)
AC_SUBST(X_LDFLAGS)
AC_SUBST(x_libraries)
AC_SUBST(x_includes)

# Check for libraries that X11R6 Xt/Xaw programs need.
ac_save_LDFLAGS="$LDFLAGS"
test -n "$x_libraries" && LDFLAGS="$LDFLAGS -L$x_libraries"
# SM needs ICE to (dynamically) link under SunOS 4.x (so we have to
# check for ICE first), but we must link in the order -lSM -lICE or
# we get undefined symbols.  So assume we have SM if we have ICE.
# These have to be linked with before -lX11, unlike the other
# libraries we check for below, so use a different variable.
#  --interran@uluru.Stanford.EDU, kb@cs.umb.edu.
AC_CHECK_LIB(ICE, IceConnectionNumber,
  [LIBSM="$X_PRELIBS -lSM"], , $X_EXTRA_LIBS)
AC_SUBST(LIBSM)
LDFLAGS="$ac_save_LDFLAGS"

AC_SUBST(X_PRE_LIBS)

LIB_X11='-lX11 $(LIBSOCKET)'
AC_SUBST(LIB_X11)

AC_MSG_CHECKING(for libXext)
AC_CACHE_VAL(kde_cv_have_libXext,
[
kde_ldflags_safe="$LDFLAGS"
kde_libs_safe="$LIBS"

LDFLAGS="$X_LDFLAGS $USER_LDFLAGS"
LIBS="-lXext -lX11 $LIBSOCKET"

AC_TRY_LINK([
#include <stdio.h>
],
[
printf("hello Xext\n");
],
kde_cv_have_libXext=yes,
kde_cv_have_libXext=no
   )

LDFLAGS=$kde_ldflags_safe
LIBS=$kde_libs_safe
 ])

AC_MSG_RESULT($kde_cv_have_libXext)

if test "kde_cv_have_libXext" = "no"; then
  AC_MSG_ERROR([We need a working libXext to proceed. Since configure
can't find it itself, we stop here assuming that make wouldn't find
them either.])
fi

])

dnl -----  Check for the XKB extension -----
AC_DEFUN([NM_CHECK_XKB],
[
ac_save_ldflags="$LDFLAGS"
LDFLAGS="$X_LDFLAGS"
AC_CHECK_HEADER(X11/XKBlib.h, 
    [AC_CHECK_LIB( Xext, XkbLockModifiers,
	[AC_DEFINE(HAVE_XKB, 1, [Define if you have the XKB extension])], 
	, -lX11 [ $X_PRE_LIBS ])
    ])
LDFLAGS="$ac_save_ldflags"
])
dnl ----------

dnl -----  Check for the XTEST extension -----
AC_DEFUN([NM_CHECK_XTEST],
[
ac_save_ldflags="$LDFLAGS"
LDFLAGS="$X_LDFLAGS"
XTESTLIB=
AC_CHECK_HEADER(X11/extensions/XTest.h,
    [AC_CHECK_LIB( Xtst, XTestFakeKeyEvent,
        [AC_DEFINE(HAVE_XTEST, 1, [Define if you have the XTest extension])
         XTESTLIB=-lXtst],
        , [ -lXext -lX11 $X_PRE_LIBS ])
    ])
AC_SUBST(XTESTLIB)
LDFLAGS="$ac_save_ldflags"
])
dnl ----------

## ------------------------------------------------------------------------
## Find a file (or one of more files in a list of dirs)
## ------------------------------------------------------------------------
##
AC_DEFUN([AC_FIND_FILE],
[
$3=NO
for i in $2;
do
  for j in $1;
  do
    if test -r "$i/$j"; then
      $3=$i
      break 2
    fi
  done
done
])

dnl -----------------------------------------------------------
dnl   Check for the Xsetup file ( for xdm )
dnl -----------------------------------------------------------
AC_DEFUN([NM_CHECK_XSETUP],
[
AC_MSG_CHECKING([for Xsetup file])
AC_FIND_FILE( Xsetup, /etc/X11/xdm /usr/X11R6/lib/X11/xdm /var/X11/xdm /usr/openwin/xdm,xsetup)
if test ! "$xsetup" = "NO" ; then
    xsetup="$xsetup/Xsetup"
else
    AC_FIND_FILE( Xsetup_0, /etc/X11/xdm  /usr/X11R6/lib/X11/xdm /var/X11/xdm /usr/openwin/xdm,xsetup)
    if test ! "$xsetup" = "NO" ; then
        xsetup="$xsetup/Xsetup_0"
    fi
fi
if test "$xsetup" = "NO" ; then
    xsetup=
    AC_MSG_RESULT(no)
else
    AC_MSG_RESULT($xsetup)
fi
AC_SUBST(xsetup)
])

dnl -----------------------------------------------------------
dnl   Check for the xinitrc file ( for startx )
dnl -----------------------------------------------------------

AC_DEFUN([NM_CHECK_XINITRC],
[
AC_MSG_CHECKING([for xinitrc file])
AC_FIND_FILE( xinitrc, /etc/X11/xinit /usr/X11R6/lib/X11/xinit /var/X11/xinit /usr/openwin/xinit,xinitrc)
if test ! "$xinitrc" = "NO" ; then
    xinitrc="$xinitrc/xinitrc"
fi
if test "$xinitrc" = "NO" ; then
    xinitrc=
    AC_MSG_RESULT(no)
else
    AC_MSG_RESULT($xinitrc)
fi
AC_SUBST(xinitrc)
])
