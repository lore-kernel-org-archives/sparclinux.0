From: David Miller <davem@davemloft.net>
Date: Mon, 06 Aug 2007 09:31:14 +0000
Subject: Re: Sparc-2.6.24 GIT tree
Message-Id: <20070806.023114.71089344.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070805.180930.21926239.davem@davemloft.net>
In-Reply-To: <20070805.180930.21926239.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andrew Walrond <andrew@walrond.org>
Date: Mon, 06 Aug 2007 09:38:22 +0100

> Or, if 2.6.22.1 should boot fine on a T1000, perhaps someone could mail
> me a known good .config that I could use as a base?

I use arch/sparc64/defconfig, enable CONFIG_FUSION* and CONFIG_SMP,
works fine on all my Niagara boxes.
