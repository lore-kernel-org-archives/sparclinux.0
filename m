From: David Miller <davem@davemloft.net>
Date: Mon, 18 Nov 2013 22:53:49 +0000
Subject: Re: [PATCH 0/2] SILO: support cross-compilation
Message-Id: <20131118.175349.1462879454463843630.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 22 Sep 2013 22:33:02 +0300

> Here's two simple patches to enable cross-compilation of SILO. The main
> issue is that little-endian host produces a broken binary (only "SIL"
> gets displayed and the boot hangs).

Sorry for taking so long.

These changes look great, applied, thanks!
