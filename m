From: David Miller <davem@davemloft.net>
Date: Fri, 19 Jun 2015 10:50:04 +0000
Subject: Re: Linux Sparc FPU register corruption
Message-Id: <20150619.040137.1840459916094858430.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
In-Reply-To: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Mattli <dmm@mattli.us>
Date: Thu, 18 Jun 2015 11:51:23 -0500

> 
> I've submitted a bug to Debian against src:linux requesting that they
> enable SLUB on the sparc kernel because in my testing a SLUB kernel
> never shows an error with Knight's test program and a SLAB kernel shows
> it within seconds.
> 
> Enabling SLUB also fixes the nettle FTBFS.
> 
> I'd appreciate if you can help by making this change to the linux
> package, adding information to the bug or by confirming whether the
> proposed workaround works for you.

There is no reason why SLUB vs. SLAB can be the real cause of
this problem.

It is definitely the FPU register handling.

I've already root caused the bug.  Specifically if I change the
memcpy in the kernel to one that doesn't use the FPU, the test
case passes just fine.

I'm working on a fix but this and next week I am travelling.
--
To unsubscribe from this list: send the line "unsubscribe sparclinux" in
