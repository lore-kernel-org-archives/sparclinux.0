From: Brian Bartholomew <bb@stat.ufl.edu>
Date: Wed, 11 May 2005 15:31:08 +0000
Subject: Re: Which distribution to use?
Message-Id: <20050511153108.C71771D14B@bass.stat.ufl.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20050511145638.B3281C00173@mail.conkret.de>
In-Reply-To: <20050511145638.B3281C00173@mail.conkret.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> I just got an Ultra-30 and an Ultra-10 for myself at home. I want to
> install Linux on at least on of the two machines.
>
> All I did find on the web about Linux on Sparc seems to be about 2-3
> years old, which makes me somewhat sad...
>
> Which is the distribution that supports currently those boxes best?

I'm running a university department with Sun desktops on Gentoo
2004.0, soon to be 2005.something.  The mail server is a Sun 420 which
now runs Linux, and the other 450s will follow:

	+-----+-----------+
	| cnt | hostkind  |
	+-----+-----------+
	|  18 | Ultra1    |
	|  12 | Ultra5b   | different speeds
	|  11 | Ultra5a   |  "
	|   3 | Ultra5d   |  "
	|   2 | Ultra5e   |  "
	|   1 | Ultra5c   |  "
	|   1 | 420R      |
	|   1 | E-450a    | different configurations
	|   1 | E-450b    |  "
	|   1 | Ultra10b  |
	+-----+-----------+

When I went through the Linux selection process, I looked at suse, red
hat, debian, and then used gentoo, which was the only one that I could
get current software on.  It helps that our central services group
uses Gentoo, and the US mirror is here.  I have close to source-
identical systems on Sparc and Intel, and with the next upgrade will
have truly identical ones.

> I'd like to have (due to very little spare time) an almost
> hassle-free installation.

Ha.  The Gentoo install is an experience from years ago.  Here's your
root prompt, happy fdisking.  On top of that all versions of packages
won't compile on sparc.  I've perservered and now have a happy system.

> By the way, they both have a Creator 3D card and I'd like to use that, too...

I'm running X on Ultra 10s that have that card, but I don't know if
it's using any of the acceleration.

> And, last but not least: Anything special about the compilers?

The kernel uses a different gcc than user space, one is 32 bit and the
other 64, I forget which way, but it all just works.  This may have
changed with kernel 2.6 or later versions of gentoo, I don't know yet.

							Brian
