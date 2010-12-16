From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 16 Dec 2010 14:24:02 +0000
Subject: SPARC32 SMP IRQ15 question
Message-Id: <4D0A2102.8030100@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello Dave,

I have an architectural question about the SPARC32 port regarding how 
IRQ15 is used for cross calls.

Why is IRQ15, the non-maskable IRQ, used for cross calls? Would it not 
be safer to use IRQ14?

Since IRQ15 is non-maskable it will even interrupt spin_lock_irqsave() 
protected reqions. I assume it is safe as long as the cross call 
function run in IRQ context does not try to take the same spinlock, for 
that would create a dead lock I believe. For example atomic_add() on 
SPARC32 below is implemented using one of four global spinlocks, does 
that mean that we can not use atomic functions at all from within a 
cross call function?

#define atomic_add(i, v)    ((void)__atomic_add_return( (int)(i), (v)))

#define ATOMIC_HASH_SIZE    4
#define ATOMIC_HASH(a)    (&__atomic_hash[(((unsigned long)a)>>8) & 
(ATOMIC_HASH_SIZE-1)])

spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] = {
    [0 ... (ATOMIC_HASH_SIZE-1)] = SPIN_LOCK_UNLOCKED
};

int __atomic_add_return(int i, atomic_t *v)
{
    int ret;
    unsigned long flags;
    spin_lock_irqsave(ATOMIC_HASH(v), flags);

    ret = (v->counter += i);

    spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
    return ret;
}


This particular case is interesting since atomic instructions are used 
by drain_local_pages() helper functions, which is scheduled as a cross 
call in drain_all_pages():

#0   0xf02cb884   0xf14b97a0   _raw_spin_lock_irqsave + 0x54
#1   0xf0195024   0xf14b9800   __atomic_add_return + 0x18  (via 
zone_page_state_add() include/linux/vmstat.h: 145)
#2   0xf007dfa8   0xf14b9860   __mod_zone_page_state + 0x64   
(mm/vmstat.c: 165)
#3   0xf006f9cc   0xf14b98c0   free_pcppages_bulk + 0x340  
(mm/page_alloc.c: 586)
#4   0xf006fb58   0xf14b9938   drain_local_pages + 0x64
#5   0xf001cb00   0xf14b9998   leon_cross_call_irq + 0x3c

/*
 * Spill all the per-cpu pages from all CPUs back into the buddy allocator
 */
void drain_all_pages(void)
{
    on_each_cpu(drain_local_pages, NULL, 1);
}


Best Regards,

Daniel Hellstrom
Aeroflex Gaisler
