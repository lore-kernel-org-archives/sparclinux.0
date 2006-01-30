From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 30 Jan 2006 23:59:01 +0000
Subject: Re: afbinit failure with 2.6.15 kernels (can no longer load Elite
Message-Id: <20060130.155901.53171368.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1138649666.7197.17.camel@polylepis.inforead.com>
In-Reply-To: <1138649666.7197.17.camel@polylepis.inforead.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Ferris McCormick <fmccor@gentoo.org>
Date: Mon, 30 Jan 2006 19:34:26 +0000

> 
> With kernel-2.6.15 series, the program for loading Elite graphics
> microcode fails:
> 
> Is this a known problem, or is the fix for afbinit known?

It's a known problem, something is buggered up in afbinit
because the change made to the kernel that creates this
problem is totally correct.

I'll try to look into it soon, I have AFB hardware here on
which I can reproduce.
