From: Mike Rapoport <rppt@kernel.org>
Date: Thu, 04 Jun 2020 09:41:33 +0000
Subject: Re: [PATCH] arch/{mips,sparc,microblaze,powerpc}: Don't enable pagefault/preempt twice
Message-Id: <20200604094133.GC202650@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200518184843.3029640-1-ira.weiny@intel.com>
 <20200519165422.GA5838@roeck-us.net>
 <20200519184031.GB3356843@iweiny-DESK2.sc.intel.com>
 <20200519194215.GA71941@roeck-us.net>
 <20200520051315.GA3660833@iweiny-DESK2.sc.intel.com>
 <d86dba19-4f4b-061e-a2c7-4f037e9e2de2@roeck-us.net>
 <20200521174250.GB176262@iweiny-DESK2.sc.intel.com>
 <20200603135736.e7b5ded0082a81ae6d9067a0@linux-foundation.org>
 <20200603211416.GA1740285@iweiny-DESK2.sc.intel.com>
 <3538c8ad-674e-d310-d870-4ef6888092ed@roeck-us.net>
In-Reply-To: <3538c8ad-674e-d310-d870-4ef6888092ed@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Wed, Jun 03, 2020 at 04:44:17PM -0700, Guenter Roeck wrote:
> 
> sparc32 smp images in next-20200603 still crash for me with a spinlock
> recursion. s390 images hang early in boot. Several others (alpha, arm64,
> various ppc) don't even compile. I can run some more bisects over time,
> but this is becoming a full-time job :-(.

I've been able to bisect s390 hang to commit b614345f52bc ("x86/entry:
Clarify irq_{enter,exit}_rcu()").

After this commit, lockdep_hardirq_exit() is called twice on s390 (and
others) - one time in irq_exit_rcu() and another one in irq_exit():

/**
 * irq_exit_rcu() - Exit an interrupt context without updating RCU
 *
 * Also processes softirqs if needed and possible.
 */
void irq_exit_rcu(void)
{
	__irq_exit_rcu();
	 /* must be last! */
	lockdep_hardirq_exit();
}

/**
 * irq_exit - Exit an interrupt context, update RCU and lockdep
 *
 * Also processes softirqs if needed and possible.
 */
void irq_exit(void)
{
	irq_exit_rcu();
	rcu_irq_exit();
	 /* must be last! */
	lockdep_hardirq_exit();
}

Removing the call in irq_exit() make s390 boot again, and judgung by the
x86 entry code, the comment /* must be last! */ is stale...

@Peter, @Thomas, can you comment please?

From e51d50ee6f4d1f446decf91c2c67230da14ff82c Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Thu, 4 Jun 2020 12:37:03 +0300
Subject: [PATCH] softirq: don't call lockdep_hardirq_exit() twice

After commit b614345f52bc ("x86/entry: Clarify irq_{enter,exit}_rcu()")
lockdep_hardirq_exit() is called twice on every architecture that uses
irq_exit(): one time in irq_exit_rcu() and another one in irq_exit().

Remove the extra call in irq_exit().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 kernel/softirq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index a3eb6eba8c41..7523f4ce4c1d 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -427,7 +427,6 @@ static inline void __irq_exit_rcu(void)
 void irq_exit_rcu(void)
 {
 	__irq_exit_rcu();
-	 /* must be last! */
 	lockdep_hardirq_exit();
 }
 
@@ -440,8 +439,6 @@ void irq_exit(void)
 {
 	irq_exit_rcu();
 	rcu_irq_exit();
-	 /* must be last! */
-	lockdep_hardirq_exit();
 }
 
 /*
-- 
2.26.2



> Guenter

-- 
Sincerely yours,
Mike.
