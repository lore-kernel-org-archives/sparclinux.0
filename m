From: Ed L Cashin <ecashin@uga.edu>
Date: Fri, 23 Jan 2004 20:59:13 +0000
Subject: why "mov %0, %0" after "rd %%tick, %0"?
Message-Id: <871xpqtm8u.fsf@uga.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20040123125806.215b41da.davem@redhat.com>
In-Reply-To: <20040123125806.215b41da.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.  In arch/sparc64/kernel/time.c, there are some routines that use
the %tick register.  It seems analogous to the Pentium's TSC.  I'm
planning to use that register in userland via inline asm.  (Thanks for
making sure that non-privileged access is allowed, BTW!)

One thing I don't get is why there's a mov %0, %0 instruction after
reading the tick register.  Is this because of the delay slot?

static unsigned long tick_get_tick(void)
{
	unsigned long ret;

	__asm__ __volatile__("rd	%%tick, %0\n\t"
			     "mov	%0, %0"
			     : "=r" (ret));

	return ret & ~TICK_PRIV_BIT;
}


-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

