From: Frans van Berckel <fberckel@xs4all.nl>
Date: Sat, 13 Mar 2010 11:05:24 +0000
Subject: Re: XVR-500 additional pci ids
Message-Id: <1268478324.1775.43.camel@deblnxsrv254.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <201002251955.23519.dennis@ausil.us>
In-Reply-To: <201002251955.23519.dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 2010-03-12 at 00:08 -0800, David Miller wrote:
> From: Frans van Berckel <fberckel@xs4all.nl>
> Date: Fri, 12 Mar 2010 08:54:39 +0100
> 
> >> sparc64: Add very basic XVR-1000 framebuffer driver.
> > 
> > Oh that sound rely nice, wanne say thank you! Gonna test this XVR 1000
> > patch later on and will report the results.
> 
> I look forward to it :-)

I am not wanne dislike perl in general today, bud is it possible, one of
the scripts is un-setting the LC_ALL value? 

It's because i set my environment LC_ALL="C" and perl -V:d_setlocale
echo's d_setlocale='define'; but it's still warning on.

If not it's somewhere in Debian and out of the scoop of this list!

make[3]: Entering directory `/usr/src/linux-source-2.6-next-git'
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  CALL    scripts/checksyscalls.sh
<stdin>:1527:2: warning: #warning syscall fanotify_init not implemented
<stdin>:1531:2: warning: #warning syscall fanotify_mark not implemented
<stdin>:1535:2: warning: #warning syscall getprlimit not implemented
<stdin>:1539:2: warning: #warning syscall setprlimit not implemented
  HOSTCC  scripts/genksyms/genksyms.o
  SHIPPED scripts/genksyms/lex.c
  SHIPPED scripts/genksyms/parse.h
  SHIPPED scripts/genksyms/keywords.c
  HOSTCC  scripts/genksyms/lex.o
  SHIPPED scripts/genksyms/parse.c
  HOSTCC  scripts/genksyms/parse.o
  HOSTLD  scripts/genksyms/genksyms
  CC      scripts/mod/empty.o
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = "en",
	LC_ALL = (unset),
	LC_CTYPE = "C",
	LC_COLLATE = "C",
	LC_MESSANGES = "C",
	LC_LANG = "C",
	LC_NUMERIC = "C",
	LANG = "en"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").

