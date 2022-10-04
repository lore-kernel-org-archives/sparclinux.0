Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD3DC4332F
	for <sparclinux@archiver.kernel.org>; Tue,  4 Oct 2022 09:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJDJvd (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 4 Oct 2022 05:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiJDJvN (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 4 Oct 2022 05:51:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F74DF4
        for <sparclinux@vger.kernel.org>; Tue,  4 Oct 2022 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664876978; x=1696412978;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6irqsE1Q0+QVcrjI58AIsvKXyeF0c0LulQrc+BT2sew=;
  b=gBhFtnjTCWgg70RLah04WUS9972gC2cH19uyGiYkxpj64AJX8G+wFA5y
   iDi8sW0vQMWQNtuCC5Rue9L1BXMyaK5DB0Viy3gglYXp4bEJ4sY2aZFhR
   MZ3kXjrmzKxrJIRR187bbv//HORTqrHpkZfE3AcX7MnZVqLOgu4VdR7Bz
   313wfb4AKuXILKo8vWplaVh6HKINbaqiu0lp6gcNmJtAg0Yh6+xrcngD6
   Ni1cOzeNIC8LFimAkWtwKsC+cfIdp3kxRjIoerAzperH2A+c6kH7B8E8h
   gNWtFq64nWTh56YGX1VUdS1lNbhWybnADuyzr3cZOypQ+f2cQEUu6CLQI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="303829157"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="303829157"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 02:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="654706065"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="654706065"
Received: from lkp-server01.sh.intel.com (HELO d4f44333118a) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 04 Oct 2022 02:49:35 -0700
Received: from kbuild by d4f44333118a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ofeYR-00005l-0J;
        Tue, 04 Oct 2022 09:49:35 +0000
Date:   Tue, 04 Oct 2022 17:49:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     sparclinux@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:pending-fixes] BUILD REGRESSION
 37b3c1c31342cdb8ee57f80a3a78cfe651a3f2ae
Message-ID: <633c0193.srGRSlP3TyZ9yamz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git pending-fixes
branch HEAD: 37b3c1c31342cdb8ee57f80a3a78cfe651a3f2ae  Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git

Error/Warning reports:

https://lore.kernel.org/linux-mm/202210041036.f84z3tBl-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/sparc/mm/srmmu.c:1662:25: error: too few arguments to function 'xc1'
arch/sparc/mm/srmmu.c:1662:30: error: 'smpfunc_t' undeclared (first use in this function); did you mean 'cmp_func_t'?
arch/sparc/mm/srmmu.c:1662:40: error: expected ')' before 'local_ops'
arch/sparc/mm/srmmu.c:1694:25: error: too few arguments to function 'xc3'
arch/sparc/mm/srmmu.c:1726:25: error: too few arguments to function 'xc2'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- sparc-randconfig-r005-20221002
    |-- arch-sparc-mm-srmmu.c:error:expected-)-before-local_ops
    |-- arch-sparc-mm-srmmu.c:error:smpfunc_t-undeclared-(first-use-in-this-function)
    |-- arch-sparc-mm-srmmu.c:error:too-few-arguments-to-function-xc1
    |-- arch-sparc-mm-srmmu.c:error:too-few-arguments-to-function-xc2
    `-- arch-sparc-mm-srmmu.c:error:too-few-arguments-to-function-xc3

elapsed time: 721m

configs tested: 64
configs skipped: 2

gcc tested configs:
um                           x86_64_defconfig
arc                                 defconfig
um                             i386_defconfig
alpha                               defconfig
i386                                defconfig
s390                                defconfig
x86_64                              defconfig
x86_64                           rhel-8.3-syz
s390                             allmodconfig
x86_64                         rhel-8.3-kunit
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                               rhel-8.3
powerpc                           allnoconfig
x86_64                          rhel-8.3-func
arm                                 defconfig
arc                              allyesconfig
i386                 randconfig-a014-20221003
x86_64                    rhel-8.3-kselftests
alpha                            allyesconfig
i386                 randconfig-a011-20221003
arm                              allyesconfig
s390                             allyesconfig
i386                 randconfig-a012-20221003
x86_64                           allyesconfig
m68k                             allyesconfig
i386                 randconfig-a013-20221003
arm64                            allyesconfig
i386                 randconfig-a015-20221003
i386                 randconfig-a016-20221003
ia64                             allmodconfig
i386                             allyesconfig
riscv                randconfig-r042-20221003
x86_64               randconfig-a013-20221003
arc                  randconfig-r043-20221003
x86_64               randconfig-a011-20221003
x86_64               randconfig-a015-20221003
arc                  randconfig-r043-20221002
x86_64               randconfig-a012-20221003
s390                 randconfig-r044-20221003
x86_64               randconfig-a016-20221003
x86_64               randconfig-a014-20221003
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig

clang tested configs:
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
i386                 randconfig-a004-20221003
i386                 randconfig-a005-20221003
hexagon              randconfig-r041-20221003
i386                 randconfig-a006-20221003
riscv                randconfig-r042-20221002
hexagon              randconfig-r041-20221002
x86_64               randconfig-a003-20221003
x86_64               randconfig-a002-20221003
s390                 randconfig-r044-20221002
x86_64               randconfig-a001-20221003
x86_64               randconfig-a004-20221003
x86_64               randconfig-a006-20221003
x86_64               randconfig-a005-20221003
hexagon              randconfig-r045-20221002
hexagon              randconfig-r045-20221003
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
