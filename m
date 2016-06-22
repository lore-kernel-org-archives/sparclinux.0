From: chase rayfield <cusbrar1@gmail.com>
Date: Wed, 22 Jun 2016 20:54:51 +0000
Subject: Re: Please upgrade your machines to sparc64
Message-Id: <CACwypyPsSiEasjcx9WdnYZT6_pWe7dmDsMLZO+tjdydn3nTaFg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
In-Reply-To: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Actually it's quite different from the x32 ABI.... 32bit Sparc code
has always been fastest by a large margin and has been what everyone
used unlike x32 which is only marginally faster as well as unstable.
On the other hand 64bit on Sparc code has only been used in the small
corner cases were 64bit was indeed faster or large memory access was
needed. I can imagine situations on big iron where a database may be
64bit due to large memory use but any client software also running
would be 32bit...

Also, who seriously runs Firefox on a T4 server or a LEON4 system or
vintage sun4 gear like I have? Though I would applaud someone for
trying it isn't a good point on which to make a decision regarding
userland maintenance. It just isn't a class of software that runs in
any practical sense on Sparc hardware that is in existence. It is far
too bloated for one... Firefox is a worst offender in this area and
depreciated everything else just because it can't build Firefox which
isn't even supported on Sparc anyway... is nonsense. Even on my T2000
it doesn't make a lot of sense to run Firefox even though it is fast
enough Firefox isn't threaded enough for it to use the hardware
efficiently.

sparc64 kernel + 32bit userland will probably never go away it's what
most people should be running. So, you'll just end up loosing userbase
further and inevitably dropping the Debian Sparc port.

Davem, has anything become of getting recent kernels running on sun4m
hardware? I was thinking it might be possible to reduce kernel size
with LTO as yet another temporary workaround until it becomes
relocatable as I think you mentioned would be the real fix.

Chase
