From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 Jan 2009 18:08:31 +0000
Subject: Re: Unknown CPU in 2.6.29-rc1
Message-Id: <20090116180831.GA25995@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0901161249030.2120@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0901161249030.2120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jan 16, 2009 at 12:58:32PM +0200, Meelis Roos wrote:
> After Sam's insw/... fix, todays 2.6.29-rc1+git boots up and seems fo 
> work on E3500 with 2 USII-400's. However, the CPU has suddenly became 
> unknown (it was known in 2.6.27):
> 
> [  136.434591] CPU: Unknown chip, impl[0x17] vers[0x11]
> [  136.434649] FPU: Unknown chip, impl[0x17] vers[0x11]
> [  136.436067] fhc: Board #1, Version[1] PartID[fa0] Manuf[3e] (Central)
> [  136.436823] fhc: Board #3, Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
> 
> Btw, these fhc messages appear later in boot process than before. 
> Before the boards were detected just after 'Booting Linux':
> Booting Linux...
> CENTRAL: Detected 5 slot Enterprise system. cfreg[68] cver[78]
> FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
> FHC(board 3): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
> FHC(board 1): Version[1] PartID[fa0] Manuf[3e]
> FHC(board 7): Version[1] PartID[fa0] Manuf[3e]
> 
> Now they are after 'Brought up 2 CPUs' together with unknown CPU 
> messages.

Can you thr if the following fix the cpu problem.

	Sam

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
