From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 23 Nov 2005 04:46:16 +0000
Subject: Re: [PATCH]: IRQ stacks for sparc64
Message-Id: <20051122.204616.76335012.davem@davemloft.net>
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

I'm trying to reproduce this here locally and not having
any luck.  On my SB1000 I also have 2x750 cpus and I have
2GB of ram.  I'm using a creator3D framebuffer as the console
with a USB keyboard.

And it works perfectly fine with the IRQ stack patch applied to
2.6.15-rc2.

Also, I'm using gcc-4.0.2-20050808 (Ubuntu 4.0.1-4ubuntu9) as my
compiler.

Can you let me know your compiler, ".config" and what you're using as
the console?  It's the only place where I think there might be
differences between our two setups.

Thanks Jason.
