Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A1BC2BB3F
	for <sparclinux@archiver.kernel.org>; Sat, 18 Nov 2023 19:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjKRT1I (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 18 Nov 2023 14:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjKRT1I (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 18 Nov 2023 14:27:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D607182;
        Sat, 18 Nov 2023 11:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700335624; x=1731871624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7oM0Oe15GY24uVXAs/p2DnzhDDjC2fzvA/A3qyVQxc4=;
  b=nhXlTlRsRYCFhwRG7XT//XdNTNhByJiaZIAZfBzj8AuLXEXrI5U1woLJ
   aRajIZdfAgtvgjfOFEfGU65DLSMkFvVGGh8daGyB9xRI0T3/3gqI4SLIh
   vP4eBkrZ2UO8ILboq/dLXgPMHa7cLD0e+b4ubdK+sdS0+PAth6pRMLUla
   Ii1Ho55lyJCNQcsedi0MmA/Br+OhFcypC0Vkkv9zNYj11hcagKZ37NMAc
   JTmR7lvLtg6rPYdcTqTFX7WNMXfNJPbmMxhenHaqteADiw8DZjUoeTflB
   1Jgr4kmf7uz7RerXNgODuoF1cut2MShHHVolGNwExB5MSxV5rbTu1ueBk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="4554067"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="4554067"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 11:27:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="13795239"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 18 Nov 2023 11:26:59 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4Qxz-0004Cf-3C;
        Sat, 18 Nov 2023 19:26:55 +0000
Date:   Sun, 19 Nov 2023 03:26:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-hexagon@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-m68k@lists.linux-m68k.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-arm-kernel@lists.infradead.org,
        Brian Cain <bcain@quicinc.com>, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] asm/io: remove unnecessary xlate_dev_mem_ptr() and
 unxlate_dev_mem_ptr()
Message-ID: <202311190352.yqCpBjIn-lkp@intel.com>
References: <20231118100827.1599422-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118100827.1599422-1-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi Kefeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on geert-m68k/for-next geert-m68k/for-linus deller-parisc/for-next powerpc/next powerpc/fixes linus/master v6.7-rc1 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/asm-io-remove-unnecessary-xlate_dev_mem_ptr-and-unxlate_dev_mem_ptr/20231118-183038
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20231118100827.1599422-1-wangkefeng.wang%40huawei.com
patch subject: [PATCH] asm/io: remove unnecessary xlate_dev_mem_ptr() and unxlate_dev_mem_ptr()
config: mips-db1xxx_defconfig (https://download.01.org/0day-ci/archive/20231119/202311190352.yqCpBjIn-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231119/202311190352.yqCpBjIn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311190352.yqCpBjIn-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/char/mem.c: In function 'read_mem':
>> drivers/char/mem.c:159:31: error: implicit declaration of function 'xlate_dev_mem_ptr' [-Werror=implicit-function-declaration]
     159 |                         ptr = xlate_dev_mem_ptr(p);
         |                               ^~~~~~~~~~~~~~~~~
>> drivers/char/mem.c:159:29: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     159 |                         ptr = xlate_dev_mem_ptr(p);
         |                             ^
>> drivers/char/mem.c:164:25: error: implicit declaration of function 'unxlate_dev_mem_ptr' [-Werror=implicit-function-declaration]
     164 |                         unxlate_dev_mem_ptr(p, ptr);
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/char/mem.c: In function 'write_mem':
   drivers/char/mem.c:235:29: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     235 |                         ptr = xlate_dev_mem_ptr(p);
         |                             ^
   cc1: some warnings being treated as errors


vim +/xlate_dev_mem_ptr +159 drivers/char/mem.c

^1da177e4c3f41 Linus Torvalds                2005-04-16  133  
22ec1a2aea73b9 Kees Cook                     2017-12-01  134  	bounce = kmalloc(PAGE_SIZE, GFP_KERNEL);
22ec1a2aea73b9 Kees Cook                     2017-12-01  135  	if (!bounce)
22ec1a2aea73b9 Kees Cook                     2017-12-01  136  		return -ENOMEM;
22ec1a2aea73b9 Kees Cook                     2017-12-01  137  
^1da177e4c3f41 Linus Torvalds                2005-04-16  138  	while (count > 0) {
fa29e97bb8c70f Wu Fengguang                  2009-12-14  139  		unsigned long remaining;
b5b38200ebe548 Kees Cook                     2018-03-27  140  		int allowed, probe;
fa29e97bb8c70f Wu Fengguang                  2009-12-14  141  
f222318e9c3a31 Wu Fengguang                  2009-12-14  142  		sz = size_inside_page(p, count);
^1da177e4c3f41 Linus Torvalds                2005-04-16  143  
22ec1a2aea73b9 Kees Cook                     2017-12-01  144  		err = -EPERM;
a4866aa812518e Kees Cook                     2017-04-05  145  		allowed = page_is_allowed(p >> PAGE_SHIFT);
a4866aa812518e Kees Cook                     2017-04-05  146  		if (!allowed)
22ec1a2aea73b9 Kees Cook                     2017-12-01  147  			goto failed;
22ec1a2aea73b9 Kees Cook                     2017-12-01  148  
22ec1a2aea73b9 Kees Cook                     2017-12-01  149  		err = -EFAULT;
a4866aa812518e Kees Cook                     2017-04-05  150  		if (allowed == 2) {
a4866aa812518e Kees Cook                     2017-04-05  151  			/* Show zeros for restricted memory. */
a4866aa812518e Kees Cook                     2017-04-05  152  			remaining = clear_user(buf, sz);
a4866aa812518e Kees Cook                     2017-04-05  153  		} else {
^1da177e4c3f41 Linus Torvalds                2005-04-16  154  			/*
a4866aa812518e Kees Cook                     2017-04-05  155  			 * On ia64 if a page has been mapped somewhere as
a4866aa812518e Kees Cook                     2017-04-05  156  			 * uncached, then it must also be accessed uncached
a4866aa812518e Kees Cook                     2017-04-05  157  			 * by the kernel or data corruption may occur.
^1da177e4c3f41 Linus Torvalds                2005-04-16  158  			 */
^1da177e4c3f41 Linus Torvalds                2005-04-16 @159  			ptr = xlate_dev_mem_ptr(p);
e045fb2a988a9a venkatesh.pallipadi@intel.com 2008-03-18  160  			if (!ptr)
22ec1a2aea73b9 Kees Cook                     2017-12-01  161  				goto failed;
a4866aa812518e Kees Cook                     2017-04-05  162  
fe557319aa06c2 Christoph Hellwig             2020-06-17  163  			probe = copy_from_kernel_nofault(bounce, ptr, sz);
e045fb2a988a9a venkatesh.pallipadi@intel.com 2008-03-18 @164  			unxlate_dev_mem_ptr(p, ptr);
b5b38200ebe548 Kees Cook                     2018-03-27  165  			if (probe)
22ec1a2aea73b9 Kees Cook                     2017-12-01  166  				goto failed;
22ec1a2aea73b9 Kees Cook                     2017-12-01  167  
22ec1a2aea73b9 Kees Cook                     2017-12-01  168  			remaining = copy_to_user(buf, bounce, sz);
a4866aa812518e Kees Cook                     2017-04-05  169  		}
a4866aa812518e Kees Cook                     2017-04-05  170  
fa29e97bb8c70f Wu Fengguang                  2009-12-14  171  		if (remaining)
22ec1a2aea73b9 Kees Cook                     2017-12-01  172  			goto failed;
e045fb2a988a9a venkatesh.pallipadi@intel.com 2008-03-18  173  
^1da177e4c3f41 Linus Torvalds                2005-04-16  174  		buf += sz;
^1da177e4c3f41 Linus Torvalds                2005-04-16  175  		p += sz;
^1da177e4c3f41 Linus Torvalds                2005-04-16  176  		count -= sz;
^1da177e4c3f41 Linus Torvalds                2005-04-16  177  		read += sz;
8619e5bdeee8b2 Tetsuo Handa                  2019-08-26  178  		if (should_stop_iteration())
8619e5bdeee8b2 Tetsuo Handa                  2019-08-26  179  			break;
^1da177e4c3f41 Linus Torvalds                2005-04-16  180  	}
22ec1a2aea73b9 Kees Cook                     2017-12-01  181  	kfree(bounce);
^1da177e4c3f41 Linus Torvalds                2005-04-16  182  
^1da177e4c3f41 Linus Torvalds                2005-04-16  183  	*ppos += read;
^1da177e4c3f41 Linus Torvalds                2005-04-16  184  	return read;
22ec1a2aea73b9 Kees Cook                     2017-12-01  185  
22ec1a2aea73b9 Kees Cook                     2017-12-01  186  failed:
22ec1a2aea73b9 Kees Cook                     2017-12-01  187  	kfree(bounce);
22ec1a2aea73b9 Kees Cook                     2017-12-01  188  	return err;
^1da177e4c3f41 Linus Torvalds                2005-04-16  189  }
^1da177e4c3f41 Linus Torvalds                2005-04-16  190  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
