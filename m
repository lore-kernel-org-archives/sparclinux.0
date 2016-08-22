From: Petr Mladek <pmladek@suse.com>
Date: Mon, 22 Aug 2016 08:33:42 +0000
Subject: Re: [PATCH v8 1/4] nmi_backtrace: add more trigger_*_cpu_backtrace() methods
Message-Id: <20160822083342.GA4866@pathway.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1471377024-2244-1-git-send-email-cmetcalf@mellanox.com>
 <1471377024-2244-2-git-send-email-cmetcalf@mellanox.com>
 <20160818141242.GK26194@pathway.suse.cz>
 <233b9270-2f35-b3c5-2520-bf513153f260@mellanox.com>
In-Reply-To: <233b9270-2f35-b3c5-2520-bf513153f260@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri 2016-08-19 21:54:31, Chris Metcalf wrote:
> On 8/18/2016 10:12 AM, Petr Mladek wrote:
> >On Tue 2016-08-16 15:50:21, Chris Metcalf wrote:
> >>Currently you can only request a backtrace of either all cpus, or
> >>all cpus but yourself.  It can also be helpful to request a remote
> >>backtrace of a single cpu, and since we want that, the logical
> >>extension is to support a cpumask as the underlying primitive.
> >>
> >>This change modifies the existing lib/nmi_backtrace.c code to take
> >>a cpumask as its basic primitive, and modifies the linux/nmi.h code
> >>to use the new "cpumask" method instead.
> >>
> >>The mips code ignored the "include_self" boolean but with this change
> >>it will now also dump a local backtrace if requested.
> >>
> >>diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> >>index 7429ad09fbe3..fea1fa7726e3 100644
> >>--- a/arch/mips/kernel/process.c
> >>+++ b/arch/mips/kernel/process.c
> >>@@ -569,9 +569,16 @@ static void arch_dump_stack(void *info)
> >>  	dump_stack();
> >>  }
> >>-void arch_trigger_all_cpu_backtrace(bool include_self)
> >>+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
> >>  {
> >>-	smp_call_function(arch_dump_stack, NULL, 1);
> >>+	long this_cpu = get_cpu();
> >>+
> >>+	if (cpumask_test_cpu(this_cpu, mask) && !exclude_self)
> >>+		dump_stack();
> >The bit is not cleared in the mask. Therefore arch_dump_stack
> >will get called for this CPU as well.
> 
> Actually, and kind of confusingly, smp_call_function_many() never calls
> the current cpu, even if it is in the mask.  So this code is OK as-is.

I see it now.

> >Otherwise the patch patch looks good to me.
> 
> Great, thanks!  Should I add your Reviewed-by?

Yup. This patch looks fine then:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
