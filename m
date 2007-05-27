From: David Miller <davem@davemloft.net>
Date: Sun, 27 May 2007 00:46:35 +0000
Subject: Re: [PATCH] arch/sparc64/time.c doesn't compile on Ultra 1 (no PCI)
Message-Id: <20070526.174635.38303689.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200705260113.l4Q1DYFc007820@laptop13.inf.utfsm.cl>
In-Reply-To: <200705260113.l4Q1DYFc007820@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Date: Fri, 25 May 2007 21:13:34 -0400

> This is bug 8540 on bugzilla.kernel.org, my patch (below) was OKed by
> Andrew Morton there.
> 
> arch/sparc64/time.c contains references to assorted bq4802 stuff if
> CONFIG_PCI is not set, and compile fails. I #ifdef'ed out everything that
> looks PCI-ish in that file.

Thanks for your patch, I'll apply it.
