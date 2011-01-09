From: David Miller <davem@davemloft.net>
Date: Sun, 09 Jan 2011 23:37:45 +0000
Subject: Re: sparc boot failure due to perf init
Message-Id: <20110109.153745.35032992.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1294431832.2016.457.camel@laptop>
	<1294432055.2016.458.camel@laptop>
	<20110107203119.GA30408@merkur.ravnborg.org>
In-Reply-To: <20110107203119.GA30408@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 7 Jan 2011 21:31:19 +0100

> Then you guys can sort it out and I can test any patches
> you come up with.

Here is the fix I will be pushing to Linus to fix this:

--------------------
sparc64: Fix bootup regression due to perf init ordering.

Commit 004417a6d468e24399e383645c068b498eed84ad
("perf, arch: Cleanup perf-pmu init vs lockup-detector")
move the perf events init to be an early_initcall.

But this won't work properly unless the dependencies for
this code initialize beforehand.

Fix it by making cpu_type_probe and pcr_arch_init be
an early_initcall as well.

Reported-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/cpu.c |    2 +-
 arch/sparc/kernel/pcr.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index e447938..0dc714f 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -375,5 +375,5 @@ static int __init cpu_type_probe(void)
 	return 0;
 }
 
-arch_initcall(cpu_type_probe);
+early_initcall(cpu_type_probe);
 #endif
diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index b87873c..ae96cf5 100644
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -168,4 +168,4 @@ out_unregister:
 	return err;
 }
 
-arch_initcall(pcr_arch_init);
+early_initcall(pcr_arch_init);
-- 
1.7.3.4

