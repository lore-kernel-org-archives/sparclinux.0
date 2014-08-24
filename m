From: Allen Pais <allen.pais@oracle.com>
Date: Sun, 24 Aug 2014 06:31:29 +0000
Subject: Re: [PATCH v1 1/3] sparc64: correctly recognise M7 cpu type
Message-Id: <53F983F1.70804@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1408686773-3044-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1408686773-3044-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David,
> 
>> @@ -414,6 +414,8 @@ sun4v_chip_type:
>>  	cmp	%g2, 'T'
>>  	be,pt	%xcc, 70f
>>  	 cmp	%g2, 'M'
>> +	be,pt	%xcc, 71f
>> +	 nop
>>  	bne,pn	%xcc, 49f
>>  	 nop
> 
> This code block is supposed to fallthrough when %g2 is 'M' so that
> we accept all of "{T,M}345..." but your change is breaking that
> such that we will now only accept "M" as a prefix for "7".
> 
> That's a regression.
> 
> All you have to do is add the new comparison against '7' in the
> "70:" label code block, and you're done.
> 

 When we are on this topic, here's a patch that attempts to simplify 
cpu detection. 

Here's a quick diff.

diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index 5c51258..c06e27e 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -460,6 +460,36 @@ static int __init cpu_type_probe(void)
 #endif /* CONFIG_SPARC32 */
 
 #ifdef CONFIG_SPARC64
+
+static struct sun4v_chip_names {
+       const char *name;
+       unsigned long chip;
+} sun4v_names[] __initdata = {
+       {"SUNW,UltraSPARC-T1", SUN4V_CHIP_NIAGARA1},
+       {"SUNW,UltraSPARC-T2", SUN4V_CHIP_NIAGARA2},
+       {"SUNW,UltraSPARC-T2+", SUN4V_CHIP_NIAGARA2},
+       {"SUNW,UltraSPARC-T3", SUN4V_CHIP_NIAGARA3},
+       {"SPARC-T4", SUN4V_CHIP_NIAGARA4},
+       {"SPARC64-X", SUN4V_CHIP_SPARC64X},
+       {"SPARC-T5", SUN4V_CHIP_NIAGARA5},
+       {"SPARC-M7", SUN4V_CHIP_SPARC_M7},
+};
+
+unsigned long __init determine_sun4v_cpu(void)
+{
+       unsigned int nr_chips = ARRAY_SIZE(sun4v_names);
+       unsigned long chip_type = SUN4V_CHIP_UNKNOWN;
+       unsigned int i;
+
+       for (i = 0; i < nr_chips; i++) {
+               if (strcmp(prom_cpu_compatible, sun4v_names[i].name) = 0) {
+                       chip_type = sun4v_names[i].chip;
+                       break;
+               }
+       }
+       return chip_type;
+}
+
 static void __init sun4v_cpu_probe(void)
 {
        switch (sun4v_chip_type) {
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 26b706a..be49bef 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -130,12 +130,6 @@ prom_set_trap_table_name:
        .asciz  "SUNW,set-trap-table"
 prom_sun4v_name:
        .asciz  "sun4v"
-prom_niagara_prefix:
-       .asciz  "SUNW,UltraSPARC-T"
-prom_sparc_prefix:
-       .asciz  "SPARC-"
-prom_sparc64x_prefix:
-       .asciz  "SPARC64-X"
        .align  4
 prom_root_compatible:
        .skip   64
@@ -376,91 +370,10 @@ sun4v_chip_type:
        call    %l7
         add    %sp, (2047 + 128), %o0          ! argument array
 
+       call    determine_sun4v_cpu
        add     %sp, (192 + 128), %sp
 
-       sethi   %hi(prom_cpu_compatible), %g1
-       or      %g1, %lo(prom_cpu_compatible), %g1
-       sethi   %hi(prom_niagara_prefix), %g7
-       or      %g7, %lo(prom_niagara_prefix), %g7
-       mov     17, %g3
-90:    ldub    [%g7], %g2
-       ldub    [%g1], %g4
-       cmp     %g2, %g4
-       bne,pn  %icc, 89f
-        add    %g7, 1, %g7
-       subcc   %g3, 1, %g3
-       bne,pt  %xcc, 90b
-        add    %g1, 1, %g1
-       ba,pt   %xcc, 91f
-        nop
-
-89:    sethi   %hi(prom_cpu_compatible), %g1
-       or      %g1, %lo(prom_cpu_compatible), %g1
-       sethi   %hi(prom_sparc_prefix), %g7
-       or      %g7, %lo(prom_sparc_prefix), %g7
-       mov     6, %g3
-90:    ldub    [%g7], %g2
-       ldub    [%g1], %g4
-       cmp     %g2, %g4
-       bne,pn  %icc, 4f
-        add    %g7, 1, %g7
-       subcc   %g3, 1, %g3
-       bne,pt  %xcc, 90b
-        add    %g1, 1, %g1
-
-       sethi   %hi(prom_cpu_compatible), %g1
-       or      %g1, %lo(prom_cpu_compatible), %g1
-       ldub    [%g1 + 6], %g2
-       cmp     %g2, 'T'
-       be,pt   %xcc, 70f
-        cmp    %g2, 'M'
-       bne,pn  %xcc, 49f
-        nop
-
-70:    ldub    [%g1 + 7], %g2
-       cmp     %g2, '3'
-       be,pt   %xcc, 5f
-        mov    SUN4V_CHIP_NIAGARA3, %g4
-       cmp     %g2, '4'
-       be,pt   %xcc, 5f
-        mov    SUN4V_CHIP_NIAGARA4, %g4
-       cmp     %g2, '5'
-       be,pt   %xcc, 5f
-        mov    SUN4V_CHIP_NIAGARA5, %g4
-       ba,pt   %xcc, 49f
-        nop
-
-91:    sethi   %hi(prom_cpu_compatible), %g1
-       or      %g1, %lo(prom_cpu_compatible), %g1
-       ldub    [%g1 + 17], %g2
-       cmp     %g2, '1'
-       be,pt   %xcc, 5f
-        mov    SUN4V_CHIP_NIAGARA1, %g4
-       cmp     %g2, '2'
-       be,pt   %xcc, 5f
-        mov    SUN4V_CHIP_NIAGARA2, %g4
-       
-4:
-       /* Athena */
-       sethi   %hi(prom_cpu_compatible), %g1
-       or      %g1, %lo(prom_cpu_compatible), %g1
-       sethi   %hi(prom_sparc64x_prefix), %g7
-       or      %g7, %lo(prom_sparc64x_prefix), %g7
-       mov     9, %g3
-41:    ldub    [%g7], %g2
-       ldub    [%g1], %g4
-       cmp     %g2, %g4
-       bne,pn  %icc, 49f
-       add     %g7, 1, %g7
-       subcc   %g3, 1, %g3
-       bne,pt  %xcc, 41b
-       add     %g1, 1, %g1
-       mov     SUN4V_CHIP_SPARC64X, %g4
-       ba,pt   %xcc, 5f
-       nop
-
-49:
-       mov     SUN4V_CHIP_UNKNOWN, %g4
+       or      %o0, %g0, %g4
 5:     sethi   %hi(sun4v_chip_type), %g2
        or      %g2, %lo(sun4v_chip_type), %g2
        stw     %g4, [%g2]


- Allen

