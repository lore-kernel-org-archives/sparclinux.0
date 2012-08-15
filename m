From: David Miller <davem@davemloft.net>
Date: Wed, 15 Aug 2012 08:14:16 +0000
Subject: [PATCH] silo: Don't touch %tick_cmpr on sun4v cpus.
Message-Id: <20120815.011416.353619816610212386.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This generates an illegal instruction exception.

This has a long history.  For the first sun4v port of SILO in commit
494770a17eea7192d3242051e76f4da6d838e3a1 ("SILO Niagara/SUN4V
support") this code was removed entirely.

But later this was found to regress older UltraSPARC boxes, so we put
it back in commit bd708e35bdcd8e92cb7c65368f2a356982df7cd8 ("Fix
Ultra10 SILO timer").  But that was wrong too.

The OBP still owns the trap table when SILO runs and it uses the
%tick_cmpr generated interrupt.  This has a bad interraction with how
we use the %tick register in SILO.

SILO first reads the %tick register and remembers this value as the
time base.

Later, we read %tick again, compute the difference, and use this to
calcualte the amount of time elapsed.

OBP's %tick_cmpr interrupt handler is doing something funky, such as
resetting %tick, which makes our timeouts never actually expire.

This issue doesn't exist on sun4v machines, and we absolutely cannot
try to touch the %tick_cmpr register as that generates an illegal
instruction trap on such cpus.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

I just committed this into the SILO git repo.

Debian folks, you really want this propagated into your installer as
soon as possible.  All the install ISOs will crash in SILO on all
sun4v (Niagara) machines unless an explicit SILO boot target is given
on the boot command line.  I used "boot cdrom install" to get around
this.

It triggers any time the timer mechanism is enabled ("timeout=foo" is
specified in silo.conf)

 include/silo.h | 1 +
 second/main.c  | 1 +
 second/misc.c  | 4 +++-
 second/timer.c | 2 +-
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/silo.h b/include/silo.h
index fe5adcb..94d6e31 100644
--- a/include/silo.h
+++ b/include/silo.h
@@ -125,6 +125,7 @@ int strtol (const char *, char **, int);
 int decompress (char *, char *, unsigned char (*)(void), void (*)(void));
 /* main.c */
 extern enum arch architecture;
+extern int sun4v_cpu;
 /* timer.c */
 int init_timer ();
 void close_timer ();
diff --git a/second/main.c b/second/main.c
index 182b263..a45807d 100644
--- a/second/main.c
+++ b/second/main.c
@@ -64,6 +64,7 @@ enum {
     CMD_LS
 } load_cmd;
 enum arch architecture;
+int sun4v_cpu;
 static int timer_status = 0;
 static char *initrd_start;
 static int initrd_size;
diff --git a/second/misc.c b/second/misc.c
index 163738e..d6bcdb1 100644
--- a/second/misc.c
+++ b/second/misc.c
@@ -517,8 +517,10 @@ enum arch silo_get_architecture(void)
 	return sun4d;
     case 'e':
 	return sun4e;
-    case 'u':
     case 'v':
+	sun4v_cpu = 1;
+	/* FALLTHRU */
+    case 'u':
 	return sun4u;
     default:
     	for(i = 0; i < NUM_SUN_MACHINES; i++)
diff --git a/second/timer.c b/second/timer.c
index 51e928e..7f03996 100644
--- a/second/timer.c
+++ b/second/timer.c
@@ -156,7 +156,7 @@ static inline int sun4u_init_timer ()
     }
     if (!foundcpu || !clock_frequency)
         clock_frequency = prom_getint(prom_root_node, "clock-frequency") / 100;
-    if (notimer) {
+    if (notimer && !sun4v_cpu) {
         sun4u_notimer = 1;
         __asm__ __volatile__ ("\t"
         	"rd	%%tick_cmpr, %%g1\n\t"
-- 
1.7.11.2

