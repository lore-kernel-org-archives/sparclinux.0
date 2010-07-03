From: David Miller <davem@davemloft.net>
Date: Sat, 03 Jul 2010 04:40:24 +0000
Subject: Re: Checking for v9v/64v capability
Message-Id: <20100702.214024.38299126.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@medozas.de>
Date: Fri, 2 Jul 2010 21:29:28 +0200 (CEST)

> Are you saying libraries like openssl should rely on
> dlopen("openssl-core.so") to pick the right one
> out of /lib/<platform>? That may work, but only as long
> as it's in the search path, does it not?

First, openssl should be using STT_GNU_IFUNC rather than building
multiple libraries.

And the STT_GNU_IFUNC symbol resolution function should access
the auxv info via "dl_hwcap" and "dl_hwcap_mask".

