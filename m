From: kbuild test robot <lkp@intel.com>
Date: Tue, 29 Mar 2016 22:38:38 +0000
Subject: Re: [PATCH v3] sparc64: Reduce TLB flushes during hugepte changes
Message-Id: <201603300647.PqTf5ciq%fengguang.wu@intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
List-Id: <sparclinux.vger.kernel.org>
References: <1459285913-141365-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1459285913-141365-1-git-send-email-nitin.m.gupta@oracle.com>
To: sparclinux@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nitin,

[auto build test ERROR on sparc/master]
[also build test ERROR on v4.6-rc1 next-20160329]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Nitin-Gupta/sparc64-Reduce-TLB-flushes-during-hugepte-changes/20160330-051327
base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master
config: sparc64-allnoconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All errors (new ones prefixed by >>):

   arch/sparc/mm/tlb.c: In function 'tlb_batch_add':
>> arch/sparc/mm/tlb.c:115:2: error: implicit declaration of function 'is_hugetlb_pte' [-Werror=implicit-function-declaration]
     bool huge = is_hugetlb_pte(orig);
     ^
   cc1: all warnings being treated as errors

vim +/is_hugetlb_pte +115 arch/sparc/mm/tlb.c

   109		put_cpu_var(tlb_batch);
   110	}
   111	
   112	void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
   113			   pte_t *ptep, pte_t orig, int fullmm)
   114	{
 > 115		bool huge = is_hugetlb_pte(orig);
   116	
   117		if (tlb_type != hypervisor &&
   118		    pte_dirty(orig)) {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ZPt4rx8FFjLCG7dd
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
MkIAAA==

--ZPt4rx8FFjLCG7dd--
