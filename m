From: David Miller <davem@davemloft.net>
Date: Sat, 08 Jul 2006 00:28:38 +0000
Subject: Re: sparc64 fmulq emulation glitch?
Message-Id: <20060707.172838.58432246.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200606260902.12375.rene@exactcode.de>
In-Reply-To: <200606260902.12375.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rene Rebe <rene@exactcode.de>
Date: Mon, 26 Jun 2006 09:02:12 +0200

> I tried to get thru the kernel code but have not yet garsped
> all the macro magic ... Maybe someone has an idea?

It looks like the rounding logic is a bit overzealous here.
I'll look into it, thanks for the report.
