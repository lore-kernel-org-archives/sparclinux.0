From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sun, 13 Jan 2008 14:51:20 +0000
Subject: Re: gettimeofday not monotonous on sun4m
Message-Id: <20080113145120.GA12758@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20080106224013.GA22464@palantir8>
In-Reply-To: <20080106224013.GA22464@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jan 09, 2008 at 05:08:36AM -0800, David Miller wrote:
> From: Martin Habets <errandir_news@mph.eclipse.co.uk>
> Date: Sun, 6 Jan 2008 22:40:13 +0000
> 
> > The microseconds are determined by:
> >     (xtime.tv_nsec / 1000) + (l10_counter >> 10)
> > I dumped both variables with a simple kernel module (first 2 attachments),
> > which shows that xtime is monotonous, but l10_counter looks random to me.
> > 
> > I do not know the problem here, and cannot find details on the operation
> > of this counter property on sun4m. Maybe this l10_counter needs to be
> > callibrated?
> > I understand from include/asm-sparc/timer.h that l10_counter should count
> > down on sun4m, which makes the current code all the more puzzling.
> 
> Actually, the l10_counter counts up in microseconds.  When the
> l10_counter equals l10_limit an interrupt is generated.

Glad it counts up not down. The code makes a lot more sense that way!
It looks to count in nanoseconds, given the number of overlows I'm
seeing.

> Those values that look "random" to you have bit 31 set for some
> reason.

Thanks, I didn't notice that.

> Clear that bit and the values look much more sane.
> 
> I couldn't find my old STP1040 et al manuals so I took a look
> at the OpenBSD sparc code.  It masks the shifted value with
> 0x1fffff and has a note in one of it's header files mentioning
> that bit 0x80000000 in the counter register means the counter
> has hit the limit and the interrupt hasn't been cleared yet
> (which is done by reading the limit register).
> 
> We are masking like that so this aspect is fine.
> 
> But it is that case with the 0x80000000 bit being set that
> is causing the problems.
> 
> It means an interrupt is pending and the counter wraps back
> down to the beginning and starts to count from zero again.
> When the interrupt is serviced, xtime would get advanced
> forward.
> 
> We need to integrate that pending interrupt event into
> the calculations.
> 
> Please try this patch:

It almost works. Reaching the l10 limit does not indicate a
second overflow, but rather 10 milliseconds.
With the patch below I cannot make it fail on UP systems.
Output on UP looks like:

# insmod mod.ko 
l10_limit = 10241024    10001
tick_nsec = 10001268
l10_counter     shr(10) limit?  xtime                   gettimeofday
10203648        9964            1199930413.956184       1199930413.966145
10218496        9979            1199930413.956184       1199930413.966161
10231808        9992            1199930413.956184       1199930413.966174
2147487744      4        yes    1199930413.956184       1199930413.966187
2147501056      17       yes    1199930413.956184       1199930413.966200
   48640        47              1199930413.966185       1199930413.966231
   61952        60              1199930413.966185       1199930413.966244
   75264        73              1199930413.966185       1199930413.966257
   88576        86              1199930413.966185       1199930413.966270

I can still make it fail on SMP, gettimeofday is always off by 10 milliseconds.
do_gettimeofday() uses read_seqbegin_irqsave(). This blocks the l10 interrupt
from being taken on the local CPU, but I think it will just get taken on
the other CPU. In essence xtime and l10_counter are not guaranteed to be
consistent on all CPUs.

I could reduce the number of failures by dropping the _irqsave/restore.
With that the interrupt can be taken on the local CPU, and do_gettimeofday()
just goes through the while loop one more time.
But what is the best way to realy solve this?

Thanks,
Martin

Index: 2.6/arch/sparc/kernel/time.c
=================================--- 2.6.orig/arch/sparc/kernel/time.c	2008-01-09 21:21:05.000000000 +0000
+++ 2.6/arch/sparc/kernel/time.c	2008-01-10 00:55:28.000000000 +0000
@@ -437,7 +437,14 @@
 
 static inline unsigned long do_gettimeoffset(void)
 {
-	return (*master_l10_counter >> 10) & 0x1fffff;
+	unsigned long val = *master_l10_counter;
+	unsigned long usec = (val >> 10) & 0x1fffff;
+
+	/* Limit hit?  */
+	if (val & 0x80000000)
+		usec += TICK_SIZE;
+
+	return usec;
 }
 
 /* Ok, my cute asm atomicity trick doesn't work anymore.
