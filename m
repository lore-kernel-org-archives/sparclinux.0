From: kbuild test robot <lkp@intel.com>
Date: Fri, 27 Nov 2015 12:02:33 +0000
Subject: Re: [PATCH v2 1/5] printk/nmi: Generic solution for safe printk in NMI
Message-Id: <201511271911.gmHRjeel%fengguang.wu@intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
List-Id: <sparclinux.vger.kernel.org>
References: <1448622572-16900-2-git-send-email-pmladek@suse.com>
In-Reply-To: <1448622572-16900-2-git-send-email-pmladek@suse.com>
To: sparclinux@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Petr,

[auto build test ERROR on: powerpc/next]
[also build test ERROR on: v4.4-rc2 next-20151127]
[cannot apply to: tip/x86/core]

url:    https://github.com/0day-ci/linux/commits/Petr-Mladek/Cleaning-printk-stuff-in-NMI-context/20151127-191620
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: i386-randconfig-s1-201547 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/percpu.h:551:0,
                    from arch/x86/include/asm/current.h:5,
                    from arch/x86/include/asm/processor.h:15,
                    from arch/x86/include/asm/atomic.h:6,
                    from include/linux/atomic.h:4,
                    from include/linux/llist.h:58,
                    from include/linux/smp.h:14,
                    from kernel/printk/nmi.c:18:
   kernel/printk/printk.h: In function 'vprintk_func':
>> include/asm-generic/percpu.h:111:2: error: implicit declaration of function 'preempt_disable' [-Werror=implicit-function-declaration]
     preempt_disable();      \
     ^
>> include/asm-generic/percpu.h:305:31: note: in expansion of macro 'this_cpu_generic_read'
    #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                                  ^
>> include/linux/percpu-defs.h:311:23: note: in expansion of macro 'this_cpu_read_8'
     case 8: pscr_ret__ = stem##8(variable); break;   \
                          ^
>> include/linux/percpu-defs.h:494:29: note: in expansion of macro '__pcpu_size_call_return'
    #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                                ^
>> kernel/printk/printk.h:34:9: note: in expansion of macro 'this_cpu_read'
     return this_cpu_read(printk_func)(fmt, args);
            ^
>> include/asm-generic/percpu.h:113:2: error: implicit declaration of function 'preempt_enable' [-Werror=implicit-function-declaration]
     preempt_enable();      \
     ^
>> include/asm-generic/percpu.h:305:31: note: in expansion of macro 'this_cpu_generic_read'
    #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                                  ^
>> include/linux/percpu-defs.h:311:23: note: in expansion of macro 'this_cpu_read_8'
     case 8: pscr_ret__ = stem##8(variable); break;   \
                          ^
>> include/linux/percpu-defs.h:494:29: note: in expansion of macro '__pcpu_size_call_return'
    #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                                ^
>> kernel/printk/printk.h:34:9: note: in expansion of macro 'this_cpu_read'
     return this_cpu_read(printk_func)(fmt, args);
            ^
   kernel/printk/nmi.c: In function '__printk_nmi_flush':
>> kernel/printk/nmi.c:106:9: error: unknown type name 'raw_spinlock_t'
     static raw_spinlock_t read_lock =
            ^
>> kernel/printk/nmi.c:107:3: error: implicit declaration of function '__RAW_SPIN_LOCK_INITIALIZER' [-Werror=implicit-function-declaration]
      __RAW_SPIN_LOCK_INITIALIZER(read_lock);
      ^
>> kernel/printk/nmi.c:107:3: error: initializer element is not constant
>> kernel/printk/nmi.c:118:2: error: implicit declaration of function 'raw_spin_lock' [-Werror=implicit-function-declaration]
     raw_spin_lock(&read_lock);
     ^
>> kernel/printk/nmi.c:163:2: error: implicit declaration of function 'raw_spin_unlock' [-Werror=implicit-function-declaration]
     raw_spin_unlock(&read_lock);
     ^
   cc1: some warnings being treated as errors

vim +/preempt_disable +111 include/asm-generic/percpu.h

