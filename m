From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 20 Apr 2011 20:08:59 +0000
Subject: [PATCH 1/3] sparc32: fix section mismatch warnings in apc, pmc and time_32
Message-Id: <1303330141-31123-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

In all cases there were a struct of_device_id variable defined __initdata.
But it was referenced from struct platform_driver.of_match_table
which is not guaranteed to be used during init only.

So drop the __initdata annotation.

This fixes following warnings:

WARNING: arch/sparc/kernel/built-in.o(.data+0x810): Section mismatch in reference from the variable clock_driver to the variable .init.data:clock_match
The variable clock_driver references
the variable __initdata clock_match
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

WARNING: arch/sparc/kernel/built-in.o(.data+0xcec): Section mismatch in reference from the variable apc_driver to the variable .init.data:apc_match
The variable apc_driver references
the variable __initdata apc_match
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

WARNING: arch/sparc/kernel/built-in.o(.data+0xd60): Section mismatch in reference from the variable pmc_driver to the variable .init.data:pmc_match
The variable pmc_driver references
the variable __initdata pmc_match
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/apc.c     |    2 +-
 arch/sparc/kernel/pmc.c     |    2 +-
 arch/sparc/kernel/time_32.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/apc.c b/arch/sparc/kernel/apc.c
index f679c57..1e34f29 100644
--- a/arch/sparc/kernel/apc.c
+++ b/arch/sparc/kernel/apc.c
@@ -165,7 +165,7 @@ static int __devinit apc_probe(struct platform_device *op)
 	return 0;
 }
 
-static struct of_device_id __initdata apc_match[] = {
+static struct of_device_id apc_match[] = {
 	{
 		.name = APC_OBPNAME,
 	},
diff --git a/arch/sparc/kernel/pmc.c b/arch/sparc/kernel/pmc.c
index 93d7b44..6a585d3 100644
--- a/arch/sparc/kernel/pmc.c
+++ b/arch/sparc/kernel/pmc.c
@@ -69,7 +69,7 @@ static int __devinit pmc_probe(struct platform_device *op)
 	return 0;
 }
 
-static struct of_device_id __initdata pmc_match[] = {
+static struct of_device_id pmc_match[] = {
 	{
 		.name = PMC_OBPNAME,
 	},
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index b618403..1060e06 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -168,7 +168,7 @@ static int __devinit clock_probe(struct platform_device *op)
 	return 0;
 }
 
-static struct of_device_id __initdata clock_match[] = {
+static struct of_device_id clock_match[] = {
 	{
 		.name = "eeprom",
 	},
-- 
1.6.0.6

