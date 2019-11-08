From: kbuild test robot <lkp@intel.com>
Date: Fri, 08 Nov 2019 07:08:34 +0000
Subject: Re: [PATCH 34/50] sparc: Add show_stack_loglvl()
Message-Id: <201911081505.R23PlN77%lkp@intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="c53wnjkvna3htfvu"
List-Id: <sparclinux.vger.kernel.org>
References: <20191106030542.868541-35-dima@arista.com>
In-Reply-To: <20191106030542.868541-35-dima@arista.com>
To: Dmitry Safonov <dima@arista.com>
Cc: kbuild-all@lists.01.org, linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org


--c53wnjkvna3htfvu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dmitry,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.4-rc6 next-20191107]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Dmitry-Safonov/kallsyms-printk-Add-loglvl-to-print_ip_sym/20191108-124037
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 847120f859cc45e074204f4cf33c8df069306eb2
config: sparc-defconfig (attached as .config)
compiler: sparc-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=sparc 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/sparc/kernel/process_32.c: In function 'show_stack_loglvl':
>> arch/sparc/kernel/process_32.c:160:7: error: 'tsk' undeclared (first use in this function); did you mean 'task'?
     if (!tsk)
          ^~~
          task
   arch/sparc/kernel/process_32.c:160:7: note: each undeclared identifier is reported only once for each function it appears in
>> arch/sparc/kernel/process_32.c:163:25: error: '_ksp' undeclared (first use in this function); did you mean 'sp'?
     if (tsk == current && !_ksp)
                            ^~~~
                            sp

vim +160 arch/sparc/kernel/process_32.c

^1da177e4c3f41 arch/sparc/kernel/process.c    Linus Torvalds 2005-04-16  146  
^1da177e4c3f41 arch/sparc/kernel/process.c    Linus Torvalds 2005-04-16  147  /*
17ea0216681912 arch/sparc/kernel/process_32.c Dmitry Safonov 2019-11-06  148   * The show_stack(), show_stack_loglvl() are external APIs which
17ea0216681912 arch/sparc/kernel/process_32.c Dmitry Safonov 2019-11-06  149   * we do not use ourselves.
^1da177e4c3f41 arch/sparc/kernel/process.c    Linus Torvalds 2005-04-16  150   * The oops is printed in die_if_kernel.
^1da177e4c3f41 arch/sparc/kernel/process.c    Linus Torvalds 2005-04-16  151   */
17ea0216681912 arch/sparc/kernel/process_32.c Dmitry Safonov 2019-11-06  152  void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
17ea0216681912 arch/sparc/kernel/process_32.c Dmitry Safonov 2019-11-06  153  		       const char *loglvl)
^1da177e4c3f41 arch/sparc/kernel/process.c    Linus Torvalds 2005-04-16  154  {
^1da177e4c3f41 arch/sparc/kernel/process.c    Linus Torvalds 2005-04-16  155  	unsigned long pc, fp;
^1da177e4c3f41 arch/sparc/kernel/process.c    Linus Torvalds 2005-04-16  156  	unsigned long task_base;
4d7b92ad572b4b arch/sparc/kernel/process_32.c Sam Ravnborg   2009-01-02  157  	struct reg_window32 *rw;
^1da177e4c3f41 arch/sparc/kernel/process.c    Linus Torvalds 2005-04-16  158  	int count = 0;
^1da177e4c3f41 arch/sparc/kernel/process.c    Linus Torvalds 2005-04-16  159  
89e3f23da9c827 arch/sparc/kernel/process_32.c Tejun Heo      2013-04-30 @160  	if (!tsk)
89e3f23da9c827 arch/sparc/kernel/process_32.c Tejun Heo      2013-04-30  161  		tsk = current;
89e3f23da9c827 arch/sparc/kernel/process_32.c Tejun Heo      2013-04-30  162  
89e3f23da9c827 arch/sparc/kernel/process_32.c Tejun Heo      2013-04-30 @163  	if (tsk == current && !_ksp)
89e3f23da9c827 arch/sparc/kernel/process_32.c Tejun Heo      2013-04-30  164  		__asm__ __volatile__("mov	%%fp, %0" : "=r" (_ksp));
^1da177e4c3f41 arch/sparc/kernel/process.c    Linus Torvalds 2005-04-16  165  
89e3f23da9c827 arch/sparc/kernel/process_32.c Tejun Heo      2013-04-30  166  	task_base = (unsigned long) task_stack_page(tsk);
^1da177e4c3f41 arch/sparc/kernel/process.c    Linus Torvalds 2005-04-16  167  	fp = (unsigned long) _ksp;
^1da177e4c3f41 arch/sparc/kernel/process.c    Linus Torvalds 2005-04-16  168  	do {
^1da177e4c3f41 arch/sparc/kernel/process.c    Linus Torvalds 2005-04-16  169  		/* Bogus frame pointer? */
^1da177e4c3f41 arch/sparc/kernel/process.c    Linus Torvalds 2005-04-16  170  		if (fp < (task_base + sizeof(struct thread_info)) ||
^1da177e4c3f41 arch/sparc/kernel/process.c    Linus Torvalds 2005-04-16  171  		    fp >= (task_base + (PAGE_SIZE << 1)))
^1da177e4c3f41 arch/sparc/kernel/process.c    Linus Torvalds 2005-04-16  172  			break;
4d7b92ad572b4b arch/sparc/kernel/process_32.c Sam Ravnborg   2009-01-02  173  		rw = (struct reg_window32 *) fp;
^1da177e4c3f41 arch/sparc/kernel/process.c    Linus Torvalds 2005-04-16  174  		pc = rw->ins[7];
17ea0216681912 arch/sparc/kernel/process_32.c Dmitry Safonov 2019-11-06  175  		printk("%s[%08lx : ", loglvl, pc);
17ea0216681912 arch/sparc/kernel/process_32.c Dmitry Safonov 2019-11-06  176  		printk("%s%pS ] ", loglvl, (void *) pc);
^1da177e4c3f41 arch/sparc/kernel/process.c    Linus Torvalds 2005-04-16  177  		fp = rw->ins[6];
^1da177e4c3f41 arch/sparc/kernel/process.c    Linus Torvalds 2005-04-16  178  	} while (++count < 16);
17ea0216681912 arch/sparc/kernel/process_32.c Dmitry Safonov 2019-11-06  179  	printk("%s\n", loglvl);
17ea0216681912 arch/sparc/kernel/process_32.c Dmitry Safonov 2019-11-06  180  }
17ea0216681912 arch/sparc/kernel/process_32.c Dmitry Safonov 2019-11-06  181  

:::::: The code at line 160 was first introduced by commit
:::::: 89e3f23da9c827bfa9806c3d4da83a12c1c8543a sparc32: make show_stack() acquire %fp if @_ksp is not specified

:::::: TO: Tejun Heo <tj@kernel.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--c53wnjkvna3htfvu
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
iMFzzypz0y0KdYWgKY6D/AXYIFRNGsoAAA==

--c53wnjkvna3htfvu--
