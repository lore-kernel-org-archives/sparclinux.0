From: Josh Grebe <josh@brokedown.net>
Date: Tue, 30 Aug 2005 15:04:10 +0000
Subject: Re: [gentoo-sparc] 2.6 kernel and docs
Message-Id: <4314756A.40204@brokedown.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050829.130957.02952920.davem@davemloft.net>
In-Reply-To: <20050829.130957.02952920.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

Hi Dave,

Well, its a little different now! I crashed very quickly the first
run, before I commented out that MEMORY_READ_BARRIER(). After
commenting it out, I ran for a couple of hours. The difference is...
Once I've crashed, I can hit enter on my serial console and it echos
it back. Previously, it would not echo back. Sending breaks and sysrq
commands doesn't generate any response.

I do not have a framebuffer/keyboard on this box, and it is remote to
me, but I may be able to assemble an identical box locally that I can
put a frambuffer into, and I'll ask Ferris to test on his box in a
console mode as well. Also, as per your blog, I'll try commenting out
the line in sym53c8xx_2.c that you reference in your blog entry and
see if it makes a difference.

Josh





David S. Miller wrote:
> Ok, I think I killed the 2.6.x SMP bug on pre-Ultra-III systems using
> Symbios scsi controllers, you can read about the process by which I
> debugging this in my blog:
> 
> 	http://vger.kernel.org/~davem/cgi-bin/blog.cgi/index.html
> 
> Anyways, the following patch over any recent kernel should provide
> the fix.  If it doesn't, go into drivers/scsi/sym53c8xx_2/sym_hipd.c,
> function sym_wakeup_done(), and comment out the MEMORY_READ_BARRIER()
> that isn't already commented out and retest.
> 
> But I think this patch should cure it, for sure, and I'm rerunning
> my stress tests to verify that locally as well.
> 
> Thanks for being so patient, I hope we got it...
> 
> diff-tree 4f07118f656c179740cad35b827032e2e29b1210 (from 442464a50077ff00454ff8d7628cbe1b8eacc034)
> Author: David S. Miller <davem@davemloft.net>
> Date:   Mon Aug 29 12:46:22 2005 -0700
> 
>     [SPARC64]: More fully work around Spitfire Errata 51.
>     
>     It appears that a memory barrier soon after a mispredicted
>     branch, not just in the delay slot, can cause the hang
>     condition of this cpu errata.
>     
>     So move them out-of-line, and explicitly put them into
>     a "branch always, predict taken" delay slot which should
>     fully kill this problem.
>     
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> diff --git a/arch/sparc64/kernel/pci_iommu.c b/arch/sparc64/kernel/pci_iommu.c
> --- a/arch/sparc64/kernel/pci_iommu.c
> +++ b/arch/sparc64/kernel/pci_iommu.c
> @@ -466,7 +466,7 @@ do_flush_sync:
>  		if (!limit)
>  			break;
>  		udelay(1);
> -		membar("#LoadLoad");
> +		rmb();
>  	}
>  	if (!limit)
>  		printk(KERN_WARNING "pci_strbuf_flush: flushflag timeout "
> diff --git a/arch/sparc64/kernel/process.c b/arch/sparc64/kernel/process.c
> --- a/arch/sparc64/kernel/process.c
> +++ b/arch/sparc64/kernel/process.c
> @@ -103,7 +103,7 @@ void cpu_idle(void)
>  		 * other cpus see our increasing idleness for the buddy
>  		 * redistribution algorithm.  -DaveM
>  		 */
> -		membar("#StoreStore | #StoreLoad");
> +		membar_storeload_storestore();
>  	}
>  }
>  
> diff --git a/arch/sparc64/kernel/sbus.c b/arch/sparc64/kernel/sbus.c
> --- a/arch/sparc64/kernel/sbus.c
> +++ b/arch/sparc64/kernel/sbus.c
> @@ -147,7 +147,7 @@ static void sbus_strbuf_flush(struct sbu
>  		if (!limit)
>  			break;
>  		udelay(1);
> -		membar("#LoadLoad");
> +		rmb();
>  	}
>  	if (!limit)
>  		printk(KERN_WARNING "sbus_strbuf_flush: flushflag timeout "
> diff --git a/arch/sparc64/kernel/signal32.c b/arch/sparc64/kernel/signal32.c
> --- a/arch/sparc64/kernel/signal32.c
> +++ b/arch/sparc64/kernel/signal32.c
> @@ -877,11 +877,12 @@ static void new_setup_frame32(struct k_s
>  			unsigned long page = (unsigned long)
>  				page_address(pte_page(*ptep));
>  
> -			__asm__ __volatile__(
> -			"	membar	#StoreStore\n"
> -			"	flush	%0 + %1"
> -			: : "r" (page), "r" (address & (PAGE_SIZE - 1))
> -			: "memory");
> +			wmb();
> +			__asm__ __volatile__("flush	%0 + %1"
> +					     : /* no outputs */
> +					     : "r" (page),
> +					       "r" (address & (PAGE_SIZE - 1))
> +					     : "memory");
>  		}
>  		pte_unmap(ptep);
>  		preempt_enable();
> @@ -1292,11 +1293,12 @@ static void setup_rt_frame32(struct k_si
>  			unsigned long page = (unsigned long)
>  				page_address(pte_page(*ptep));
>  
> -			__asm__ __volatile__(
> -			"	membar	#StoreStore\n"
> -			"	flush	%0 + %1"
> -			: : "r" (page), "r" (address & (PAGE_SIZE - 1))
> -			: "memory");
> +			wmb();
> +			__asm__ __volatile__("flush	%0 + %1"
> +					     : /* no outputs */
> +					     : "r" (page),
> +					       "r" (address & (PAGE_SIZE - 1))
> +					     : "memory");
>  		}
>  		pte_unmap(ptep);
>  		preempt_enable();
> diff --git a/arch/sparc64/kernel/smp.c b/arch/sparc64/kernel/smp.c
> --- a/arch/sparc64/kernel/smp.c
> +++ b/arch/sparc64/kernel/smp.c
> @@ -144,7 +144,7 @@ void __init smp_callin(void)
>  	current->active_mm = &init_mm;
>  
>  	while (!cpu_isset(cpuid, smp_commenced_mask))
> -		membar("#LoadLoad");
> +		rmb();
>  
>  	cpu_set(cpuid, cpu_online_map);
>  }
> @@ -184,11 +184,11 @@ static inline long get_delta (long *rt, 
>  	for (i = 0; i < NUM_ITERS; i++) {
>  		t0 = tick_ops->get_tick();
>  		go[MASTER] = 1;
> -		membar("#StoreLoad");
> +		membar_storeload();
>  		while (!(tm = go[SLAVE]))
> -			membar("#LoadLoad");
> +			rmb();
>  		go[SLAVE] = 0;
> -		membar("#StoreStore");
> +		wmb();
>  		t1 = tick_ops->get_tick();
>  
>  		if (t1 - t0 < best_t1 - best_t0)
> @@ -221,7 +221,7 @@ void smp_synchronize_tick_client(void)
>  	go[MASTER] = 1;
>  
>  	while (go[MASTER])
> -		membar("#LoadLoad");
> +		rmb();
>  
>  	local_irq_save(flags);
>  	{
> @@ -273,21 +273,21 @@ static void smp_synchronize_one_tick(int
>  
>  	/* wait for client to be ready */
>  	while (!go[MASTER])
> -		membar("#LoadLoad");
> +		rmb();
>  
>  	/* now let the client proceed into his loop */
>  	go[MASTER] = 0;
> -	membar("#StoreLoad");
> +	membar_storeload();
>  
>  	spin_lock_irqsave(&itc_sync_lock, flags);
>  	{
>  		for (i = 0; i < NUM_ROUNDS*NUM_ITERS; i++) {
>  			while (!go[MASTER])
> -				membar("#LoadLoad");
> +				rmb();
>  			go[MASTER] = 0;
> -			membar("#StoreStore");
> +			wmb();
>  			go[SLAVE] = tick_ops->get_tick();
> -			membar("#StoreLoad");
> +			membar_storeload();
>  		}
>  	}
>  	spin_unlock_irqrestore(&itc_sync_lock, flags);
> @@ -927,11 +927,11 @@ void smp_capture(void)
>  		       smp_processor_id());
>  #endif
>  		penguins_are_doing_time = 1;
> -		membar("#StoreStore | #LoadStore");
> +		membar_storestore_loadstore();
>  		atomic_inc(&smp_capture_registry);
>  		smp_cross_call(&xcall_capture, 0, 0, 0);
>  		while (atomic_read(&smp_capture_registry) != ncpus)
> -			membar("#LoadLoad");
> +			rmb();
>  #ifdef CAPTURE_DEBUG
>  		printk("done\n");
>  #endif
> @@ -947,7 +947,7 @@ void smp_release(void)
>  		       smp_processor_id());
>  #endif
>  		penguins_are_doing_time = 0;
> -		membar("#StoreStore | #StoreLoad");
> +		membar_storeload_storestore();
>  		atomic_dec(&smp_capture_registry);
>  	}
>  }
> @@ -970,9 +970,9 @@ void smp_penguin_jailcell(int irq, struc
>  	save_alternate_globals(global_save);
>  	prom_world(1);
>  	atomic_inc(&smp_capture_registry);
> -	membar("#StoreLoad | #StoreStore");
> +	membar_storeload_storestore();
>  	while (penguins_are_doing_time)
> -		membar("#LoadLoad");
> +		rmb();
>  	restore_alternate_globals(global_save);
>  	atomic_dec(&smp_capture_registry);
>  	prom_world(0);
> diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
> --- a/arch/sparc64/kernel/sparc64_ksyms.c
> +++ b/arch/sparc64/kernel/sparc64_ksyms.c
> @@ -406,3 +406,12 @@ EXPORT_SYMBOL(xor_vis_4);
>  EXPORT_SYMBOL(xor_vis_5);
>  
>  EXPORT_SYMBOL(prom_palette);
> +
> +/* memory barriers */
> +EXPORT_SYMBOL(mb);
> +EXPORT_SYMBOL(rmb);
> +EXPORT_SYMBOL(wmb);
> +EXPORT_SYMBOL(membar_storeload);
> +EXPORT_SYMBOL(membar_storeload_storestore);
> +EXPORT_SYMBOL(membar_storeload_loadload);
> +EXPORT_SYMBOL(membar_storestore_loadstore);
> diff --git a/arch/sparc64/lib/Makefile b/arch/sparc64/lib/Makefile
> --- a/arch/sparc64/lib/Makefile
> +++ b/arch/sparc64/lib/Makefile
> @@ -12,7 +12,7 @@ lib-y := PeeCeeI.o copy_page.o clear_pag
>  	 U1memcpy.o U1copy_from_user.o U1copy_to_user.o \
>  	 U3memcpy.o U3copy_from_user.o U3copy_to_user.o U3patch.o \
>  	 copy_in_user.o user_fixup.o memmove.o \
> -	 mcount.o ipcsum.o rwsem.o xor.o find_bit.o delay.o
> +	 mcount.o ipcsum.o rwsem.o xor.o find_bit.o delay.o mb.o
>  
>  lib-$(CONFIG_DEBUG_SPINLOCK) += debuglocks.o
>  lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
> diff --git a/arch/sparc64/lib/debuglocks.c b/arch/sparc64/lib/debuglocks.c
> --- a/arch/sparc64/lib/debuglocks.c
> +++ b/arch/sparc64/lib/debuglocks.c
> @@ -61,7 +61,7 @@ again:
>  			     : "=r" (val)
>  			     : "r" (&(lock->lock))
>  			     : "memory");
> -	membar("#StoreLoad | #StoreStore");
> +	membar_storeload_storestore();
>  	if (val) {
>  		while (lock->lock) {
>  			if (!--stuck) {
> @@ -69,7 +69,7 @@ again:
>  					show(str, lock, caller);
>  				stuck = INIT_STUCK;
>  			}
> -			membar("#LoadLoad");
> +			rmb();
>  		}
>  		goto again;
>  	}
> @@ -90,7 +90,7 @@ int _do_spin_trylock(spinlock_t *lock, u
>  			     : "=r" (val)
>  			     : "r" (&(lock->lock))
>  			     : "memory");
> -	membar("#StoreLoad | #StoreStore");
> +	membar_storeload_storestore();
>  	if (!val) {
>  		lock->owner_pc = ((unsigned int)caller);
>  		lock->owner_cpu = cpu;
> @@ -107,7 +107,7 @@ void _do_spin_unlock(spinlock_t *lock)
>  {
>  	lock->owner_pc = 0;
>  	lock->owner_cpu = NO_PROC_ID;
> -	membar("#StoreStore | #LoadStore");
> +	membar_storestore_loadstore();
>  	lock->lock = 0;
>  	current->thread.smp_lock_count--;
>  }
> @@ -129,7 +129,7 @@ wlock_again:
>  				show_read(str, rw, caller);
>  			stuck = INIT_STUCK;
>  		}
> -		membar("#LoadLoad");
> +		rmb();
>  	}
>  	/* Try once to increment the counter.  */
>  	__asm__ __volatile__(
> @@ -142,7 +142,7 @@ wlock_again:
>  "2:"	: "=r" (val)
>  	: "0" (&(rw->lock))
>  	: "g1", "g7", "memory");
> -	membar("#StoreLoad | #StoreStore");
> +	membar_storeload_storestore();
>  	if (val)
>  		goto wlock_again;
>  	rw->reader_pc[cpu] = ((unsigned int)caller);
> @@ -201,7 +201,7 @@ wlock_again:
>  				show_write(str, rw, caller);
>  			stuck = INIT_STUCK;
>  		}
> -		membar("#LoadLoad");
> +		rmb();
>  	}
>  
>  	/* Try to acuire the write bit.  */
> @@ -256,7 +256,7 @@ wlock_again:
>  					show_write(str, rw, caller);
>  				stuck = INIT_STUCK;
>  			}
> -			membar("#LoadLoad");
> +			rmb();
>  		}
>  		goto wlock_again;
>  	}
> diff --git a/arch/sparc64/lib/mb.S b/arch/sparc64/lib/mb.S
> new file mode 100644
> --- /dev/null
> +++ b/arch/sparc64/lib/mb.S
> @@ -0,0 +1,73 @@
> +/* mb.S: Out of line memory barriers.
> + *
> + * Copyright (C) 2005 David S. Miller (davem@davemloft.net)
> + */
> +
> +	/* These are here in an effort to more fully work around
> +	 * Spitfire Errata #51.  Essentially, if a memory barrier
> +	 * occurs soon after a mispredicted branch, the chip can stop
> +	 * executing instructions until a trap occurs.  Therefore, if
> +	 * interrupts are disabled, the chip can hang forever.
> +	 *
> +	 * It used to be believed that the memory barrier had to be
> +	 * right in the delay slot, but a case has been traced
> +	 * recently wherein the memory barrier was one instruction
> +	 * after the branch delay slot and the chip still hung.  The
> +	 * offending sequence was the following in sym_wakeup_done()
> +	 * of the sym53c8xx_2 driver:
> +	 *
> +	 *	call	sym_ccb_from_dsa, 0
> +	 *	 movge	%icc, 0, %l0
> +	 *	brz,pn	%o0, .LL1303
> +	 *	 mov	%o0, %l2
> +	 *	membar	#LoadLoad
> +	 *
> +	 * The branch has to be mispredicted for the bug to occur.
> +	 * Therefore, we put the memory barrier explicitly into a
> +	 * "branch always, predicted taken" delay slot to avoid the
> +	 * problem case.
> +	 */
> +
> +	.text
> +
> +99:	retl
> +	 nop
> +
> +	.globl	mb
> +mb:	ba,pt	%xcc, 99b
> +	 membar	#LoadLoad | #LoadStore | #StoreStore | #StoreLoad
> +	.size	mb, .-mb
> +
> +	.globl	rmb
> +rmb:	ba,pt	%xcc, 99b
> +	 membar	#LoadLoad
> +	.size	rmb, .-rmb
> +
> +	.globl	wmb
> +wmb:	ba,pt	%xcc, 99b
> +	 membar	#StoreStore
> +	.size	wmb, .-wmb
> +
> +	.globl	membar_storeload
> +membar_storeload:
> +	ba,pt	%xcc, 99b
> +	 membar	#StoreLoad
> +	.size	membar_storeload, .-membar_storeload
> +
> +	.globl	membar_storeload_storestore
> +membar_storeload_storestore:
> +	ba,pt	%xcc, 99b
> +	 membar	#StoreLoad | #StoreStore
> +	.size	membar_storeload_storestore, .-membar_storeload_storestore
> +
> +	.globl	membar_storeload_loadload
> +membar_storeload_loadload:
> +	ba,pt	%xcc, 99b
> +	 membar	#StoreLoad | #LoadLoad
> +	.size	membar_storeload_loadload, .-membar_storeload_loadload
> +
> +	.globl	membar_storestore_loadstore
> +membar_storestore_loadstore:
> +	ba,pt	%xcc, 99b
> +	 membar	#StoreStore | #LoadStore
> +	.size	membar_storestore_loadstore, .-membar_storestore_loadstore
> diff --git a/arch/sparc64/solaris/misc.c b/arch/sparc64/solaris/misc.c
> --- a/arch/sparc64/solaris/misc.c
> +++ b/arch/sparc64/solaris/misc.c
> @@ -737,7 +737,8 @@ MODULE_LICENSE("GPL");
>  extern u32 tl0_solaris[8];
>  #define update_ttable(x) 										\
>  	tl0_solaris[3] = (((long)(x) - (long)tl0_solaris - 3) >> 2) | 0x40000000;			\
> -	__asm__ __volatile__ ("membar #StoreStore; flush %0" : : "r" (&tl0_solaris[3]))
> +	wmb();		\
> +	__asm__ __volatile__ ("flush %0" : : "r" (&tl0_solaris[3]))
>  #else
>  #endif	
>  
> @@ -761,7 +762,8 @@ int init_module(void)
>  	entry64_personality_patch |>  		(offsetof(struct task_struct, personality) +
>  		 (sizeof(unsigned long) - 1));
> -	__asm__ __volatile__("membar #StoreStore; flush %0"
> +	wmb();
> +	__asm__ __volatile__("flush %0"
>  			     : : "r" (&entry64_personality_patch));
>  	return 0;
>  }
> diff --git a/include/asm-sparc64/atomic.h b/include/asm-sparc64/atomic.h
> --- a/include/asm-sparc64/atomic.h
> +++ b/include/asm-sparc64/atomic.h
> @@ -72,10 +72,10 @@ extern int atomic64_sub_ret(int, atomic6
>  
>  /* Atomic operations are already serializing */
>  #ifdef CONFIG_SMP
> -#define smp_mb__before_atomic_dec()	membar("#StoreLoad | #LoadLoad")
> -#define smp_mb__after_atomic_dec()	membar("#StoreLoad | #StoreStore")
> -#define smp_mb__before_atomic_inc()	membar("#StoreLoad | #LoadLoad")
> -#define smp_mb__after_atomic_inc()	membar("#StoreLoad | #StoreStore")
> +#define smp_mb__before_atomic_dec()	membar_storeload_loadload();
> +#define smp_mb__after_atomic_dec()	membar_storeload_storestore();
> +#define smp_mb__before_atomic_inc()	membar_storeload_loadload();
> +#define smp_mb__after_atomic_inc()	membar_storeload_storestore();
>  #else
>  #define smp_mb__before_atomic_dec()	barrier()
>  #define smp_mb__after_atomic_dec()	barrier()
> diff --git a/include/asm-sparc64/bitops.h b/include/asm-sparc64/bitops.h
> --- a/include/asm-sparc64/bitops.h
> +++ b/include/asm-sparc64/bitops.h
> @@ -72,8 +72,8 @@ static inline int __test_and_change_bit(
>  }
>  
>  #ifdef CONFIG_SMP
> -#define smp_mb__before_clear_bit()	membar("#StoreLoad | #LoadLoad")
> -#define smp_mb__after_clear_bit()	membar("#StoreLoad | #StoreStore")
> +#define smp_mb__before_clear_bit()	membar_storeload_loadload()
> +#define smp_mb__after_clear_bit()	membar_storeload_storestore()
>  #else
>  #define smp_mb__before_clear_bit()	barrier()
>  #define smp_mb__after_clear_bit()	barrier()
> diff --git a/include/asm-sparc64/spinlock.h b/include/asm-sparc64/spinlock.h
> --- a/include/asm-sparc64/spinlock.h
> +++ b/include/asm-sparc64/spinlock.h
> @@ -43,7 +43,7 @@ typedef struct {
>  #define spin_is_locked(lp)  ((lp)->lock != 0)
>  
>  #define spin_unlock_wait(lp)	\
> -do {	membar("#LoadLoad");	\
> +do {	rmb();			\
>  } while((lp)->lock)
>  
>  static inline void _raw_spin_lock(spinlock_t *lock)
> @@ -129,7 +129,7 @@ typedef struct {
>  #define spin_is_locked(__lock)	((__lock)->lock != 0)
>  #define spin_unlock_wait(__lock)	\
>  do { \
> -	membar("#LoadLoad"); \
> +	rmb(); \
>  } while((__lock)->lock)
>  
>  extern void _do_spin_lock(spinlock_t *lock, char *str, unsigned long caller);
> diff --git a/include/asm-sparc64/system.h b/include/asm-sparc64/system.h
> --- a/include/asm-sparc64/system.h
> +++ b/include/asm-sparc64/system.h
> @@ -28,6 +28,14 @@ enum sparc_cpu {
>  #define ARCH_SUN4C_SUN4 0
>  #define ARCH_SUN4 0
>  
> +extern void mb(void);
> +extern void rmb(void);
> +extern void wmb(void);
> +extern void membar_storeload(void);
> +extern void membar_storeload_storestore(void);
> +extern void membar_storeload_loadload(void);
> +extern void membar_storestore_loadstore(void);
> +
>  #endif
>  
>  #define setipl(__new_ipl) \
> @@ -78,16 +86,11 @@ enum sparc_cpu {
>  
>  #define nop() 		__asm__ __volatile__ ("nop")
>  
> -#define membar(type)	__asm__ __volatile__ ("membar " type : : : "memory")
> -#define mb()		\
> -	membar("#LoadLoad | #LoadStore | #StoreStore | #StoreLoad")
> -#define rmb()		membar("#LoadLoad")
> -#define wmb()		membar("#StoreStore")
>  #define read_barrier_depends()		do { } while(0)
>  #define set_mb(__var, __value) \
> -	do { __var = __value; membar("#StoreLoad | #StoreStore"); } while(0)
> +	do { __var = __value; membar_storeload_storestore(); } while(0)
>  #define set_wmb(__var, __value) \
> -	do { __var = __value; membar("#StoreStore"); } while(0)
> +	do { __var = __value; wmb(); } while(0)
>  
>  #ifdef CONFIG_SMP
>  #define smp_mb()	mb()
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> !DSPAM:43136ac7289081123014463!
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDFHVpT/OY5rt9JCMRA1rRAJ4k3gRRknYJ6AjDFXXr9vJIGzJadQCfaSab
xa1roJpo3gorPa597FDc2Vs=nCiu
-----END PGP SIGNATURE-----
