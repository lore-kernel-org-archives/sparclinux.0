From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 08 Mar 2006 23:49:47 +0000
Subject: Re: Best bet for SPARC SMP and Sunfire V240
Message-Id: <20060308.154947.101748773.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
In-Reply-To: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josh Grebe <josh@brokedown.net>
Date: Wed, 08 Mar 2006 16:33:52 -0600

> David S. Miller wrote:
> > 
> > Josh please give this a test as soon as you can, thanks a lot:
> 
> Hi Dave,
> 
> Different, but still a crash. Here is the first ERROR per cpu.

This fix works for me on SB2500, where I could reproduce your
problem.  Let me know how it goes.  Stupid 32-bit truncation
bug :(

--- a/arch/sparc64/mm/init.c.~3~	2006-03-08 14:07:25.000000000 -0800
+++ b/arch/sparc64/mm/init.c	2006-03-08 15:48:25.000000000 -0800
@@ -184,8 +184,8 @@
 }
 
 #define PG_dcache_dirty		PG_arch_1
-#define PG_dcache_cpu_shift	24
-#define PG_dcache_cpu_mask	(256 - 1)
+#define PG_dcache_cpu_shift	24UL
+#define PG_dcache_cpu_mask	(256UL - 1UL)
 
 #if NR_CPUS > 256
 #error D-cache dirty tracking and thread_info->cpu need fixing for > 256 cpus
