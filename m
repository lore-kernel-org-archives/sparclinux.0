From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 01 Aug 2017 21:38:53 +0000
Subject: Re: [mmotm:master 50/189] include/linux/swapops.h:220:9: error: implicit declaration of function '__
Message-Id: <20170801143853.f210976a43d009dba1eeb0db@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <201708011949.LtRajyO5%fengguang.wu@intel.com>
In-Reply-To: <201708011949.LtRajyO5%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>, kbuild-all@01.org, Johannes Weiner <hannes@cmpxchg.org>, Linux Memory Management List <linux-mm@kvack.org>, sparclinux@vger.kernel.org

On Tue, 1 Aug 2017 19:57:54 +0800 kbuild test robot <fengguang.wu@intel.com> wrote:

> tree:   git://git.cmpxchg.org/linux-mmotm.git master
> head:   7961d18ba492e06ad240d37a5502c418b5f0a928
> commit: 25faf0ef110322719330fcadf4fe541528bacd4d [50/189] mm-thp-enable-thp-migration-in-generic-path-fix
> config: sparc-defconfig (attached as .config)
> compiler: sparc-linux-gcc (GCC) 6.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 25faf0ef110322719330fcadf4fe541528bacd4d
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from fs/proc/task_mmu.c:15:0:
>    include/linux/swapops.h: In function 'swp_entry_to_pmd':
> >> include/linux/swapops.h:220:9: error: implicit declaration of function '__pmd' [-Werror=implicit-function-declaration]
>      return __pmd(0);
>             ^~~~~
> >> include/linux/swapops.h:220:9: error: incompatible types when returning type 'int' but 'pmd_t {aka struct <anonymous>}' was expected
>      return __pmd(0);
>             ^~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +/__pmd +220 include/linux/swapops.h
> 
>    217	
>    218	static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
>    219	{
>  > 220		return __pmd(0);
>    221	}
>    222	
> 

Seems that sparc32 forgot to implement __pmd()?
