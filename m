From: Josip Rodin <joy@entuzijast.net>
Date: Wed, 24 Oct 2007 23:28:12 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071024232812.GA557@keid.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Oct 24, 2007 at 03:58:29PM -0700, David Miller wrote:
> I know, I've seen this report a million times :-)

Oh, I know you know, I mailed you a while ago and you told me to mail
the mailing list :)

> I can't reproduce it, I've even tried the fabled test case
> where you spawn thousands of dpkg-query instances and it never
> does anything wrong on my Niagara boxes.
> 
> So something is different about your environment than mine.
> 
> Let's see if there is some aspect of the environment that
> contributed to the problem occurring.  Please reproduce
> with 2.6.23-final and then list (I know this is redundant,
> just humor me :-):

Confirming that the machine could reproduce the problem with 2.6.23.1.
(I can send over the .config if it matters.)

> 1) system type

A Sun Fire 280R, with two CPU boards, each carrying a TI UltraSparc III
(Cheetah), and 2 GB of RAM. If you need more info, just say.

(Bernd Zeimetz has previously suggested that the problem is linked to
the processor type, the USIII.)

> 2) compiler used to build kernel and is it SMP?

gcc (GCC) 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)

I've no idea if that compiler is SMP, if you want I'll ask someone else.

> 3) glibc in use
> 4) compiler used to build running glibc

In that particular chroot, it's:

chroot-unstable% lib/libc-2.6.1.so
GNU C Library stable release version 2.6.1, by Roland McGrath et al.
[...]
Compiled by GNU CC version 4.2.1 (Debian 4.2.1-5).
Compiled on a Linux >>2.6.17-rc1<< system on 2007-09-04.
Available extensions:
        crypt add-on version 2.1 by Michael Glad and others
        GNU Libidn by Simon Josefsson
        Native POSIX Threads Library by Ulrich Drepper et al
        BIND-8.2.3-T5B
        software FPU emulation by Richard Henderson, Jakub Jelinek and
        others
[...]

Outside of that chroot, it's:

% /lib/libc-2.3.6.so 
GNU C Library stable release version 2.3.6, by Roland McGrath et al.
[...]
Compiled by GNU CC version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21).
Compiled on a Linux 2.6.18 system on 2007-03-01.
Available extensions:
        GNU libio by Per Bothner
        crypt add-on version 2.1 by Michael Glad and others
        GNU Libidn by Simon Josefsson
        linuxthreads-0.10 by Xavier Leroy
        BIND-8.2.3-T5B
        libthread_db work sponsored by Alpha Processor Inc
        NIS(YP)/NIS+ NSS modules 0.19 by Thorsten Kukuk
        software FPU emulation by Richard Henderson, Jakub Jelinek and
        others
Thread-local storage support included.
[...]

> If you have a reproducable test case, that's even better.

There doesn't appear to be a pattern, on this machine at least - I just let
the buildd run, building whatever comes up, and after a few hours it
inevitably runs into a wall.

-- 
     2. That which causes joy or happiness.