9c28278a24 Tejun Heo 2014-06-17  105  	(__ret);							\
9c28278a24 Tejun Heo 2014-06-17  106  })
9c28278a24 Tejun Heo 2014-06-17  107  
eba117889a Tejun Heo 2014-06-17  108  #define this_cpu_generic_read(pcp)					\
eba117889a Tejun Heo 2014-06-17  109  ({									\
eba117889a Tejun Heo 2014-06-17  110  	typeof(pcp) __ret;						\
9c28278a24 Tejun Heo 2014-06-17 @111  	preempt_disable();						\
eba117889a Tejun Heo 2014-06-17  112  	__ret = *this_cpu_ptr(&(pcp));					\
9c28278a24 Tejun Heo 2014-06-17 @113  	preempt_enable();						\
eba117889a Tejun Heo 2014-06-17  114  	__ret;								\
9c28278a24 Tejun Heo 2014-06-17  115  })
9c28278a24 Tejun Heo 2014-06-17  116  
eba117889a Tejun Heo 2014-06-17  117  #define this_cpu_generic_to_op(pcp, val, op)				\
9c28278a24 Tejun Heo 2014-06-17  118  do {									\
eba117889a Tejun Heo 2014-06-17  119  	unsigned long __flags;						\
eba117889a Tejun Heo 2014-06-17  120  	raw_local_irq_save(__flags);					\
9c28278a24 Tejun Heo 2014-06-17  121  	*raw_cpu_ptr(&(pcp)) op val;					\
eba117889a Tejun Heo 2014-06-17  122  	raw_local_irq_restore(__flags);					\
9c28278a24 Tejun Heo 2014-06-17  123  } while (0)
9c28278a24 Tejun Heo 2014-06-17  124  
eba117889a Tejun Heo 2014-06-17  125  #define this_cpu_generic_add_return(pcp, val)				\
9c28278a24 Tejun Heo 2014-06-17  126  ({									\
eba117889a Tejun Heo 2014-06-17  127  	typeof(pcp) __ret;						\
eba117889a Tejun Heo 2014-06-17  128  	unsigned long __flags;						\
eba117889a Tejun Heo 2014-06-17  129  	raw_local_irq_save(__flags);					\
9c28278a24 Tejun Heo 2014-06-17  130  	raw_cpu_add(pcp, val);						\
eba117889a Tejun Heo 2014-06-17  131  	__ret = raw_cpu_read(pcp);					\
eba117889a Tejun Heo 2014-06-17  132  	raw_local_irq_restore(__flags);					\
eba117889a Tejun Heo 2014-06-17  133  	__ret;								\
9c28278a24 Tejun Heo 2014-06-17  134  })
9c28278a24 Tejun Heo 2014-06-17  135  
eba117889a Tejun Heo 2014-06-17  136  #define this_cpu_generic_xchg(pcp, nval)				\
eba117889a Tejun Heo 2014-06-17  137  ({									\
eba117889a Tejun Heo 2014-06-17  138  	typeof(pcp) __ret;						\
eba117889a Tejun Heo 2014-06-17  139  	unsigned long __flags;						\
eba117889a Tejun Heo 2014-06-17  140  	raw_local_irq_save(__flags);					\
eba117889a Tejun Heo 2014-06-17  141  	__ret = raw_cpu_read(pcp);					\
9c28278a24 Tejun Heo 2014-06-17  142  	raw_cpu_write(pcp, nval);					\
eba117889a Tejun Heo 2014-06-17  143  	raw_local_irq_restore(__flags);					\
eba117889a Tejun Heo 2014-06-17  144  	__ret;								\
9c28278a24 Tejun Heo 2014-06-17  145  })
9c28278a24 Tejun Heo 2014-06-17  146  
eba117889a Tejun Heo 2014-06-17  147  #define this_cpu_generic_cmpxchg(pcp, oval, nval)			\
9c28278a24 Tejun Heo 2014-06-17  148  ({									\
eba117889a Tejun Heo 2014-06-17  149  	typeof(pcp) __ret;						\
eba117889a Tejun Heo 2014-06-17  150  	unsigned long __flags;						\
eba117889a Tejun Heo 2014-06-17  151  	raw_local_irq_save(__flags);					\
eba117889a Tejun Heo 2014-06-17  152  	__ret = raw_cpu_read(pcp);					\
eba117889a Tejun Heo 2014-06-17  153  	if (__ret == (oval))						\
9c28278a24 Tejun Heo 2014-06-17  154  		raw_cpu_write(pcp, nval);				\
eba117889a Tejun Heo 2014-06-17  155  	raw_local_irq_restore(__flags);					\
eba117889a Tejun Heo 2014-06-17  156  	__ret;								\
9c28278a24 Tejun Heo 2014-06-17  157  })
9c28278a24 Tejun Heo 2014-06-17  158  
eba117889a Tejun Heo 2014-06-17  159  #define this_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)	\
9c28278a24 Tejun Heo 2014-06-17  160  ({									\
eba117889a Tejun Heo 2014-06-17  161  	int __ret;							\
eba117889a Tejun Heo 2014-06-17  162  	unsigned long __flags;						\
eba117889a Tejun Heo 2014-06-17  163  	raw_local_irq_save(__flags);					\
eba117889a Tejun Heo 2014-06-17  164  	__ret = raw_cpu_generic_cmpxchg_double(pcp1, pcp2,		\
9c28278a24 Tejun Heo 2014-06-17  165  			oval1, oval2, nval1, nval2);			\
eba117889a Tejun Heo 2014-06-17  166  	raw_local_irq_restore(__flags);					\
eba117889a Tejun Heo 2014-06-17  167  	__ret;								\
9c28278a24 Tejun Heo 2014-06-17  168  })
9c28278a24 Tejun Heo 2014-06-17  169  
47b69ad673 Tejun Heo 2014-06-17  170  #ifndef raw_cpu_read_1
47b69ad673 Tejun Heo 2014-06-17  171  #define raw_cpu_read_1(pcp)		(*raw_cpu_ptr(&(pcp)))
47b69ad673 Tejun Heo 2014-06-17  172  #endif
47b69ad673 Tejun Heo 2014-06-17  173  #ifndef raw_cpu_read_2
47b69ad673 Tejun Heo 2014-06-17  174  #define raw_cpu_read_2(pcp)		(*raw_cpu_ptr(&(pcp)))
47b69ad673 Tejun Heo 2014-06-17  175  #endif
47b69ad673 Tejun Heo 2014-06-17  176  #ifndef raw_cpu_read_4
47b69ad673 Tejun Heo 2014-06-17  177  #define raw_cpu_read_4(pcp)		(*raw_cpu_ptr(&(pcp)))
47b69ad673 Tejun Heo 2014-06-17  178  #endif
47b69ad673 Tejun Heo 2014-06-17  179  #ifndef raw_cpu_read_8
47b69ad673 Tejun Heo 2014-06-17  180  #define raw_cpu_read_8(pcp)		(*raw_cpu_ptr(&(pcp)))
47b69ad673 Tejun Heo 2014-06-17  181  #endif
47b69ad673 Tejun Heo 2014-06-17  182  
47b69ad673 Tejun Heo 2014-06-17  183  #ifndef raw_cpu_write_1
eba117889a Tejun Heo 2014-06-17  184  #define raw_cpu_write_1(pcp, val)	raw_cpu_generic_to_op(pcp, val, =)
47b69ad673 Tejun Heo 2014-06-17  185  #endif
47b69ad673 Tejun Heo 2014-06-17  186  #ifndef raw_cpu_write_2
eba117889a Tejun Heo 2014-06-17  187  #define raw_cpu_write_2(pcp, val)	raw_cpu_generic_to_op(pcp, val, =)
47b69ad673 Tejun Heo 2014-06-17  188  #endif
47b69ad673 Tejun Heo 2014-06-17  189  #ifndef raw_cpu_write_4
eba117889a Tejun Heo 2014-06-17  190  #define raw_cpu_write_4(pcp, val)	raw_cpu_generic_to_op(pcp, val, =)
47b69ad673 Tejun Heo 2014-06-17  191  #endif
47b69ad673 Tejun Heo 2014-06-17  192  #ifndef raw_cpu_write_8
eba117889a Tejun Heo 2014-06-17  193  #define raw_cpu_write_8(pcp, val)	raw_cpu_generic_to_op(pcp, val, =)
47b69ad673 Tejun Heo 2014-06-17  194  #endif
47b69ad673 Tejun Heo 2014-06-17  195  
47b69ad673 Tejun Heo 2014-06-17  196  #ifndef raw_cpu_add_1
eba117889a Tejun Heo 2014-06-17  197  #define raw_cpu_add_1(pcp, val)		raw_cpu_generic_to_op(pcp, val, +=)
47b69ad673 Tejun Heo 2014-06-17  198  #endif
47b69ad673 Tejun Heo 2014-06-17  199  #ifndef raw_cpu_add_2
eba117889a Tejun Heo 2014-06-17  200  #define raw_cpu_add_2(pcp, val)		raw_cpu_generic_to_op(pcp, val, +=)
47b69ad673 Tejun Heo 2014-06-17  201  #endif
47b69ad673 Tejun Heo 2014-06-17  202  #ifndef raw_cpu_add_4
eba117889a Tejun Heo 2014-06-17  203  #define raw_cpu_add_4(pcp, val)		raw_cpu_generic_to_op(pcp, val, +=)
47b69ad673 Tejun Heo 2014-06-17  204  #endif
47b69ad673 Tejun Heo 2014-06-17  205  #ifndef raw_cpu_add_8
eba117889a Tejun Heo 2014-06-17  206  #define raw_cpu_add_8(pcp, val)		raw_cpu_generic_to_op(pcp, val, +=)
47b69ad673 Tejun Heo 2014-06-17  207  #endif
47b69ad673 Tejun Heo 2014-06-17  208  
47b69ad673 Tejun Heo 2014-06-17  209  #ifndef raw_cpu_and_1
eba117889a Tejun Heo 2014-06-17  210  #define raw_cpu_and_1(pcp, val)		raw_cpu_generic_to_op(pcp, val, &=)
47b69ad673 Tejun Heo 2014-06-17  211  #endif
47b69ad673 Tejun Heo 2014-06-17  212  #ifndef raw_cpu_and_2
eba117889a Tejun Heo 2014-06-17  213  #define raw_cpu_and_2(pcp, val)		raw_cpu_generic_to_op(pcp, val, &=)
47b69ad673 Tejun Heo 2014-06-17  214  #endif
47b69ad673 Tejun Heo 2014-06-17  215  #ifndef raw_cpu_and_4
eba117889a Tejun Heo 2014-06-17  216  #define raw_cpu_and_4(pcp, val)		raw_cpu_generic_to_op(pcp, val, &=)
47b69ad673 Tejun Heo 2014-06-17  217  #endif
47b69ad673 Tejun Heo 2014-06-17  218  #ifndef raw_cpu_and_8
eba117889a Tejun Heo 2014-06-17  219  #define raw_cpu_and_8(pcp, val)		raw_cpu_generic_to_op(pcp, val, &=)
47b69ad673 Tejun Heo 2014-06-17  220  #endif
47b69ad673 Tejun Heo 2014-06-17  221  
47b69ad673 Tejun Heo 2014-06-17  222  #ifndef raw_cpu_or_1
eba117889a Tejun Heo 2014-06-17  223  #define raw_cpu_or_1(pcp, val)		raw_cpu_generic_to_op(pcp, val, |=)
47b69ad673 Tejun Heo 2014-06-17  224  #endif
47b69ad673 Tejun Heo 2014-06-17  225  #ifndef raw_cpu_or_2
eba117889a Tejun Heo 2014-06-17  226  #define raw_cpu_or_2(pcp, val)		raw_cpu_generic_to_op(pcp, val, |=)
47b69ad673 Tejun Heo 2014-06-17  227  #endif
47b69ad673 Tejun Heo 2014-06-17  228  #ifndef raw_cpu_or_4
eba117889a Tejun Heo 2014-06-17  229  #define raw_cpu_or_4(pcp, val)		raw_cpu_generic_to_op(pcp, val, |=)
47b69ad673 Tejun Heo 2014-06-17  230  #endif
47b69ad673 Tejun Heo 2014-06-17  231  #ifndef raw_cpu_or_8
eba117889a Tejun Heo 2014-06-17  232  #define raw_cpu_or_8(pcp, val)		raw_cpu_generic_to_op(pcp, val, |=)
47b69ad673 Tejun Heo 2014-06-17  233  #endif
47b69ad673 Tejun Heo 2014-06-17  234  
47b69ad673 Tejun Heo 2014-06-17  235  #ifndef raw_cpu_add_return_1
47b69ad673 Tejun Heo 2014-06-17  236  #define raw_cpu_add_return_1(pcp, val)	raw_cpu_generic_add_return(pcp, val)
47b69ad673 Tejun Heo 2014-06-17  237  #endif
47b69ad673 Tejun Heo 2014-06-17  238  #ifndef raw_cpu_add_return_2
47b69ad673 Tejun Heo 2014-06-17  239  #define raw_cpu_add_return_2(pcp, val)	raw_cpu_generic_add_return(pcp, val)
47b69ad673 Tejun Heo 2014-06-17  240  #endif
47b69ad673 Tejun Heo 2014-06-17  241  #ifndef raw_cpu_add_return_4
47b69ad673 Tejun Heo 2014-06-17  242  #define raw_cpu_add_return_4(pcp, val)	raw_cpu_generic_add_return(pcp, val)
47b69ad673 Tejun Heo 2014-06-17  243  #endif
47b69ad673 Tejun Heo 2014-06-17  244  #ifndef raw_cpu_add_return_8
47b69ad673 Tejun Heo 2014-06-17  245  #define raw_cpu_add_return_8(pcp, val)	raw_cpu_generic_add_return(pcp, val)
47b69ad673 Tejun Heo 2014-06-17  246  #endif
47b69ad673 Tejun Heo 2014-06-17  247  
47b69ad673 Tejun Heo 2014-06-17  248  #ifndef raw_cpu_xchg_1
47b69ad673 Tejun Heo 2014-06-17  249  #define raw_cpu_xchg_1(pcp, nval)	raw_cpu_generic_xchg(pcp, nval)
47b69ad673 Tejun Heo 2014-06-17  250  #endif
47b69ad673 Tejun Heo 2014-06-17  251  #ifndef raw_cpu_xchg_2
47b69ad673 Tejun Heo 2014-06-17  252  #define raw_cpu_xchg_2(pcp, nval)	raw_cpu_generic_xchg(pcp, nval)
47b69ad673 Tejun Heo 2014-06-17  253  #endif
47b69ad673 Tejun Heo 2014-06-17  254  #ifndef raw_cpu_xchg_4
47b69ad673 Tejun Heo 2014-06-17  255  #define raw_cpu_xchg_4(pcp, nval)	raw_cpu_generic_xchg(pcp, nval)
47b69ad673 Tejun Heo 2014-06-17  256  #endif
47b69ad673 Tejun Heo 2014-06-17  257  #ifndef raw_cpu_xchg_8
47b69ad673 Tejun Heo 2014-06-17  258  #define raw_cpu_xchg_8(pcp, nval)	raw_cpu_generic_xchg(pcp, nval)
47b69ad673 Tejun Heo 2014-06-17  259  #endif
47b69ad673 Tejun Heo 2014-06-17  260  
47b69ad673 Tejun Heo 2014-06-17  261  #ifndef raw_cpu_cmpxchg_1
eba117889a Tejun Heo 2014-06-17  262  #define raw_cpu_cmpxchg_1(pcp, oval, nval) \
eba117889a Tejun Heo 2014-06-17  263  	raw_cpu_generic_cmpxchg(pcp, oval, nval)
47b69ad673 Tejun Heo 2014-06-17  264  #endif
47b69ad673 Tejun Heo 2014-06-17  265  #ifndef raw_cpu_cmpxchg_2
eba117889a Tejun Heo 2014-06-17  266  #define raw_cpu_cmpxchg_2(pcp, oval, nval) \
eba117889a Tejun Heo 2014-06-17  267  	raw_cpu_generic_cmpxchg(pcp, oval, nval)
47b69ad673 Tejun Heo 2014-06-17  268  #endif
47b69ad673 Tejun Heo 2014-06-17  269  #ifndef raw_cpu_cmpxchg_4
eba117889a Tejun Heo 2014-06-17  270  #define raw_cpu_cmpxchg_4(pcp, oval, nval) \
eba117889a Tejun Heo 2014-06-17  271  	raw_cpu_generic_cmpxchg(pcp, oval, nval)
47b69ad673 Tejun Heo 2014-06-17  272  #endif
47b69ad673 Tejun Heo 2014-06-17  273  #ifndef raw_cpu_cmpxchg_8
eba117889a Tejun Heo 2014-06-17  274  #define raw_cpu_cmpxchg_8(pcp, oval, nval) \
eba117889a Tejun Heo 2014-06-17  275  	raw_cpu_generic_cmpxchg(pcp, oval, nval)
47b69ad673 Tejun Heo 2014-06-17  276  #endif
47b69ad673 Tejun Heo 2014-06-17  277  
47b69ad673 Tejun Heo 2014-06-17  278  #ifndef raw_cpu_cmpxchg_double_1
47b69ad673 Tejun Heo 2014-06-17  279  #define raw_cpu_cmpxchg_double_1(pcp1, pcp2, oval1, oval2, nval1, nval2) \
47b69ad673 Tejun Heo 2014-06-17  280  	raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
47b69ad673 Tejun Heo 2014-06-17  281  #endif
47b69ad673 Tejun Heo 2014-06-17  282  #ifndef raw_cpu_cmpxchg_double_2
47b69ad673 Tejun Heo 2014-06-17  283  #define raw_cpu_cmpxchg_double_2(pcp1, pcp2, oval1, oval2, nval1, nval2) \
47b69ad673 Tejun Heo 2014-06-17  284  	raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
47b69ad673 Tejun Heo 2014-06-17  285  #endif
47b69ad673 Tejun Heo 2014-06-17  286  #ifndef raw_cpu_cmpxchg_double_4
47b69ad673 Tejun Heo 2014-06-17  287  #define raw_cpu_cmpxchg_double_4(pcp1, pcp2, oval1, oval2, nval1, nval2) \
47b69ad673 Tejun Heo 2014-06-17  288  	raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
47b69ad673 Tejun Heo 2014-06-17  289  #endif
47b69ad673 Tejun Heo 2014-06-17  290  #ifndef raw_cpu_cmpxchg_double_8
47b69ad673 Tejun Heo 2014-06-17  291  #define raw_cpu_cmpxchg_double_8(pcp1, pcp2, oval1, oval2, nval1, nval2) \
47b69ad673 Tejun Heo 2014-06-17  292  	raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
47b69ad673 Tejun Heo 2014-06-17  293  #endif
47b69ad673 Tejun Heo 2014-06-17  294  
47b69ad673 Tejun Heo 2014-06-17  295  #ifndef this_cpu_read_1
eba117889a Tejun Heo 2014-06-17  296  #define this_cpu_read_1(pcp)		this_cpu_generic_read(pcp)
47b69ad673 Tejun Heo 2014-06-17  297  #endif
47b69ad673 Tejun Heo 2014-06-17  298  #ifndef this_cpu_read_2
eba117889a Tejun Heo 2014-06-17  299  #define this_cpu_read_2(pcp)		this_cpu_generic_read(pcp)
47b69ad673 Tejun Heo 2014-06-17  300  #endif
47b69ad673 Tejun Heo 2014-06-17  301  #ifndef this_cpu_read_4
eba117889a Tejun Heo 2014-06-17  302  #define this_cpu_read_4(pcp)		this_cpu_generic_read(pcp)
47b69ad673 Tejun Heo 2014-06-17  303  #endif
47b69ad673 Tejun Heo 2014-06-17  304  #ifndef this_cpu_read_8
eba117889a Tejun Heo 2014-06-17 @305  #define this_cpu_read_8(pcp)		this_cpu_generic_read(pcp)
47b69ad673 Tejun Heo 2014-06-17  306  #endif
47b69ad673 Tejun Heo 2014-06-17  307  
47b69ad673 Tejun Heo 2014-06-17  308  #ifndef this_cpu_write_1

:::::: The code at line 111 was first introduced by commit
:::::: 9c28278a24c01c0073fb89e53c1d2a605ab9587d percpu: reorder macros in percpu header files

:::::: TO: Tejun Heo <tj@kernel.org>
:::::: CC: Tejun Heo <tj@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--qMm9M+Fa2AknHoGS
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
TF9Rkfd0lAbI/wMdz2s161oBAA==

--qMm9M+Fa2AknHoGS--
