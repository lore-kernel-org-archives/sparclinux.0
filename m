From: Ed L Cashin <ecashin@uga.edu>
Date: Fri, 23 Jan 2004 21:31:47 +0000
Subject: Re: why "mov %0, %0" after "rd %%tick, %0"?
Message-Id: <87r7xqgxmk.fsf@uga.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20040123125806.215b41da.davem@redhat.com>
In-Reply-To: <20040123125806.215b41da.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> On Fri, 23 Jan 2004 15:59:13 -0500
> Ed L Cashin <ecashin@uga.edu> wrote:
>
>> One thing I don't get is why there's a mov %0, %0 instruction after
>> reading the tick register.  Is this because of the delay slot?
>
> No, there is a bug in some of the UltraSPARC processors in that if
> you go:
>
> 	rd	%tick, %reg
> 	cmp	%reg, XXX
>
> the compare will get an incorrect result.  If we force the %tick result
> into a simple move instruction this prevents the sequence that leads up
> to the bug.

Oh!  Thanks.  Do you think it's worth a comment?

--- linux-2.6.1/arch/sparc64/kernel/time.c.orig	Fri Jan 23 16:21:38 2004
+++ linux-2.6.1/arch/sparc64/kernel/time.c	Fri Jan 23 16:24:44 2004
@@ -108,6 +108,14 @@
 {
 	unsigned long ret;
 
+	/* There is a bug in some of the UltraSPARC processors
+	 * where a compare following a read of the %tick 
+	 * register gets an incorrect result.
+	 *
+	 * If we force the %tick result into a simple move
+	 * instruction this prevents the sequence that leads up
+	 * to the bug.
+	 */
 	__asm__ __volatile__("rd	%%tick, %0\n\t"
 			     "mov	%0, %0"
 			     : "=r" (ret));


-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

