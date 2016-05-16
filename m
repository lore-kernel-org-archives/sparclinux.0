From: David Miller <davem@davemloft.net>
Date: Mon, 16 May 2016 15:08:53 +0000
Subject: Re: Definition of __sparc64__ in gcc
Message-Id: <20160516.110853.971752247866247011.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5739BBAC.2030804@physik.fu-berlin.de>
In-Reply-To: <5739BBAC.2030804@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 16 May 2016 14:23:08 +0200

> Hello!
> 
> While looking at the FTBFS of Firefox, I noticed that Firefox, more
> precisely ipc/chromium was checking for the definition of __sparc64__
> to configure the code for sparc64 [1].
> 
> However, when looking at the actual gcc configuration dump, it's
> apparent that __sparc64__ is actually not used but __arch64__:
> 
> root@landau:~# echo | gcc -E -dM - |grep __arch64__
> #define __arch64__ 1
> root@landau:~# echo | gcc -E -dM - |grep __sparc64__
> root@landau:~#
> 
> Changing the header in Firefox's code base actually fixed this
> particular issue with the firefox package on Debian.
> 
> Thus, my suspicion is that there might be other packages which are
> incorrectly configured on sparc64 and consequently either failing
> to build from source, crashing their testsuite or crashing during
> operation.
> 
> A list of the possibly affected packages can be found in [2].
> 
> Any comments?

The correct test has always been "__sparc__ && __arch64__"
