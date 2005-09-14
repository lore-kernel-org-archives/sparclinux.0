From: Peter Jones <pjones@redhat.com>
Date: Wed, 14 Sep 2005 21:58:54 +0000
Subject: Re: Sun v440 and 2.6.13-1.1552sp1smp (Aurora) kernel
Message-Id: <1126735134.23071.17.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.BSO.4.62.0509132211530.5000@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.62.0509132211530.5000@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 2005-09-14 at 12:42 -0300, Gustavo Zacarias wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> David S. Miller wrote:
> 
> > The problem is that the people who can work on fixing
> > this problem (whether it is in the kernel or SILO,
> > we still don't know) are not able to reproduce it.
> 
> The problem lies in SILO, we're using 1.2.6 in our (gentoo) v240 just
> fine to boot off disk.

The fact that an older version of SILO works does not actually mean the
problem is in SILO.  SILO writes to memory, kernel reads from that
memory.  Either part can be buggy, and both have in the past.

If people want this fixed, they need to get a box that's breaking in
front of one of those of us who can debug this sort of failure or debug
it themselves.

-- 
  Peter

