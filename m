From: Bob Breuer <breuerr@mc.net>
Date: Tue, 11 Jul 2006 05:46:45 +0000
Subject: Re: sparc32 BUG_ON sparc_cpu_model
Message-Id: <44B33B45.1080305@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.10.10607101933080.4657-200000@coalcreekmill.cm.com>
In-Reply-To: <Pine.LNX.4.10.10607101933080.4657-200000@coalcreekmill.cm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Raymond Burns wrote:
> Hi
> 
> This should probably be done with variable functions, but, For devo /
> debug the patch would work better then the single branch thats being
> used.
> 
> I found 3, I'm not sure if there are more.

You could just do an if/else between sun4m and sun4d.  For example:
http://lxr.linux.no/source/arch/sparc/kernel/smp.c#L95

There are also changes needed in sun4d_smp.c, and possibly sun4d_irq.c
may need changes to get synchronize_irq to work.

If you need any help putting the pieces together, let me know.

Bob
