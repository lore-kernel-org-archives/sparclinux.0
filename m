From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 10 Jul 2017 18:47:54 +0000
Subject: Re: in:imklog segfault in 4.12+git on most sparc64's
Message-Id: <01fc1a18-fbc2-a6f7-b6c1-3795c6480771@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1707101111290.5280@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1707101111290.5280@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 07/10/2017 08:42 PM, David Miller wrote:
> My userland is from 2013 with random built-from-src pieces of updated
> tools and glibc, should I just throw my hands up in the air when the
> kernel OOPSes and not look into it at all?

Well, I know that around 2-3 years ago, lots of userland packages had
issues on sparc which were consequently fixed. Here's a selection [1].

Testing with a current userland just reduces the probability to stumble
into any of these issues.

Adrian

> [1] https://wiki.debian.org/PortsSparc

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
