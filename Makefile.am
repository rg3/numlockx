# $Id: Makefile.am,v 1.8 2001/04/30 19:34:10 seli Exp $

bin_PROGRAMS = numlockx

numlockx_SOURCES = main.c 
numlockx_LDADD   = @XTESTLIB@ -lXext -lX11 @X_PRE_LIBS@
numlockx_LDFLAGS = @X_LDFLAGS@
INCLUDES = @X_INCLUDES@

CFLAGS = @CFLAGS@ -Wall -pedantic

EXTRA_DIST = AUTHORS LICENSE ChangeLog INSTALL README TODO 

AUTOMAKE_OPTIONS = foreign

xsetup:
	@if test -n "@xsetup@"; then \
	    echo "Modifying @xsetup@"; \
	    rm -f @xsetup@.tmp ;\
	    cat @xsetup@ | grep -v "numlockx" > @xsetup@.tmp ;\
	    echo "# Turn NumLock on ( numlockx ) ---------------" >> @xsetup@.tmp ;\
	    echo "${bindir}/numlockx " >> @xsetup@.tmp ;\
	    echo "# numlockx -----------------------------------" >> @xsetup@.tmp ;\
	    cp -f @xsetup@ ${srcdir}/xsetup.sav ;\
	    cat @xsetup@.tmp > @xsetup@ ;\
	    rm -f @xsetup@.tmp; \
	else \
	    echo "Xsetup not found! - nothing to update";\
	fi

xsetup_uninstall:
	@if test -n "@xsetup@"; then \
	    echo "Restoring @xsetup@"; \
	    rm -f @xsetup@.tmp ;\
	    cat @xsetup@ | grep -v "numlockx" > @xsetup@.tmp ;\
	    cat @xsetup@.tmp > @xsetup@ ;\
	    rm -f @xsetup@.tmp; \
	else \
	    echo "Xsetup not found! - nothing to restore";\
	fi

xinitrc:
	@if test -n "@xinitrc@"; then \
	    echo "Modifying @xinitrc@"; \
	    rm -f @xinitrc@.tmp ;\
	    cat @xinitrc@ | grep -v "numlockx" \
		| ( was_mod= ; \
		    ifs_sav=$IFS ;\
		    IFS= ;\
		    while read ln; do \
			if test -n "$$ln"; then \
			    if test "$${ln#\#}" = "$$ln" ; then \
				if test -z "$$was_mod"; then \
			    	    was_mod=1 ;\
			    	    echo "# Turn NumLock on ( numlockx ) ---------------";\
			    	    echo "${bindir}/numlockx ";\
				    echo "# numlockx -----------------------------------" ;\
				fi \
			    fi \
			fi; \
			echo "$$ln" ;\
		    done; \
		    IFS=$$ifs_sav ;\
		    if test -z "$$was_mod"; then \
		        was_mod=1 ;\
		        echo "# Turn NumLock on ( numlockx ) ---------------";\
		        echo "${bindir}/numlockx ";\
			echo "# numlockx -----------------------------------" ;\
		    fi \
		  ) \
		> @xinitrc@.tmp ;\
	    cp -f @xinitrc@ ${srcdir}/xinitrc.sav ;\
	    cat @xinitrc@.tmp > @xinitrc@ ;\
	    rm -f @xinitrc@.tmp ;\
	else \
	    echo "xinitrc not found! - nothing to update";\
	fi

xinitrc_uninstall:
	@if test -n "@xinitrc@"; then \
	    echo "Restoring @xinitrc@"; \
	    rm -f @xinitrc@.tmp ;\
	    cat @xinitrc@ | grep -v "numlockx" > @xinitrc@.tmp ;\
	    cat @xinitrc@.tmp > @xinitrc@ ;\
	    rm -f @xinitrc@.tmp ;\
	else \
	    echo "xinitrc not found! - nothing to restore";\
	fi

user_xinitrc:
	@if test -f ~/.xinitrc; then \
	    echo "Modifying ~/.xinitrc"; \
	    rm -f xinitrc.tmp ;\
	    cat ~/.xinitrc | grep -v "numlockx" \
		| ( was_mod= ; \
		ifs_sav=$IFS ;\
		IFS= ;\
		while read ln; do \
		    if test -n "$$ln"; then \
			if test "$${ln#\#}" = "$$ln" ; then \
			    if test -z "$$was_mod"; then \
		    		was_mod=1 ;\
		    		echo "# Turn NumLock on ( numlockx ) ---------------";\
		    		echo "${bindir}/numlockx ";\
				echo "# numlockx -----------------------------------" ;\
			    fi \
			fi \
		    fi; \
		    echo "$$ln" ;\
		done; \
		IFS=$$ifs_sav ;\
		if test -z "$$was_mod"; then \
	    	    was_mod=1 ;\
	    	    echo "# Turn NumLock on ( numlockx ) ---------------";\
	    	    echo "${bindir}/numlockx ";\
		    echo "# numlockx -----------------------------------" ;\
		fi \
	          ) \
		> xinitrc.tmp ;\
		cp -f ~/.xinitrc ${srcdir}/xinitrc.sav ;\
		cat xinitrc.tmp > ~/.xinitrc ;\
		rm -f xinitrc.tmp ;\
	else \
	    echo "# Turn NumLock on ( numlockx ) ---------------" >> ~/.xinitrc; \
	    echo "${bindir}/numlockx " >> ~/.xinitrc;\
	    echo "# numlockx -----------------------------------" >> ~/.xinitrc;\
	    chmod 700 ~/.xinitrc ; \
	fi
