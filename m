From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Thu, 22 Nov 2007 21:03:39 +0000
Subject: Re: IRQ handler type mismatch for IRQ3
Message-Id: <20071122210339.GA21938@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0711212349510.15559@fbirervta.pbzchgretzou.qr>
In-Reply-To: <Pine.LNX.4.64.0711212349510.15559@fbirervta.pbzchgretzou.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Seems this IRQ mismatch is intentional. You can avoid the messages by
turning off CONFIG_DEBUG_SHIRQ.
From psycho_register_error_handlers():

        /* We really mean to ignore the return result here.  Two
         * PCI controller share the same interrupt numbers and
         * drive the same front-end hardware.  Whichever of the
         * two get in here first will register the IRQ handler
         * the second will just error out since we do not pass in
         * IRQF_SHARED.
         */
        err = request_irq(op->irqs[1], psycho_ue_intr, 0,
                          "PSYCHO_UE", pbm);
        err = request_irq(op->irqs[2], psycho_ce_intr, 0,
                          "PSYCHO_CE", pbm);

Cheers,
Martin

On Wed, Nov 21, 2007 at 11:54:11PM +0100, Jan Engelhardt wrote:
> Hi,
> 
> 
> booting the current aurora CD1 
> (/aurora/corona/sparc/iso/AL-2.99-sparc-disc1.iso) with the 
> 2.6.23.1-26.5.al3 kernel prints out some call traces during boot:
> 
> IRQ handler type mismatch for IRQ 2
> current handler: PSYCHO_UE
> Call Trace:
>  [0000000000489914] request_irq+0xd8/0x104
>  [000000000043d700] psycho_scan_bus+0x8c/0x140
>  [00000000007aa948] pcibios_init+0x38/0x64
>  [00000000007a2268] kernel_init+0xd4/0x274
>  [0000000000427838] kernel_thread+0x38/0x48
>  [000000000067cfc8] rest_init+0x18/0x5c
> IRQ handler type mismatch for IRQ 3
> current handler: PSYCHO_CE
> Call Trace:
>  [0000000000489914] request_irq+0xd8/0x104
>  [000000000043d720] psycho_scan_bus+0xac/0x140
>  [00000000007aa948] pcibios_init+0x38/0x64
>  [00000000007a2268] kernel_init+0xd4/0x274
>  [0000000000427838] kernel_thread+0x38/0x48
>  [000000000067cfc8] rest_init+0x18/0x5c
> 
> sh-3.1# cat /proc/interrupts 
>            CPU0       
>   0:      47352     <NULL>  timer
>   1:          0      sun4u  PSYCHO_PCIERR
>   2:          0      sun4u  PSYCHO_UE
>   3:          0      sun4u  PSYCHO_CE
> 
> This trace was not present during 2.6.21. The boot proceeds 
> fine though, but since call traces are always reminiscient of WARN_ON, 
> BUG_ON and dump_stack, I though I'd ask.
> 
> 
> 
> sh-3.1# lspci
> 0000:00:00.0 Host bridge: Sun Microsystems Computer Corp. Psycho PCI Bus Module
> 0000:00:01.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
> 0000:00:01.1 Ethernet controller: Sun Microsystems Computer Corp. Happy Meal (rev 01)
> 0000:00:02.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
> 0000:00:03.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 14)
> 0000:00:03.1 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 14)
> 0000:00:05.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
> 0001:00:00.0 Host bridge: Sun Microsystems Computer Corp. Psycho PCI Bus Module
