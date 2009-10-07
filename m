From: Michal Simek <monstr@monstr.eu>
Date: Wed, 07 Oct 2009 12:14:18 +0000
Subject: Re: [microblaze-uclinux] Re: [RFC PATCH 05/12] of: add common header
Message-Id: <4ACC861A.7020506@monstr.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010302030702030902050009"
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>	<20091007043052.16890.15975.stgit@angua> <20091007155717.8df62c4d.sfr@canb.auug.org.au>
In-Reply-To: <20091007155717.8df62c4d.sfr@canb.auug.org.au>
To: microblaze-uclinux@itee.uq.edu.au
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu, devicetree-discuss@lists.ozlabs.org

This is a multi-part message in MIME format.
--------------010302030702030902050009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



Stephen Rothwell wrote:
> Hi Grant,
> 
> Just first obvious thing:
> 
> On Tue, 06 Oct 2009 22:30:59 -0600 Grant Likely <grant.likely@secretlab.ca> wrote:
>> diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
>> index 64e8b3a..5f461f0 100644
>> --- a/arch/microblaze/include/asm/prom.h
>> +++ b/arch/microblaze/include/asm/prom.h
>> @@ -17,20 +17,10 @@
>>  #ifndef _ASM_MICROBLAZE_PROM_H
>>  #define _ASM_MICROBLAZE_PROM_H
>>  #ifdef __KERNEL__
>> -
>> -/* Definitions used by the flattened device tree */
>> -#define OF_DT_HEADER		0xd00dfeed /* marker */
> 
> This is used in arch/microblaze/kernel/head.S, but you move its
> definition inside "#ifndef __ASSEMBLY__" below.  You should probably
> replace the include of asm/prom.h in arch/microblaze/kernel/head.S with
> linux/of_fdt.h (assuming that the comment in there is correct).

yes, Stephen is right here. I created one patch (in attachment) which fixed it. I tested your
patches on Microblaze (noMMU and MMU) and I have no problem with compilation and simple boot-up
works for both versions too.

With that my patch: Acked-by: Michal Simek <monstr@monstr.eu>

Thanks,
Michal

P.S.: I have my provider - it block my emails - that's why the patch is in attachment.

> 
>> -#define OF_DT_BEGIN_NODE	0x1 /* Start of node, full name */
>> -#define OF_DT_END_NODE		0x2 /* End node */
>> -#define OF_DT_PROP		0x3 /* Property: name off, size, content */
>> -#define OF_DT_NOP		0x4 /* nop */
>> -#define OF_DT_END		0x9
>> -
>> -#define OF_DT_VERSION		0x10
>> -
>>  #ifndef __ASSEMBLY__
>>  
>>  #include <linux/types.h>
>> +#include <linux/of_fdt.h>
>>  #include <linux/proc_fs.h>
>>  #include <linux/platform_device.h>
>>  #include <asm/irq.h>
> 


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian

--------------010302030702030902050009
Content-Type: text/x-patch;
 name="0001-of-microblaze-of_fdt.h-is-used-in-asm-code.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-of-microblaze-of_fdt.h-is-used-in-asm-code.patch"

From 73b16cccc544fe8410ec8e8e893aa3357093e985 Mon Sep 17 00:00:00 2001
From: Michal Simek <monstr@monstr.eu>
Date: Wed, 7 Oct 2009 14:04:01 +0200
Subject: [PATCH] of: microblaze: of_fdt.h is used in asm code.

Microblaze uses OF_DT_HEADER macro to identify DTB.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/kernel/head.S |    2 +-
 include/linux/of_fdt.h        |    3 +++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/microblaze/kernel/head.S b/arch/microblaze/kernel/head.S
index 697ce30..3091619 100644
--- a/arch/microblaze/kernel/head.S
+++ b/arch/microblaze/kernel/head.S
@@ -31,7 +31,7 @@
 #include <linux/linkage.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
-#include <asm/prom.h>		/* for OF_DT_HEADER */
+#include <linux/of_fdt.h>		/* for OF_DT_HEADER */
 
 #ifdef CONFIG_MMU
 #include <asm/setup.h> /* COMMAND_LINE_SIZE */
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index b41bd18..44fecfa 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -30,6 +30,7 @@
 
 #define OF_DT_VERSION		0x10
 
+#ifndef __ASSEMBLY__
 /*
  * This is what gets passed to the kernel by prom_init or kexec
  *
@@ -84,4 +85,6 @@ extern int prom_remove_property(struct device_node *np, struct property *prop);
 extern int prom_update_property(struct device_node *np,
 				struct property *newprop,
 				struct property *oldprop);
+#endif /* __ASSEMBLY__ */
+
 #endif /* _LINUX_OF_FDT_H */
-- 
1.5.5.1



--------------010302030702030902050009--
