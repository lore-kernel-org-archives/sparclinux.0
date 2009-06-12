From: Rusty Russell <rusty@rustcorp.com.au>
Date: Fri, 12 Jun 2009 11:22:10 +0000
Subject: Re: linux-next: rr-latest-cpumask/sparc tree build failure
Message-Id: <200906122040.10541.rusty@rustcorp.com.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20090612185102.2d1391e5.sfr@canb.auug.org.au>
In-Reply-To: <20090612185102.2d1391e5.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On Fri, 12 Jun 2009 06:21:02 pm Stephen Rothwell wrote:
> Hi Rusty,
>
> Today's linux-next build (sparc64 defconfig) failed like this:
>
> arch/sparc/mm/init_64.c: In function 'paging_init':
> arch/sparc/mm/init_64.c:1802: error: 'CPU_MASK_ALL_PTR' undeclared (first

OK, Dave could you take/fold Stephen's fix then?

FYI here's the patch explaining why we're CPU_MASK_ALL_PTR -> cpu_all_mask:

Subject: cpumask: remove dangerous CPU_MASK_ALL_PTR

(Thanks to Al Viro for reminding me of this, via Ingo)

CPU_MASK_ALL is the (deprecated) "all bits set" cpumask, defined as so:

	#define CPU_MASK_ALL (cpumask_t) { { ... } }

Taking the address of such a temporary is questionable at best,
unfortunately 321a8e9d (cpumask: add CPU_MASK_ALL_PTR macro) added
CPU_MASK_ALL_PTR:

	#define CPU_MASK_ALL_PTR (&CPU_MASK_ALL)

Which formalizes this practice.  One day gcc could bite us over this
usage (though we seem to have gotten away with it so far).

Now all callers are removed, we kill it.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Acked-by: Ingo Molnar <mingo@elte.hu>
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: Mike Travis <travis@sgi.com>
---
 include/linux/cpumask.h |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -324,8 +324,6 @@ static inline const struct cpumask *get_
 	[BITS_TO_LONGS(NR_CPUS)-1] = CPU_MASK_LAST_WORD			\
 } }
 
-#define CPU_MASK_ALL_PTR	(&CPU_MASK_ALL)
-
 #else
 
 #define CPU_MASK_ALL							\
@@ -333,7 +331,6 @@ static inline const struct cpumask *get_
 
 /* cpu_mask_all is in init/main.c */
 extern cpumask_t cpu_mask_all;
-#define CPU_MASK_ALL_PTR	(&cpu_mask_all)
 
 #endif
 

