From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 26 Dec 2011 23:47:16 +0000
Subject: atomic64 support on sparc32?
Message-Id: <20111226234716.GA10809@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

While trying to see how bad a "allyesconfig" looked for sparc32
I noticed a lot of build errors were related to missing
definition of atomic64.

A few samples:
kernel/trace/trace_clock.c:117:19: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'trace_counter'
kernel/trace/trace_clock.c: In function 'trace_clock_counter':
kernel/trace/trace_clock.c:126:2: error: implicit declaration of function 'atomic64_add_return'


In file included from net/mac80211/ieee80211_i.h:30:0,
                 from net/mac80211/main.c:27:
net/mac80211/key.h:88:4: error: expected specifier-qualifier-list before 'atomic64_t'
net/mac80211/key.h:100:4: error: expected specifier-qualifier-list before 'atomic64_t'
make[3]: *** [net/mac80211/main.o] Error 1


In file included from net/mac80211/ieee80211_i.h:30:0,
                 from net/mac80211/chan.c:6:
net/mac80211/key.h:88:4: error: expected specifier-qualifier-list before 'atomic64_t'
net/mac80211/key.h:100:4: error: expected specifier-qualifier-list before 'atomic64_t'


To add generic support for atomic64_t looks to be trivial.
But do we want to add this - when it is not really required?

We could of course hide it behind a 
CONFIG_SPARC32_ATOMIC64 option..

I do not have the footprint numbers yet, will post them in ~24 hours.

	Sam

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index f92602e..27060b2 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -31,6 +31,7 @@ config SPARC
 
 config SPARC32
 	def_bool !64BIT
+	select GENERIC_ATOMIC64
 
 config SPARC64
 	def_bool 64BIT
diff --git a/arch/sparc/include/asm/atomic_32.h b/arch/sparc/include/asm/atomic_32.h
index 03fd0c5..9dd0a76 100644
--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -13,6 +13,8 @@
 
 #include <linux/types.h>
 
+#include <asm-generic/atomic64.h>
+
 #include <asm/system.h>
 
 #define ATOMIC_INIT(i)  { (i) }
