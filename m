From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 18 Apr 2018 21:51:21 +0000
Subject: Re: BUG: Bad rss-counter state ...
Message-Id: <90f7186f-0481-483f-d025-e6a618f671ae@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
In-Reply-To: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 04/18/2018 11:34 PM, Meelis Roos wrote:
> Turn off Transparent Hugepages in kernel configuration - they are known 
> to cause this. I turned it off on all my sparc64 machines and crashes 
> like that are gone.

It's enabled by default in the Debian kernel:

root@landau:~# grep CONFIG_TRANSPARENT_HUGEPAGE /boot/config-$(uname -r)
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
root@landau:~#

We haven't received any reports regarding this issue and I also haven't
seen it on any of the machines the project is running (UltraSPARC IIIi,
SPARC T5, Sun Fire 2000).

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
