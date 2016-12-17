From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 17 Dec 2016 11:38:26 +0000
Subject: Re: [PATCH 32/60] block: implement sp version of bvec iterator helpers
Message-Id: <CACVXFVN1weJVc4A6v=g7oAeMN1Cczupm8ObnXR8E8UBTJ9NqZA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1477728600-12938-33-git-send-email-tom.leiming@gmail.com> <201610291909.okAX73DP%fengguang.wu@intel.com>
In-Reply-To: <201610291909.okAX73DP%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kbuild test robot <lkp@intel.com>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: kbuild-all@01.org, Jens Axboe <axboe@fb.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Johannes Berg <johannes.berg@intel.com>

Hi Guys,

On Sat, Oct 29, 2016 at 7:06 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi Ming,

Thanks for the report!

>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.9-rc2 next-20161028]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> [Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
> [Check https://git-scm.com/docs/git-format-patch for more information]
>
> url:    https://github.com/0day-ci/linux/commits/Ming-Lei/block-support-multipage-bvec/20161029-163910
> config: sparc-defconfig (attached as .config)
> compiler: sparc-linux-gcc (GCC) 6.2.0
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from arch/sparc/include/asm/oplib.h:6:0,
>                     from arch/sparc/include/asm/pgtable_32.h:21,
>                     from arch/sparc/include/asm/pgtable.h:6,
>                     from include/linux/mm.h:68,


This issue should be caused by somewhere in sparc arch, and this patch
only adds '#include <linux/mm.h>' to 'include/linux/bvec.h' for using
nth_page().

So Cc sparc list.

Thanks,
Ming

>                     from include/linux/bvec.h:25,
>                     from include/linux/blk_types.h:9,
>                     from include/linux/fs.h:31,
>                     from include/linux/proc_fs.h:8,
>                     from arch/sparc/include/asm/prom.h:22,
>                     from include/linux/of.h:232,
>                     from arch/sparc/include/asm/openprom.h:14,
>                     from arch/sparc/include/asm/device.h:9,
>                     from include/linux/device.h:30,
>                     from include/linux/node.h:17,
>                     from include/linux/cpu.h:16,
>                     from include/linux/stop_machine.h:4,
>                     from kernel/sched/sched.h:10,
>                     from kernel/sched/loadavg.c:11:
>>> arch/sparc/include/asm/oplib_32.h:105:39: warning: 'struct linux_prom_registers' declared inside parameter list will not be visible outside of this definition or declaration
>     int prom_startcpu(int cpunode, struct linux_prom_registers *context_table,
>                                           ^~~~~~~~~~~~~~~~~~~~
>    arch/sparc/include/asm/oplib_32.h:168:36: warning: 'struct linux_prom_registers' declared inside parameter list will not be visible outside of this definition or declaration
>     void prom_apply_obio_ranges(struct linux_prom_registers *obioregs, int nregs);
>                                        ^~~~~~~~~~~~~~~~~~~~
>    arch/sparc/include/asm/oplib_32.h:172:18: warning: 'struct linux_prom_registers' declared inside parameter list will not be visible outside of this definition or declaration
>               struct linux_prom_registers *sbusregs, int nregs);
>                      ^~~~~~~~~~~~~~~~~~~~
> --
>    In file included from arch/sparc/include/asm/oplib.h:6:0,
>                     from arch/sparc/include/asm/pgtable_32.h:21,
>                     from arch/sparc/include/asm/pgtable.h:6,
>                     from include/linux/mm.h:68,
>                     from include/linux/bvec.h:25,
>                     from include/linux/blk_types.h:9,
>                     from include/linux/fs.h:31,
>                     from include/linux/proc_fs.h:8,
>                     from arch/sparc/include/asm/prom.h:22,
>                     from include/linux/of.h:232,
>                     from arch/sparc/include/asm/openprom.h:14,
>                     from arch/sparc/prom/mp.c:12:
>>> arch/sparc/include/asm/oplib_32.h:105:39: warning: 'struct linux_prom_registers' declared inside parameter list will not be visible outside of this definition or declaration
>     int prom_startcpu(int cpunode, struct linux_prom_registers *context_table,
>                                           ^~~~~~~~~~~~~~~~~~~~
>    arch/sparc/include/asm/oplib_32.h:168:36: warning: 'struct linux_prom_registers' declared inside parameter list will not be visible outside of this definition or declaration
>     void prom_apply_obio_ranges(struct linux_prom_registers *obioregs, int nregs);
>                                        ^~~~~~~~~~~~~~~~~~~~
>    arch/sparc/include/asm/oplib_32.h:172:18: warning: 'struct linux_prom_registers' declared inside parameter list will not be visible outside of this definition or declaration
>               struct linux_prom_registers *sbusregs, int nregs);
>                      ^~~~~~~~~~~~~~~~~~~~
>>> arch/sparc/prom/mp.c:23:1: error: conflicting types for 'prom_startcpu'
>     prom_startcpu(int cpunode, struct linux_prom_registers *ctable_reg, int ctx, char *pc)
>     ^~~~~~~~~~~~~
>    In file included from arch/sparc/include/asm/oplib.h:6:0,
>                     from arch/sparc/include/asm/pgtable_32.h:21,
>                     from arch/sparc/include/asm/pgtable.h:6,
>                     from include/linux/mm.h:68,
>                     from include/linux/bvec.h:25,
>                     from include/linux/blk_types.h:9,
>                     from include/linux/fs.h:31,
>                     from include/linux/proc_fs.h:8,
>                     from arch/sparc/include/asm/prom.h:22,
>                     from include/linux/of.h:232,
>                     from arch/sparc/include/asm/openprom.h:14,
>                     from arch/sparc/prom/mp.c:12:
>    arch/sparc/include/asm/oplib_32.h:105:5: note: previous declaration of 'prom_startcpu' was here
>     int prom_startcpu(int cpunode, struct linux_prom_registers *context_table,
>         ^~~~~~~~~~~~~
> --
>    In file included from arch/sparc/include/asm/oplib.h:6:0,
>                     from arch/sparc/include/asm/pgtable_32.h:21,
>                     from arch/sparc/include/asm/pgtable.h:6,
>                     from include/linux/mm.h:68,
>                     from include/linux/bvec.h:25,
>                     from include/linux/blk_types.h:9,
>                     from include/linux/fs.h:31,
>                     from include/linux/proc_fs.h:8,
>                     from arch/sparc/include/asm/prom.h:22,
>                     from include/linux/of.h:232,
>                     from arch/sparc/include/asm/openprom.h:14,
>                     from arch/sparc/prom/ranges.c:11:
>>> arch/sparc/include/asm/oplib_32.h:105:39: warning: 'struct linux_prom_registers' declared inside parameter list will not be visible outside of this definition or declaration
>     int prom_startcpu(int cpunode, struct linux_prom_registers *context_table,
>                                           ^~~~~~~~~~~~~~~~~~~~
>    arch/sparc/include/asm/oplib_32.h:168:36: warning: 'struct linux_prom_registers' declared inside parameter list will not be visible outside of this definition or declaration
>     void prom_apply_obio_ranges(struct linux_prom_registers *obioregs, int nregs);
>                                        ^~~~~~~~~~~~~~~~~~~~
>    arch/sparc/include/asm/oplib_32.h:172:18: warning: 'struct linux_prom_registers' declared inside parameter list will not be visible outside of this definition or declaration
>               struct linux_prom_registers *sbusregs, int nregs);
>                      ^~~~~~~~~~~~~~~~~~~~
>>> arch/sparc/prom/ranges.c:57:6: error: conflicting types for 'prom_apply_obio_ranges'
>     void prom_apply_obio_ranges(struct linux_prom_registers *regs, int nregs)
>          ^~~~~~~~~~~~~~~~~~~~~~
>    In file included from arch/sparc/include/asm/oplib.h:6:0,
>                     from arch/sparc/include/asm/pgtable_32.h:21,
>                     from arch/sparc/include/asm/pgtable.h:6,
>                     from include/linux/mm.h:68,
>                     from include/linux/bvec.h:25,
>                     from include/linux/blk_types.h:9,
>                     from include/linux/fs.h:31,
>                     from include/linux/proc_fs.h:8,
>                     from arch/sparc/include/asm/prom.h:22,
>                     from include/linux/of.h:232,
>                     from arch/sparc/include/asm/openprom.h:14,
>                     from arch/sparc/prom/ranges.c:11:
>    arch/sparc/include/asm/oplib_32.h:168:6: note: previous declaration of 'prom_apply_obio_ranges' was here
>     void prom_apply_obio_ranges(struct linux_prom_registers *obioregs, int nregs);
>          ^~~~~~~~~~~~~~~~~~~~~~
>    In file included from include/linux/linkage.h:6:0,
>                     from include/linux/kernel.h:6,
>                     from include/linux/list.h:8,
>                     from include/linux/module.h:9,
>                     from arch/sparc/prom/ranges.c:9:
>    arch/sparc/prom/ranges.c:62:15: error: conflicting types for 'prom_apply_obio_ranges'
>     EXPORT_SYMBOL(prom_apply_obio_ranges);
>                   ^
>    include/linux/export.h:58:21: note: in definition of macro '___EXPORT_SYMBOL'
>      extern typeof(sym) sym;      \
>                         ^~~
>>> arch/sparc/prom/ranges.c:62:1: note: in expansion of macro 'EXPORT_SYMBOL'
>     EXPORT_SYMBOL(prom_apply_obio_ranges);
>     ^~~~~~~~~~~~~
>    In file included from arch/sparc/include/asm/oplib.h:6:0,
>                     from arch/sparc/include/asm/pgtable_32.h:21,
>                     from arch/sparc/include/asm/pgtable.h:6,
>                     from include/linux/mm.h:68,
>                     from include/linux/bvec.h:25,
>                     from include/linux/blk_types.h:9,
>                     from include/linux/fs.h:31,
>                     from include/linux/proc_fs.h:8,
>                     from arch/sparc/include/asm/prom.h:22,
>                     from include/linux/of.h:232,
>                     from arch/sparc/include/asm/openprom.h:14,
>                     from arch/sparc/prom/ranges.c:11:
>    arch/sparc/include/asm/oplib_32.h:168:6: note: previous declaration of 'prom_apply_obio_ranges' was here
>     void prom_apply_obio_ranges(struct linux_prom_registers *obioregs, int nregs);
>          ^~~~~~~~~~~~~~~~~~~~~~
>>> arch/sparc/prom/ranges.c:87:6: error: conflicting types for 'prom_apply_generic_ranges'
>     void prom_apply_generic_ranges(phandle node, phandle parent,
>          ^~~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from arch/sparc/include/asm/oplib.h:6:0,
>                     from arch/sparc/include/asm/pgtable_32.h:21,
>                     from arch/sparc/include/asm/pgtable.h:6,
>                     from include/linux/mm.h:68,
>                     from include/linux/bvec.h:25,
>                     from include/linux/blk_types.h:9,
>                     from include/linux/fs.h:31,
>                     from include/linux/proc_fs.h:8,
>                     from arch/sparc/include/asm/prom.h:22,
>                     from include/linux/of.h:232,
>                     from arch/sparc/include/asm/openprom.h:14,
>                     from arch/sparc/prom/ranges.c:11:
>    arch/sparc/include/asm/oplib_32.h:171:6: note: previous declaration of 'prom_apply_generic_ranges' was here
>     void prom_apply_generic_ranges(phandle node, phandle parent,
>          ^~~~~~~~~~~~~~~~~~~~~~~~~
> --
>    In file included from include/linux/bvec.h:25:0,
>                     from include/linux/blk_types.h:9,
>                     from include/linux/fs.h:31,
>                     from include/linux/proc_fs.h:8,
>                     from arch/sparc/include/asm/prom.h:22,
>                     from include/linux/of.h:232,
>                     from arch/sparc/include/asm/openprom.h:14,
>                     from arch/sparc/include/asm/oplib_32.h:11,
>                     from arch/sparc/include/asm/oplib.h:6,
>                     from arch/sparc/include/asm/pgtable_32.h:21,
>                     from arch/sparc/include/asm/pgtable.h:6,
>                     from mm/init-mm.c:9:
>    include/linux/mm.h: In function 'is_vmalloc_addr':
>>> include/linux/mm.h:486:17: error: 'VMALLOC_START' undeclared (first use in this function)
>      return addr >= VMALLOC_START && addr < VMALLOC_END;
>                     ^~~~~~~~~~~~~
>    include/linux/mm.h:486:17: note: each undeclared identifier is reported only once for each function it appears in
>>> include/linux/mm.h:486:41: error: 'VMALLOC_END' undeclared (first use in this function)
>      return addr >= VMALLOC_START && addr < VMALLOC_END;
>                                             ^~~~~~~~~~~
>    include/linux/mm.h: In function 'maybe_mkwrite':
>>> include/linux/mm.h:624:9: error: implicit declaration of function 'pte_mkwrite' [-Werror=implicit-function-declaration]
>       pte = pte_mkwrite(pte);
>             ^~~~~~~~~~~
>    In file included from include/linux/bvec.h:25:0,
>                     from include/linux/blk_types.h:9,
>                     from include/linux/fs.h:31,
>                     from include/linux/proc_fs.h:8,
>                     from arch/sparc/include/asm/prom.h:22,
>                     from include/linux/of.h:232,
>                     from arch/sparc/include/asm/openprom.h:14,
>                     from arch/sparc/include/asm/oplib_32.h:11,
>                     from arch/sparc/include/asm/oplib.h:6,
>                     from arch/sparc/include/asm/pgtable_32.h:21,
>                     from arch/sparc/include/asm/pgtable.h:6,
>                     from mm/init-mm.c:9:
>    include/linux/mm.h: In function 'pgtable_init':
>>> include/linux/mm.h:1674:2: error: implicit declaration of function 'pgtable_cache_init' [-Werror=implicit-function-declaration]
>      pgtable_cache_init();
>      ^~~~~~~~~~~~~~~~~~
>    In file included from arch/sparc/include/asm/pgtable.h:6:0,
>                     from mm/init-mm.c:9:
>    arch/sparc/include/asm/pgtable_32.h: At top level:
>>> arch/sparc/include/asm/pgtable_32.h:245:21: error: conflicting types for 'pte_mkwrite'
>     static inline pte_t pte_mkwrite(pte_t pte)
>                         ^~~~~~~~~~~
>    In file included from include/linux/bvec.h:25:0,
>                     from include/linux/blk_types.h:9,
>                     from include/linux/fs.h:31,
>                     from include/linux/proc_fs.h:8,
>                     from arch/sparc/include/asm/prom.h:22,
>                     from include/linux/of.h:232,
>                     from arch/sparc/include/asm/openprom.h:14,
>                     from arch/sparc/include/asm/oplib_32.h:11,
>                     from arch/sparc/include/asm/oplib.h:6,
>                     from arch/sparc/include/asm/pgtable_32.h:21,
>                     from arch/sparc/include/asm/pgtable.h:6,
>                     from mm/init-mm.c:9:
>    include/linux/mm.h:624:9: note: previous implicit declaration of 'pte_mkwrite' was here
>       pte = pte_mkwrite(pte);
>             ^~~~~~~~~~~
>    cc1: some warnings being treated as errors
>
> vim +/VMALLOC_START +486 include/linux/mm.h
>
> 0738c4bb8 Paul Mundt             2008-03-12  480   */
> bb00a789e Yaowei Bai             2016-05-19  481  static inline bool is_vmalloc_addr(const void *x)
> 9e2779fa2 Christoph Lameter      2008-02-04  482  {
> 0738c4bb8 Paul Mundt             2008-03-12  483  #ifdef CONFIG_MMU
> 9e2779fa2 Christoph Lameter      2008-02-04  484        unsigned long addr = (unsigned long)x;
> 9e2779fa2 Christoph Lameter      2008-02-04  485
> 9e2779fa2 Christoph Lameter      2008-02-04 @486        return addr >= VMALLOC_START && addr < VMALLOC_END;
> 0738c4bb8 Paul Mundt             2008-03-12  487  #else
> bb00a789e Yaowei Bai             2016-05-19  488        return false;
> 8ca3ed87d David Howells          2008-02-23  489  #endif
> 0738c4bb8 Paul Mundt             2008-03-12  490  }
> 81ac3ad90 KAMEZAWA Hiroyuki      2009-09-22  491  #ifdef CONFIG_MMU
> 81ac3ad90 KAMEZAWA Hiroyuki      2009-09-22  492  extern int is_vmalloc_or_module_addr(const void *x);
> 81ac3ad90 KAMEZAWA Hiroyuki      2009-09-22  493  #else
> 934831d06 David Howells          2009-09-24  494  static inline int is_vmalloc_or_module_addr(const void *x)
> 81ac3ad90 KAMEZAWA Hiroyuki      2009-09-22  495  {
> 81ac3ad90 KAMEZAWA Hiroyuki      2009-09-22  496        return 0;
> 81ac3ad90 KAMEZAWA Hiroyuki      2009-09-22  497  }
> 81ac3ad90 KAMEZAWA Hiroyuki      2009-09-22  498  #endif
> 9e2779fa2 Christoph Lameter      2008-02-04  499
> 39f1f78d5 Al Viro                2014-05-06  500  extern void kvfree(const void *addr);
> 39f1f78d5 Al Viro                2014-05-06  501
> 53f9263ba Kirill A. Shutemov     2016-01-15  502  static inline atomic_t *compound_mapcount_ptr(struct page *page)
> 53f9263ba Kirill A. Shutemov     2016-01-15  503  {
> 53f9263ba Kirill A. Shutemov     2016-01-15  504        return &page[1].compound_mapcount;
> 53f9263ba Kirill A. Shutemov     2016-01-15  505  }
> 53f9263ba Kirill A. Shutemov     2016-01-15  506
> 53f9263ba Kirill A. Shutemov     2016-01-15  507  static inline int compound_mapcount(struct page *page)
> 53f9263ba Kirill A. Shutemov     2016-01-15  508  {
> 5f527c2b3 Andrea Arcangeli       2016-05-20  509        VM_BUG_ON_PAGE(!PageCompound(page), page);
> 53f9263ba Kirill A. Shutemov     2016-01-15  510        page = compound_head(page);
> 53f9263ba Kirill A. Shutemov     2016-01-15  511        return atomic_read(compound_mapcount_ptr(page)) + 1;
> 53f9263ba Kirill A. Shutemov     2016-01-15  512  }
> 53f9263ba Kirill A. Shutemov     2016-01-15  513
> ccaafd7fd Joonsoo Kim            2015-02-10  514  /*
> 70b50f94f Andrea Arcangeli       2011-11-02  515   * The atomic page->_mapcount, starts from -1: so that transitions
> 70b50f94f Andrea Arcangeli       2011-11-02  516   * both from it and to it can be tracked, using atomic_inc_and_test
> 70b50f94f Andrea Arcangeli       2011-11-02  517   * and atomic_add_negative(-1).
> 70b50f94f Andrea Arcangeli       2011-11-02  518   */
> 22b751c3d Mel Gorman             2013-02-22  519  static inline void page_mapcount_reset(struct page *page)
> 70b50f94f Andrea Arcangeli       2011-11-02  520  {
> 70b50f94f Andrea Arcangeli       2011-11-02  521        atomic_set(&(page)->_mapcount, -1);
> 70b50f94f Andrea Arcangeli       2011-11-02  522  }
> 70b50f94f Andrea Arcangeli       2011-11-02  523
> b20ce5e03 Kirill A. Shutemov     2016-01-15  524  int __page_mapcount(struct page *page);
> b20ce5e03 Kirill A. Shutemov     2016-01-15  525
> 70b50f94f Andrea Arcangeli       2011-11-02  526  static inline int page_mapcount(struct page *page)
> 70b50f94f Andrea Arcangeli       2011-11-02  527  {
> 1d148e218 Wang, Yalin            2015-02-11  528        VM_BUG_ON_PAGE(PageSlab(page), page);
> 53f9263ba Kirill A. Shutemov     2016-01-15  529
> b20ce5e03 Kirill A. Shutemov     2016-01-15  530        if (unlikely(PageCompound(page)))
> b20ce5e03 Kirill A. Shutemov     2016-01-15  531                return __page_mapcount(page);
> b20ce5e03 Kirill A. Shutemov     2016-01-15  532        return atomic_read(&page->_mapcount) + 1;
> 53f9263ba Kirill A. Shutemov     2016-01-15  533  }
> b20ce5e03 Kirill A. Shutemov     2016-01-15  534
> b20ce5e03 Kirill A. Shutemov     2016-01-15  535  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> b20ce5e03 Kirill A. Shutemov     2016-01-15  536  int total_mapcount(struct page *page);
> 6d0a07edd Andrea Arcangeli       2016-05-12  537  int page_trans_huge_mapcount(struct page *page, int *total_mapcount);
> b20ce5e03 Kirill A. Shutemov     2016-01-15  538  #else
> b20ce5e03 Kirill A. Shutemov     2016-01-15  539  static inline int total_mapcount(struct page *page)
> b20ce5e03 Kirill A. Shutemov     2016-01-15  540  {
> b20ce5e03 Kirill A. Shutemov     2016-01-15  541        return page_mapcount(page);
> 70b50f94f Andrea Arcangeli       2011-11-02  542  }
> 6d0a07edd Andrea Arcangeli       2016-05-12  543  static inline int page_trans_huge_mapcount(struct page *page,
> 6d0a07edd Andrea Arcangeli       2016-05-12  544                                           int *total_mapcount)
> 6d0a07edd Andrea Arcangeli       2016-05-12  545  {
> 6d0a07edd Andrea Arcangeli       2016-05-12  546        int mapcount = page_mapcount(page);
> 6d0a07edd Andrea Arcangeli       2016-05-12  547        if (total_mapcount)
> 6d0a07edd Andrea Arcangeli       2016-05-12  548                *total_mapcount = mapcount;
> 6d0a07edd Andrea Arcangeli       2016-05-12  549        return mapcount;
> 6d0a07edd Andrea Arcangeli       2016-05-12  550  }
> b20ce5e03 Kirill A. Shutemov     2016-01-15  551  #endif
> 70b50f94f Andrea Arcangeli       2011-11-02  552
> b49af68ff Christoph Lameter      2007-05-06  553  static inline struct page *virt_to_head_page(const void *x)
> b49af68ff Christoph Lameter      2007-05-06  554  {
> b49af68ff Christoph Lameter      2007-05-06  555        struct page *page = virt_to_page(x);
> ccaafd7fd Joonsoo Kim            2015-02-10  556
> 1d798ca3f Kirill A. Shutemov     2015-11-06  557        return compound_head(page);
> b49af68ff Christoph Lameter      2007-05-06  558  }
> b49af68ff Christoph Lameter      2007-05-06  559
> ddc58f27f Kirill A. Shutemov     2016-01-15  560  void __put_page(struct page *page);
> ddc58f27f Kirill A. Shutemov     2016-01-15  561
> 1d7ea7324 Alexander Zarochentsev 2006-08-13  562  void put_pages_list(struct list_head *pages);
> ^1da177e4 Linus Torvalds         2005-04-16  563
> 8dfcc9ba2 Nick Piggin            2006-03-22  564  void split_page(struct page *page, unsigned int order);
> 8dfcc9ba2 Nick Piggin            2006-03-22  565
> ^1da177e4 Linus Torvalds         2005-04-16  566  /*
> 33f2ef89f Andy Whitcroft         2006-12-06  567   * Compound pages have a destructor function.  Provide a
> 33f2ef89f Andy Whitcroft         2006-12-06  568   * prototype for that function and accessor functions.
> f1e61557f Kirill A. Shutemov     2015-11-06  569   * These are _only_ valid on the head of a compound page.
> 33f2ef89f Andy Whitcroft         2006-12-06  570   */
> f1e61557f Kirill A. Shutemov     2015-11-06  571  typedef void compound_page_dtor(struct page *);
> f1e61557f Kirill A. Shutemov     2015-11-06  572
> f1e61557f Kirill A. Shutemov     2015-11-06  573  /* Keep the enum in sync with compound_page_dtors array in mm/page_alloc.c */
> f1e61557f Kirill A. Shutemov     2015-11-06  574  enum compound_dtor_id {
> f1e61557f Kirill A. Shutemov     2015-11-06  575        NULL_COMPOUND_DTOR,
> f1e61557f Kirill A. Shutemov     2015-11-06  576        COMPOUND_PAGE_DTOR,
> f1e61557f Kirill A. Shutemov     2015-11-06  577  #ifdef CONFIG_HUGETLB_PAGE
> f1e61557f Kirill A. Shutemov     2015-11-06  578        HUGETLB_PAGE_DTOR,
> f1e61557f Kirill A. Shutemov     2015-11-06  579  #endif
> 9a982250f Kirill A. Shutemov     2016-01-15  580  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> 9a982250f Kirill A. Shutemov     2016-01-15  581        TRANSHUGE_PAGE_DTOR,
> 9a982250f Kirill A. Shutemov     2016-01-15  582  #endif
> f1e61557f Kirill A. Shutemov     2015-11-06  583        NR_COMPOUND_DTORS,
> f1e61557f Kirill A. Shutemov     2015-11-06  584  };
> f1e61557f Kirill A. Shutemov     2015-11-06  585  extern compound_page_dtor * const compound_page_dtors[];
> 33f2ef89f Andy Whitcroft         2006-12-06  586
> 33f2ef89f Andy Whitcroft         2006-12-06  587  static inline void set_compound_page_dtor(struct page *page,
> f1e61557f Kirill A. Shutemov     2015-11-06  588                enum compound_dtor_id compound_dtor)
> 33f2ef89f Andy Whitcroft         2006-12-06  589  {
> f1e61557f Kirill A. Shutemov     2015-11-06  590        VM_BUG_ON_PAGE(compound_dtor >= NR_COMPOUND_DTORS, page);
> f1e61557f Kirill A. Shutemov     2015-11-06  591        page[1].compound_dtor = compound_dtor;
> 33f2ef89f Andy Whitcroft         2006-12-06  592  }
> 33f2ef89f Andy Whitcroft         2006-12-06  593
> 33f2ef89f Andy Whitcroft         2006-12-06  594  static inline compound_page_dtor *get_compound_page_dtor(struct page *page)
> 33f2ef89f Andy Whitcroft         2006-12-06  595  {
> f1e61557f Kirill A. Shutemov     2015-11-06  596        VM_BUG_ON_PAGE(page[1].compound_dtor >= NR_COMPOUND_DTORS, page);
> f1e61557f Kirill A. Shutemov     2015-11-06  597        return compound_page_dtors[page[1].compound_dtor];
> 33f2ef89f Andy Whitcroft         2006-12-06  598  }
> 33f2ef89f Andy Whitcroft         2006-12-06  599
> d00181b96 Kirill A. Shutemov     2015-11-06  600  static inline unsigned int compound_order(struct page *page)
> d85f33855 Christoph Lameter      2007-05-06  601  {
> 6d7779538 Christoph Lameter      2007-05-06  602        if (!PageHead(page))
> d85f33855 Christoph Lameter      2007-05-06  603                return 0;
> e4b294c2d Kirill A. Shutemov     2015-02-11  604        return page[1].compound_order;
> d85f33855 Christoph Lameter      2007-05-06  605  }
> d85f33855 Christoph Lameter      2007-05-06  606
> f1e61557f Kirill A. Shutemov     2015-11-06  607  static inline void set_compound_order(struct page *page, unsigned int order)
> d85f33855 Christoph Lameter      2007-05-06  608  {
> e4b294c2d Kirill A. Shutemov     2015-02-11  609        page[1].compound_order = order;
> d85f33855 Christoph Lameter      2007-05-06  610  }
> d85f33855 Christoph Lameter      2007-05-06  611
> 9a982250f Kirill A. Shutemov     2016-01-15  612  void free_compound_page(struct page *page);
> 9a982250f Kirill A. Shutemov     2016-01-15  613
> 3dece370e Michal Simek           2011-01-21  614  #ifdef CONFIG_MMU
> 33f2ef89f Andy Whitcroft         2006-12-06  615  /*
> 14fd403f2 Andrea Arcangeli       2011-01-13  616   * Do pte_mkwrite, but only if the vma says VM_WRITE.  We do this when
> 14fd403f2 Andrea Arcangeli       2011-01-13  617   * servicing faults for write access.  In the normal case, do always want
> 14fd403f2 Andrea Arcangeli       2011-01-13  618   * pte_mkwrite.  But get_user_pages can cause write faults for mappings
> 14fd403f2 Andrea Arcangeli       2011-01-13  619   * that do not have writing enabled, when used by access_process_vm.
> 14fd403f2 Andrea Arcangeli       2011-01-13  620   */
> 14fd403f2 Andrea Arcangeli       2011-01-13  621  static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
> 14fd403f2 Andrea Arcangeli       2011-01-13  622  {
> 14fd403f2 Andrea Arcangeli       2011-01-13  623        if (likely(vma->vm_flags & VM_WRITE))
> 14fd403f2 Andrea Arcangeli       2011-01-13 @624                pte = pte_mkwrite(pte);
> 14fd403f2 Andrea Arcangeli       2011-01-13  625        return pte;
> 14fd403f2 Andrea Arcangeli       2011-01-13  626  }
> 8c6e50b02 Kirill A. Shutemov     2014-04-07  627
>
> :::::: The code at line 486 was first introduced by commit
> :::::: 9e2779fa281cfda13ac060753d674bbcaa23367e is_vmalloc_addr(): Check if an address is within the vmalloc boundaries
>
> :::::: TO: Christoph Lameter <clameter@sgi.com>
> :::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Ming Lei
