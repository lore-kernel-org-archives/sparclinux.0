From: David Miller <davem@davemloft.net>
Date: Thu, 29 Sep 2016 00:44:51 +0000
Subject: Re: [sparc:master 3/4] arch/sparc/kernel/setup_64.c:653:2: error: implicit declaration of function '
Message-Id: <20160928.204451.954612877106240508.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201609290139.lu4LV1CF%fengguang.wu@intel.com>
In-Reply-To: <201609290139.lu4LV1CF%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 29 Sep 2016 01:18:43 +0800

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master
> head:   ebb99a4c12e4daabe1940ae936e8e7e97ae68c6f
> commit: 9b2f753ec23710aa32c0d837d2499db92fe9115b [3/4] sparc64: Fix cpu_possible_mask if nr_cpus is set
> config: sparc64-allnoconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 9b2f753ec23710aa32c0d837d2499db92fe9115b
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc64 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/sparc/kernel/setup_64.c: In function 'setup_arch':
>>> arch/sparc/kernel/setup_64.c:653:2: error: implicit declaration of function 'smp_fill_in_cpu_possible_map' [-Werror=implicit-function-declaration]
>      smp_fill_in_cpu_possible_map();
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors

Thanks for the report, fixed thusly:

==========
[PATCH] sparc64: Fix non-SMP build.

Need to provide a dummy smp_fill_in_cpu_possible_map.

Fixes: 9b2f753ec237 ("sparc64: Fix cpu_possible_mask if nr_cpus is set")
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/smp_64.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/include/asm/smp_64.h b/arch/sparc/include/asm/smp_64.h
index 87b0575..ce2233f 100644
--- a/arch/sparc/include/asm/smp_64.h
+++ b/arch/sparc/include/asm/smp_64.h
@@ -73,6 +73,7 @@ void __cpu_die(unsigned int cpu);
 #define smp_fill_in_sib_core_maps() do { } while (0)
 #define smp_fetch_global_regs() do { } while (0)
 #define smp_fetch_global_pmu() do { } while (0)
+#define smp_fill_in_cpu_possible_map() do { } while (0)
 
 #endif /* !(CONFIG_SMP) */
 
-- 
2.5.5

