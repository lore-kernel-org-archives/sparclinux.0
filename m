From: David Miller <davem@davemloft.net>
Date: Fri, 18 May 2007 06:43:52 +0000
Subject: Re: How to load 2.6.22 kernel (image too large to fit ...)
Message-Id: <20070517.234352.01913140.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <464d3ea78cfe8@wp.pl>
In-Reply-To: <464d3ea78cfe8@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Fri, 18 May 2007 07:50:31 +0200

> I have tried to load the latest 2.6.22-rc1 and failed miserably.
> I got 2.6MB kernel after modularization and famous "strip -R.
> note -R .commend" trick. Nevertheless, it is still too big.
> 
> I upgrades SILO to 1.4.13 and still no luck.
> 
> Any hints? Are there any silo patches to allow bigger kernels.

Sparc64 can handle up to ~10.5MB kernels, so I guess you are
on sparc32?
