From: "David S. Miller" <davem@redhat.com>
Date: Mon, 09 Aug 2004 23:20:57 +0000
Subject: Re: /dev/random lacks entropy on sparc64
Message-Id: <20040809162057.7a7d2ddb.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1092092360.7938.50.camel@duncow>
In-Reply-To: <1092092360.7938.50.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 09 Aug 2004 23:59:20 +0100
Richard Mortimer <richm@oldelvet.org.uk> wrote:

> I suspect that the patch needs some more work (probably shouldn't use
> assembly directly in drivers/char/random.c). I'm not sure whether we
> should really be calling something like tick_ops->get_tick().

I think we should.  Also, you forgot to shift down the
high bits before xor'ing it into 'num'.

I would use this patch.

=== drivers/char/random.c 1.19 vs edited ==--- 1.19/drivers/char/random.c	2003-12-12 07:18:03 -08:00
+++ edited/drivers/char/random.c	2004-08-09 16:04:44 -07:00
@@ -750,6 +750,11 @@
 	__u32 high;
 	rdtsc(time, high);
 	num ^= high;
+#elif defined (__sparc_v9__)
+	unsigned long tick = tick_ops->get_tick();
+
+	time = (unsigned int) tick;
+	num ^= (tick >> 32UL);
 #else
 	time = jiffies;
 #endif
