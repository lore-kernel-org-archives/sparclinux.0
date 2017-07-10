From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 10 Jul 2017 18:35:21 +0000
Subject: Re: in:imklog segfault in 4.12+git on most sparc64's
Message-Id: <20170710183521.GC23190@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1707101111290.5280@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1707101111290.5280@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jul 10, 2017 at 07:32:27PM +0100, David Miller wrote:
> Yes, let's make sure that 32-bit userland support in the kernel gets
> even less testing, and gets even buggier over time.

My point was not 32-bit vs. 64-bit, my point was using an outdated
userland from 2015.  For 32-bit tests, I'd rather create a Gentoo
a 32-bit sparc chroot or rebootstrap Debian sparc.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
