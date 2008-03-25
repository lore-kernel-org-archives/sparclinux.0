From: David Miller <davem@davemloft.net>
Date: Tue, 25 Mar 2008 09:42:43 +0000
Subject: Re: build breakage on sparc64 due to commit 54cd6dde
Message-Id: <20080325.024243.226580899.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200803242053.22709.m.kozlowski@tuxland.pl>
In-Reply-To: <200803242053.22709.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Tue, 25 Mar 2008 09:53:11 +0100

> > You can build kernels by setting CROSS_COMPILE=sparc64-linux-
> > for the build.
> 
> Your recipe works but actually requires
> CROSS_COMPILE=sparc64-unknown-linux-gnu- for the build.

Right, it depends upon however the dist happened to name
the cross tools.
