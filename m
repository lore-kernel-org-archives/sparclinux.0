From: Hamish Greig <hgreig@bigpond.net.au>
Date: Wed, 18 Oct 2006 23:12:21 +0000
Subject: Re: disk diagnostics
Message-Id: <200610190912.25149.hgreig@bigpond.net.au>
List-Id: <sparclinux.vger.kernel.org>
References: <200401070724.20426.pkarlsen@mandriva.com>
In-Reply-To: <200401070724.20426.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Thursday 19 October 2006 08:30, Per =D8yvind Karlsen wrote:
> Onsdag 18 oktober 2006 23:59, skrev Chris Newport:
> > Per =D8yvind Karlsen wrote:
> > >This might be offtopic, but I'm not sure where else to ask..
> > >
> > >I'm in the need of some disk diagnostic software for sparc (like the
> > > ones vendors supply for x86), anyone with knowledge of availability of
> > > such?
> >
> > The solaris format command has plenty of diagnostic options, some are
> > non-destructive.
> >
> > man format    is your friend.
>
> okay, so that would require solaris then, no such thing available here( ;)
>
> Oh well, I guess that I could just put it in a x86 box and run diagnostics
> there if nothing else, less hazzle than installing solaris at least..

Format is available on the solaris install discs, you can simply boot from =

cdrom, tell the installer to quit instead of partitioning, then run format =

from the terminal window  and when finished, reboot into your regular OS.

hgg
