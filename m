From: Allen <allen.pais@oracle.com>
Date: Sat, 22 Jul 2017 08:56:41 +0000
Subject: Re: [PATCH 1/3] sparc64: recognize and support sparc M8 cpu type
Message-Id: <59731339.3050906@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1500536437-14589-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1500536437-14589-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sam/David,
>
> It is way better than the hardcoded values.
> If the vales have any sort of name in the sparc specs
> the values shall be prefixed with this.
> Otherwise something like
> CPU_ID_xxx
>
> And maybe add an intro comment like this:
> /* following CPU_ID_xxx constants are used to identify the
>   * CPU type in the setup phase (see xxx.S)
> */
>

Here's a quick diff. Let me know if this looks good to you guys. I'll 
send out the patch. I have tested this on a T4.

diff --git a/arch/sparc/include/asm/spitfire.h 
b/arch/sparc/include/asm/spitfire.h
index 1d8321c..1b1286d 100644
--- a/arch/sparc/include/asm/spitfire.h
+++ b/arch/sparc/include/asm/spitfire.h
@@ -47,10 +47,26 @@
+/*
+ * The following CPU_ID_xxx constants are used
+ * to identify the CPU type in the setup phase
+ * (see head_64.S)
+ */
+#define CPU_ID_NIAGARA1                ('1')
+#define CPU_ID_NIAGARA2                ('2')
+#define CPU_ID_NIAGARA3                ('3')
+#define CPU_ID_NIAGARA4                ('4')
+#define CPU_ID_NIAGARA5                ('5')
+#define CPU_ID_M6              ('6')
+#define CPU_ID_M7              ('7')
+#define CPU_ID_M8              ('8')
+#define CPU_ID_SONOMA1         ('N')
+
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 41a4073..78e0211 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -424,22 +424,25 @@ EXPORT_SYMBOL(sun4v_chip_type)
          nop

  70:    ldub    [%g1 + 7], %g2
-       cmp     %g2, '3'
+       cmp     %g2, CPU_ID_NIAGARA3
         be,pt   %xcc, 5f
          mov    SUN4V_CHIP_NIAGARA3, %g4
-       cmp     %g2, '4'
+       cmp     %g2, CPU_ID_NIAGARA4
         be,pt   %xcc, 5f
          mov    SUN4V_CHIP_NIAGARA4, %g4
-       cmp     %g2, '5'
+       cmp     %g2, CPU_ID_NIAGARA5
         be,pt   %xcc, 5f
          mov    SUN4V_CHIP_NIAGARA5, %g4
-       cmp     %g2, '6'
+       cmp     %g2, CPU_ID_M6
         be,pt   %xcc, 5f
          mov    SUN4V_CHIP_SPARC_M6, %g4
-       cmp     %g2, '7'
+       cmp     %g2, CPU_ID_M7
         be,pt   %xcc, 5f
          mov    SUN4V_CHIP_SPARC_M7, %g4
-       cmp     %g2, '8'
+       cmp     %g2, CPU_ID_M8
         be,pt   %xcc, 5f
          mov    SUN4V_CHIP_SPARC_M8, %g4
-	cmp %g2, 'N'
+       cmp     %g2, CPU_ID_SONOMA1
         be,pt   %xcc, 5f
          mov    SUN4V_CHIP_SPARC_SN, %g4
         ba,pt   %xcc, 49f
