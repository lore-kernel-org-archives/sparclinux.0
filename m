From: David Miller <davem@davemloft.net>
Date: Wed, 24 Oct 2007 23:36:03 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071024.163603.04015483.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 25 Oct 2007 01:28:12 +0200

> On Wed, Oct 24, 2007 at 03:58:29PM -0700, David Miller wrote:
> > Let's see if there is some aspect of the environment that
> > contributed to the problem occurring.  Please reproduce
> > with 2.6.23-final and then list (I know this is redundant,
> > just humor me :-):
> 
> Confirming that the machine could reproduce the problem with 2.6.23.1.
> (I can send over the .config if it matters.)

Ok, good.

> > 1) system type
> 
> A Sun Fire 280R, with two CPU boards, each carrying a TI UltraSparc III
> (Cheetah), and 2 GB of RAM. If you need more info, just say.
> 
> (Bernd Zeimetz has previously suggested that the problem is linked to
> the processor type, the USIII.)

I think it might be too.

> > 2) compiler used to build kernel and is it SMP?
> 
> gcc (GCC) 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)
> 
> I've no idea if that compiler is SMP, if you want I'll ask someone else.

I was asking if the running kernel were SMP or not, I'll assume it is
:-)

> > 3) glibc in use
> > 4) compiler used to build running glibc
> 
> In that particular chroot, it's:

Thanks for the info.

> > If you have a reproducable test case, that's even better.
> 
> There doesn't appear to be a pattern, on this machine at least - I just let
> the buildd run, building whatever comes up, and after a few hours it
> inevitably runs into a wall.

If you try, within that troublesome build-root, a few times to try to
fork off a couple hundred:

	dpkg-query --something python-2.5

or whatever, can you get some of processes to wedge under that
build root?

If it only happens with UltraSPARC-III and IIIi chips, that is a
huge clue.

It turns out I have a 280R here as well, so if necessary I can
fire it up and work on reproducing your environment.
