From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 23 Mar 2005 21:41:59 +0000
Subject: Re: sparc32: module with unresolved symbol causes oops in 2.6.12-rc1
Message-Id: <20050323214159.GA21150@mars.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0503231549330.5000@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0503231549330.5000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Mar 23, 2005 at 10:17:48AM -0800, David S. Miller wrote:
> On Wed, 23 Mar 2005 15:53:26 +0200 (EET)
> Meelis Roos <mroos@linux.ee> wrote:
> 
> > floppy module in 2.6.12-rc1 has an unresolved symbol floppy_hardint.
> 
> Yes, this is known not to work.  The floppy driver can only
> work non-modular on sparc systems.
Thought it should be easy to fix. So moved code from entry.S and irq.c
to seprate files.
sparc_floppy_irq uses all sort of stuff,
and the hardint routing also has some not-so-nice dependencies.

I stopped when the build told me:

  Building modules, stage 2.
  MODPOST
*** Warning: "irq_exit" [drivers/block/floppy.ko] undefined!
*** Warning: "trap_setup" [drivers/block/floppy.ko] undefined!
*** Warning: "___f_enable_pil_irq" [drivers/block/floppy.ko] undefined!
*** Warning: "PSR_ET" [drivers/block/floppy.ko] undefined!
*** Warning: "PSR_PIL" [drivers/block/floppy.ko] undefined!
*** Warning: "ret_trap_entry" [drivers/block/floppy.ko] undefined!
*** Warning: "STACKFRAME_SZ" [drivers/block/floppy.ko] undefined!
*** Warning: "auxio_register" [drivers/block/floppy.ko] undefined!
*** Warning: "___f_disable_pil_irq" [drivers/block/floppy.ko] undefined!

:-(
	Sam
