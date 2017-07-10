From: David Miller <davem@davemloft.net>
Date: Mon, 10 Jul 2017 18:42:53 +0000
Subject: Re: in:imklog segfault in 4.12+git on most sparc64's
Message-Id: <20170710.194253.746288382593489580.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1707101111290.5280@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1707101111290.5280@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 10 Jul 2017 20:35:21 +0200

> On Mon, Jul 10, 2017 at 07:32:27PM +0100, David Miller wrote:
>> Yes, let's make sure that 32-bit userland support in the kernel gets
>> even less testing, and gets even buggier over time.
> 
> My point was not 32-bit vs. 64-bit, my point was using an outdated
> userland from 2015.  For 32-bit tests, I'd rather create a Gentoo
> a 32-bit sparc chroot or rebootstrap Debian sparc.

My userland is from 2013 with random built-from-src pieces of updated
tools and glibc, should I just throw my hands up in the air when the
kernel OOPSes and not look into it at all?

None of this makes any sense at all.

If a bug shows up in the kernel between X and Y, it doesn't matter if
it triggers with an old userland or a new one.  It should be
investigated just the same.

