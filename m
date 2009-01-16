From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 Jan 2009 20:34:19 +0000
Subject: [PATCH] sparc64: fix readout of cpu/fpu type
Message-Id: <20090116203419.GA27053@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Meelis reported that on his box /proc/cpuinfo started
to reported "Unknow CPU" and the same did the boot messages.

It was a stupid bug I introduced when merging
cpu.c for 32 and 64 bit.

The code did an array reference where it had to search
for the right index.

Reported-by: Meelis Roos <mroos@linux.ee>
Tested-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index f0b8255..32d32b4 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -239,14 +239,26 @@ unsigned int fsr_storage;
 
 static void set_cpu_and_fpu(int psr_impl, int psr_vers, int fpu_vers)
 {
+	const struct manufacturer_info *manuf;
+	int i;
+
 	sparc_cpu_type = NULL;
 	sparc_fpu_type = NULL;
-	if (psr_impl < ARRAY_SIZE(manufacturer_info))
+	manuf = NULL;
+
+	for (i = 0; i < ARRAY_SIZE(manufacturer_info); i++)
+	{
+		if (psr_impl = manufacturer_info[i].psr_impl) {
+			manuf = &manufacturer_info[i];
+			break;
+		}
+	}
+	if (manuf != NULL)
 	{
 		const struct cpu_info *cpu;
 		const struct fpu_info *fpu;
 
-		cpu = &manufacturer_info[psr_impl].cpu_info[0];
+		cpu = &manuf->cpu_info[0];
 		while (cpu->psr_vers != -1)
 		{
 			if (cpu->psr_vers = psr_vers) {
@@ -256,7 +268,7 @@ static void set_cpu_and_fpu(int psr_impl, int psr_vers, int fpu_vers)
 			}
 			cpu++;
 		}
-		fpu =  &manufacturer_info[psr_impl].fpu_info[0];
+		fpu =  &manuf->fpu_info[0];
 		while (fpu->fp_vers != -1)
 		{
 			if (fpu->fp_vers = fpu_vers) {
