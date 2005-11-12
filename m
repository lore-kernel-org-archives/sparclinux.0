From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 12 Nov 2005 19:45:28 +0000
Subject: Re: [PATCH]: IRQ stacks for sparc64
Message-Id: <20051112.114528.50021926.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051110.210234.59468958.davem@davemloft.net>
In-Reply-To: <20051110.210234.59468958.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jason Wever <weeve@gentoo.org>
Date: Fri, 11 Nov 2005 21:03:27 -0700

> I've tried this patch against 2.6.14-git14 on a 2x750 Blade 1000.  When
> I let the blade boot normally, it for some reason fails to mount the
> root filesystem and dies with the following error;
> 
> kernel BUG at kernel/fork.c:731
> 
> If I try booting the same kernel with the -p argument, this doesn't
> happen and the system boots as expected.  Will let the system run like
> this and see how it goes.

And without the IRQ stack patch applied the "kernel BUG at kernel/fork.c:731"
problem does not occur?

Thanks.
