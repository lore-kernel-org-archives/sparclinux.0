From: David Miller <davem@davemloft.net>
Date: Wed, 09 Jan 2008 13:08:36 +0000
Subject: Re: gettimeofday not monotonous on sun4m
Message-Id: <20080109.050836.02816039.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080106224013.GA22464@palantir8>
In-Reply-To: <20080106224013.GA22464@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sun, 6 Jan 2008 22:40:13 +0000

> The microseconds are determined by:
>     (xtime.tv_nsec / 1000) + (l10_counter >> 10)
> I dumped both variables with a simple kernel module (first 2 attachments),
> which shows that xtime is monotonous, but l10_counter looks random to me.
> 
> I do not know the problem here, and cannot find details on the operation
> of this counter property on sun4m. Maybe this l10_counter needs to be
> callibrated?
> I understand from include/asm-sparc/timer.h that l10_counter should count
> down on sun4m, which makes the current code all the more puzzling.

Actually, the l10_counter counts up in microseconds.  When the
l10_counter equals l10_limit an interrupt is generated.

Those values that look "random" to you have bit 31 set for some
reason.

Clear that bit and the values look much more sane.

I couldn't find my old STP1040 et al manuals so I took a look
at the OpenBSD sparc code.  It masks the shifted value with
0x1fffff and has a note in one of it's header files mentioning
that bit 0x80000000 in the counter register means the counter
has hit the limit and the interrupt hasn't been cleared yet
(which is done by reading the limit register).

We are masking like that so this aspect is fine.

But it is that case with the 0x80000000 bit being set that
is causing the problems.

It means an interrupt is pending and the counter wraps back
down to the beginning and starts to count from zero again.
When the interrupt is serviced, xtime would get advanced
forward.

We need to integrate that pending interrupt event into
the calculations.

Please try this patch:

diff --git a/arch/sparc/kernel/time.c b/arch/sparc/kernel/time.c
index 45cb7c5..ccd2ed5 100644
--- a/arch/sparc/kernel/time.c
+++ b/arch/sparc/kernel/time.c
@@ -436,7 +436,14 @@ void __init time_init(void)
 
 static inline unsigned long do_gettimeoffset(void)
 {
-	return (*master_l10_counter >> 10) & 0x1fffff;
+	unsigned long val = *master_l10_counter;
+	unsigned long usec = (val >> 10) & 0x1fffff;
+
+	/* Limit hit?  */
+	if (val & 0x80000000)
+		usec += 1000000;
+
+	return usec;
 }
 
 /* Ok, my cute asm atomicity trick doesn't work anymore.
