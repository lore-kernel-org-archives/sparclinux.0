From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 17 Feb 2011 22:17:40 +0000
Subject: Re: How do we allocate virtual floppy irq on sparc64
Message-Id: <20110217221740.GA25809@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110217205747.GA25027@merkur.ravnborg.org>
In-Reply-To: <20110217205747.GA25027@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 
> So I will look up "SUNW,fdtwo" + "fd" to find the platform_device
> for floppy.
> And in that platform_device I can find the already allocated irq.

Looks like this in patch format.
Not tested yet as I still need to adapt irq_32.c...

	Sam

--- a/arch/sparc/include/asm/floppy_32.h
+++ b/arch/sparc/include/asm/floppy_32.h
@@ -303,6 +303,8 @@ static struct linux_prom_registers fd_regs[2];

 static int sun_floppy_init(void)
 {
+       struct platform_device *op;
+       struct device_node *dp;
        char state[128];
        phandle tnode, fd_node;
        int num_regs;
@@ -310,7 +312,6 @@ static int sun_floppy_init(void)

        use_virtual_dma = 1;

-       FLOPPY_IRQ = 11;
        /* Forget it if we aren't on a machine that could possibly
         * ever have a floppy drive.
         */
@@ -349,6 +350,26 @@ static int sun_floppy_init(void)
        sun_fdc = (struct sun_flpy_controller *)
            of_ioremap(&r, 0, fd_regs[0].reg_size, "floppy");

+       /*
+        * Look up irq in platform_device.
+        * We try "SUNW,fdtwo" and "fd"
+        */
+       for_each_node_by_name(dp, "SUNW,fdtwo") {
+               op = of_find_device_by_node(dp);
+               if (op)
+                       break;
+       }
+       if (!op) {
+               for_each_node_by_name(dp, "fd") {
+                       op = of_find_device_by_node(dp);
+                       if (op)
+                               break;
+               }
+       }
+       if (!op)
+               goto no_sun_fdc;
+
+       FLOPPY_IRQ = op->archdata.irqs[0];
+
        /* Last minute sanity check... */
        if(sun_fdc->status_82072 = 0xff) {
                sun_fdc = NULL;

