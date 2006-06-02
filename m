From: David Miller <davem@davemloft.net>
Date: Fri, 02 Jun 2006 08:20:32 +0000
Subject: Re: [PATCH]: Fix D-cache corruption in mremap()
Message-Id: <20060602.012032.11599733.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060601.175258.41634623.davem@davemloft.net>
In-Reply-To: <20060601.175258.41634623.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Christian Joensson" <christian.joensson@gmail.com>
Date: Fri, 2 Jun 2006 10:04:29 +0200

> On 6/2/06, David Miller <davem@davemloft.net> wrote:
> > From: David Miller <davem@davemloft.net>
> > Date: Thu, 01 Jun 2006 17:52:58 -0700 (PDT)
> >
> > > I'll also post a little reproducer program that can be used to
> > > accurately see if the patch really fixes the problem on your
> > > machine or not, which should help with the variability of the
> > > dpkg corruption case.
> >
> > As promised:
> >
> > /* mremap() stress tester for D-cache aliasing platforms.
> >  *
> >  * Copyright (C) 2006 David S. Miller (davem@davemloft.net)
> >  *
> 
> great, so if I compile with gcc and run it... I get this:
> 
> [chj@arnljot ~]$ gcc mremap-stress-tester.c
> [chj@arnljot ~]$ ./a.out
> unmapped region at 0xf7d72000
> Initial main_buf at 0xf7d72000
> Bogus value 00000001 should be 00000002
> [chj@arnljot ~]$ uname -a
> Linux arnljot 2.6.16-1.2128sp4 #1 Fri May 26 10:08:13 EDT 2006 sparc64
> sparc64 sparc64 GNU/Linux
> [chj@arnljot ~]$
> 
> which means?

It means the kernel you are running has the bug, try to rerun
it with the kernel patch I posted, it should no longer produce
the:

Bogus value 00000001 should be 00000002

lines.
