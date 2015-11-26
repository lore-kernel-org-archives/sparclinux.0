From: "Shi, Yang" <yang.shi@linaro.org>
Date: Thu, 26 Nov 2015 00:31:21 +0000
Subject: Re: [PATCH] sparc64/gup: check address scope legitimacy
Message-Id: <565652D9.7040009@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <201511260819.RuE4G4tG%fengguang.wu@intel.com>
In-Reply-To: <201511260819.RuE4G4tG%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, davem@davemloft.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linaro-kernel@lists.linaro.org

On 11/25/2015 4:26 PM, kbuild test robot wrote:
> Hi Yang,
>
> [auto build test ERROR on v4.4-rc2]
> [also build test ERROR on next-20151124]
>
> url:    https://github.com/0day-ci/linux/commits/Yang-Shi/sparc64-gup-check-address-scope-legitimacy/20151126-065342
> config: sparc64-allnoconfig (attached as .config)
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=sparc64
>
> All errors (new ones prefixed by >>):
>
>     arch/sparc/mm/gup.c: In function 'get_user_pages_fast':
>>> arch/sparc/mm/gup.c:210:3: error: label 'slow_irqon' used but not defined
>        goto slow_irqon;

Already fixed in v2.

Thanks,
Yang

>        ^
>
> vim +/slow_irqon +210 arch/sparc/mm/gup.c
>
>     204	
>     205		start &= PAGE_MASK;
>     206		addr = start;
>     207		len = (unsigned long) nr_pages << PAGE_SHIFT;
>     208		end = start + len;
>     209		if (end < start)
>   > 210			goto slow_irqon;
>     211	
>     212		/*
>     213		 * XXX: batch / limit 'nr', to avoid large irq off latency
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>

