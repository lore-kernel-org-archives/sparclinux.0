From: "David S. Miller" <davem@redhat.com>
Date: Tue, 25 May 2004 21:00:23 +0000
Subject: Re: 2.6.6: compile error with spinlock debugging
Message-Id: <20040525140023.47e8d8b3.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0405121404550.3243-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0405121404550.3243-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This should fix the problem:

=== arch/sparc64/lib/debuglocks.c 1.6 vs edited ==--- 1.6/arch/sparc64/lib/debuglocks.c	2004-02-24 16:23:11 -08:00
+++ edited/arch/sparc64/lib/debuglocks.c	2004-05-25 13:52:17 -07:00
@@ -299,4 +299,61 @@
 	}
 }
 
+int _do_write_trylock (rwlock_t *rw, char *str)
+{
+	unsigned long caller, val;
+	int stuck = INIT_STUCK;
+	int cpu = smp_processor_id();
+	int shown = 0;
+
+	GET_CALLER(caller);
+
+	/* Try to acuire the write bit.  */
+	__asm__ __volatile__(
+"	mov	1, %%g3\n"
+"	sllx	%%g3, 63, %%g3\n"
+"	ldx	[%0], %%g5\n"
+"	brlz,pn	%%g5, 1f\n"
+"	 or	%%g5, %%g3, %%g7\n"
+"	casx	[%0], %%g5, %%g7\n"
+"	membar	#StoreLoad | #StoreStore\n"
+"	ba,pt	%%xcc, 2f\n"
+"	 sub	%%g5, %%g7, %0\n"
+"1:	mov	1, %0\n"
+"2:"	: "=r" (val)
+	: "0" (&(rw->lock))
+	: "g3", "g5", "g7", "memory");
+
+	if (val)
+		return 0;
+
+	if ((rw->lock & ((1UL<<63)-1UL)) != 0UL) {
+		/* Readers still around, drop the write
+		 * lock, return failure.
+		 */
+		__asm__ __volatile__(
+"		mov	1, %%g3\n"
+"		sllx	%%g3, 63, %%g3\n"
+"1:		ldx	[%0], %%g5\n"
+"		andn	%%g5, %%g3, %%g7\n"
+"		casx	[%0], %%g5, %%g7\n"
+"		cmp	%%g5, %%g7\n"
+"		bne,pn	%%xcc, 1b\n"
+"		 membar	#StoreLoad | #StoreStore"
+		: /* no outputs */
+		: "r" (&(rw->lock))
+		: "g3", "g5", "g7", "cc", "memory");
+
+		return 0;
+	}
+
+	/* We have it, say who we are. */
+	rw->writer_pc = ((unsigned int)caller);
+	rw->writer_cpu = cpu;
+	current->thread.smp_lock_count++;
+	current->thread.smp_lock_pc = ((unsigned int)caller);
+
+	return 1;
+}
+
 #endif /* CONFIG_SMP */
=== include/asm-sparc64/spinlock.h 1.11 vs edited ==--- 1.11/include/asm-sparc64/spinlock.h	2004-05-10 04:25:44 -07:00
+++ edited/include/asm-sparc64/spinlock.h	2004-05-25 13:58:19 -07:00
@@ -144,6 +144,7 @@
 extern void _do_read_unlock(rwlock_t *rw, char *str);
 extern void _do_write_lock(rwlock_t *rw, char *str);
 extern void _do_write_unlock(rwlock_t *rw);
+extern int _do_write_trylock(rwlock_t *rw, char *str);
 
 #define _raw_read_lock(lock) \
 do {	unsigned long flags; \
@@ -172,6 +173,15 @@
 	_do_write_unlock(lock); \
 	local_irq_restore(flags); \
 } while(0)
+
+#define _raw_write_trylock(lock) \
+({	unsigned long flags; \
+	int val; \
+	local_irq_save(flags); \
+	val = _do_write_trylock(lock, "write_trylock"); \
+	local_irq_restore(flags); \
+	val; \
+})
 
 #endif /* CONFIG_DEBUG_SPINLOCK */
 
