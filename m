From: Allen <allen.pais@oracle.com>
Date: Fri, 21 Jul 2017 09:33:59 +0000
Subject: Re: [PATCH 1/3] sparc64: recognize and support sparc M8 cpu type
Message-Id: <5971C7B7.3070501@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1500536437-14589-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1500536437-14589-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hi Sam,

>> +++ b/arch/sparc/kernel/head_64.S
>> @@ -439,6 +439,9 @@ EXPORT_SYMBOL(sun4v_chip_type)
>>   	cmp	%g2, '7'
>>   	be,pt	%xcc, 5f
>>   	 mov	SUN4V_CHIP_SPARC_M7, %g4
>> +	cmp	%g2, '8'
>> +	be,pt	%xcc, 5f
>> +	 mov	SUN4V_CHIP_SPARC_M8, %g4
>
> Could we use this opportunity to create properly named
> constants for '7', '8', 'N' etc, rather than harcoding these
> in some assembler files.
> (Obviously in a separate patch).

Would this work?

diff --git a/arch/sparc/include/asm/spitfire.h 
b/arch/sparc/include/asm/spitfire.h
index ba3a655..c23b24e 100644
--- a/arch/sparc/include/asm/spitfire.h
+++ b/arch/sparc/include/asm/spitfire.h
@@ -52,6 +52,17 @@
  #define SUN4V_CHIP_SPARC_SN    0x8b
  #define SUN4V_CHIP_UNKNOWN     0xff

+/* CPU Constants */
+#define NIAGARA1               1
+#define NIAGARA2               2
+#define NIAGARA3               3
+#define NIAGARA4               4
+#define NIAGARA5               5
+#define M6                     6
+#define M7                     7
+#define M8                     8
+#define SONOMA1                        ('N')
+
  #ifndef __ASSEMBLY__

  enum ultra_tlb_layout {
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index afcd4ca..46c12d6 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -424,25 +424,25 @@ EXPORT_SYMBOL(sun4v_chip_type)
          nop

  70:    ldub    [%g1 + 7], %g2
-       cmp     %g2, '3'
+       cmp     %g2, NIAGARA3
         be,pt   %xcc, 5f
          mov    SUN4V_CHIP_NIAGARA3, %g4
-       cmp     %g2, '4'
+       cmp     %g2, NIAGARA4
         be,pt   %xcc, 5f
          mov    SUN4V_CHIP_NIAGARA4, %g4
-       cmp     %g2, '5'
+       cmp     %g2, NIAGARA5
         be,pt   %xcc, 5f
          mov    SUN4V_CHIP_NIAGARA5, %g4
-       cmp     %g2, '6'
+       cmp     %g2, M6
         be,pt   %xcc, 5f
          mov    SUN4V_CHIP_SPARC_M6, %g4
-       cmp     %g2, '7'
+       cmp     %g2, M7
         be,pt   %xcc, 5f
          mov    SUN4V_CHIP_SPARC_M7, %g4
-       cmp     %g2, '8'
+       cmp     %g2, M8
         be,pt   %xcc, 5f
          mov    SUN4V_CHIP_SPARC_M8, %g4
-       cmp     %g2, 'N'
+       cmp     %g2, SONOMA1
         be,pt   %xcc, 5f
          mov    SUN4V_CHIP_SPARC_SN, %g4
         ba,pt   %xcc, 49f
@@ -451,10 +451,10 @@ EXPORT_SYMBOL(sun4v_chip_type)
  91:    sethi   %hi(prom_cpu_compatible), %g1
         or      %g1, %lo(prom_cpu_compatible), %g1
         ldub    [%g1 + 17], %g2
-       cmp     %g2, '1'
+       cmp     %g2, NIAGARA1
         be,pt   %xcc, 5f
          mov    SUN4V_CHIP_NIAGARA1, %g4
-       cmp     %g2, '2'
+       cmp     %g2, NIAGARA2
         be,pt   %xcc, 5f
          mov    SUN4V_CHIP_NIAGARA2, %g4

- Allen
