From: "David S. Miller" <davem@redhat.com>
Date: Thu, 27 May 2004 16:49:06 +0000
Subject: Re: 2.6.6: compile error with spinlock debugging
Message-Id: <20040527094906.22d5e391.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0405121404550.3243-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0405121404550.3243-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 27 May 2004 10:05:20 +0300 (EEST)
Meelis Roos <mroos@linux.ee> wrote:

> > Good catch, fixed in my sources now too.
> 
> Hmm, I still get the following undefined symbols in modules. Did a make
> mrproper and recompiled, still the same. Config is below.

Oh yes, have to export the thing to modules too of course :-)

=== arch/sparc64/kernel/sparc64_ksyms.c 1.67 vs edited ==--- 1.67/arch/sparc64/kernel/sparc64_ksyms.c	2004-05-25 22:01:28 -07:00
+++ edited/arch/sparc64/kernel/sparc64_ksyms.c	2004-05-27 09:48:55 -07:00
@@ -106,6 +106,7 @@
 extern void _do_read_unlock(rwlock_t *rw, char *str);
 extern void _do_write_lock(rwlock_t *rw, char *str);
 extern void _do_write_unlock(rwlock_t *rw);
+extern int _do_write_trylock(rwlock_t *rw, char *str);
 #endif
 
 extern unsigned long phys_base;
@@ -158,6 +159,7 @@
 EXPORT_SYMBOL(_do_read_unlock);
 EXPORT_SYMBOL(_do_write_lock);
 EXPORT_SYMBOL(_do_write_unlock);
+EXPORT_SYMBOL(_do_write_trylock);
 #endif
 
 EXPORT_SYMBOL(smp_call_function);
