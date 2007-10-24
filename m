From: David Miller <davem@davemloft.net>
Date: Wed, 24 Oct 2007 22:58:29 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071024.155829.10174994.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 25 Oct 2007 00:33:32 +0200

> We've been having grave issues with a few of our sparc build daemon machines
> in Debian. Something causes dpkg-query(8) processes, otherwise harmless, to
> run amok and allocate too much memory, but keep running and become resilient
> to killing. They eventually push the machine to the point where you can only
> ping it, but all the userland and the console is dead.

I know, I've seen this report a million times :-)

I can't reproduce it, I've even tried the fabled test case
where you spawn thousands of dpkg-query instances and it never
does anything wrong on my Niagara boxes.

So something is different about your environment than mine.

Let's see if there is some aspect of the environment that
contributed to the problem occurring.  Please reproduce
with 2.6.23-final and then list (I know this is redundant,
just humor me :-):

1) system type
2) compiler used to build kernel and is it SMP?
3) glibc in use
4) compiler used to build running glibc

If you have a reproducable test case, that's even better.

If necessary I'll try to install a replica of your build
environment here in order to reproduce.
