From: David Miller <davem@davemloft.net>
Date: Wed, 18 Mar 2015 20:14:03 +0000
Subject: Re: maps mismatch in /proc/kcore for sparc
Message-Id: <20150318.161403.1392052398222912621.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5509AE36.8040902@oracle.com>
	<20150318.154359.1325469409095627387.davem@davemloft.net>
	<5509D8C7.5080504@oracle.com>
In-Reply-To: <5509D8C7.5080504@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: david.ahern@oracle.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Wed, 18 Mar 2015 13:57:59 -0600

> On 3/18/15 1:43 PM, David Miller wrote:
>> From: David Ahern <david.ahern@oracle.com>
>> Date: Wed, 18 Mar 2015 10:56:22 -0600
>>
>>> I am trying to understand why the perf tool on sparc fails to convert
>>> kernel symbols when /proc/kcore is used. I have instrumented perf to
>>> the point I can see that it drops symbols from kallsyms because it
>>> cannot find a corresponding map when the kernel maps are created based
>>> on parsing /proc/kcore.
>>
>> I'm looking into this, I think we need to set ARCH_PROC_KCORE_TEXT in
>> arch/sparc/Kconfig
> 
> Missed that config in my fumbling through the kcore code. Adding it to
> sparc/Kconfig and it works. map is added:
> 
> kcore_mapfn: dso [kernel.kallsyms]: new map from 404000 to e33d79
> 
> and kernel symbols are not dropped. One mystery solved.

I'm really wondering how you have a non-zero-length /proc/kcore file, do
you have any local changes in your tree?

I ask because no memory regions should be added until we add the
"System RAM" entries to /proc/iomem, and this is done by report_memory()
in arch/sparc/mm/init_64.c which is a device_initcall().

The kcore core that looks for that stuff is an fs_initcall() which runs
earlier, and thus won't see any entries at all.

You have something different in your tree if kcore is actually finding
memory to add to the kcore memory lists.

Oh I see, you're using older sources which don't have:

	commit abaf3787ac26ba33e2f75e76b1174c32254c25b0
	Author: Paul Gortmaker <paul.gortmaker@windriver.com>
	Date:   Thu Jan 23 15:55:45 2014 -0800

	    fs/proc: don't use module_init for non-modular core code

And that explains everything, I'll submit the following:

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 96ac69c..efb00ec 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -86,6 +86,9 @@ config ARCH_DEFCONFIG
 	default "arch/sparc/configs/sparc32_defconfig" if SPARC32
 	default "arch/sparc/configs/sparc64_defconfig" if SPARC64
 
+config ARCH_PROC_KCORE_TEXT
+	def_bool y
+
 config IOMMU_HELPER
 	bool
 	default y if SPARC64
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 3ea267c..4ca0d6b 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2820,7 +2820,7 @@ static int __init report_memory(void)
 
 	return 0;
 }
-device_initcall(report_memory);
+arch_initcall(report_memory);
 
 #ifdef CONFIG_SMP
 #define do_flush_tlb_kernel_range	smp_flush_tlb_kernel_range
