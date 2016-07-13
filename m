From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 13 Jul 2016 13:38:16 +0000
Subject: [bug report] SPARC/LEON: added support for selecting Timer Core and Timer within core
Message-Id: <20160713133816.GA8019@mwanda>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello Daniel Hellstrom,

The patch 2791c1a43900: "SPARC/LEON: added support for selecting
Timer Core and Timer within core" from Jan 4, 2011, leads to the
following static checker warning:

	arch/sparc/kernel/leon_kernel.c:368 leon_init_timers()
	warn: continue to end of do { ... } while(0) loop.

arch/sparc/kernel/leon_kernel.c
   350          /* Find GPTIMER Timer Registers base address otherwise bail out. */
   351          nnp = rootnp;

I think the intent was to jump back to here.

   352          do {
   353                  np = of_find_node_by_name(nnp, "GAISLER_GPTIMER");
   354                  if (!np) {
   355                          np = of_find_node_by_name(nnp, "01_011");
   356                          if (!np)
   357                                  goto bad;
   358                  }
   359  
   360                  ampopts = 0;
   361                  pp = of_find_property(np, "ampopts", &len);
   362                  if (pp) {
   363                          ampopts = *(int *)pp->value;
   364                          if (ampopts = 0) {
   365                                  /* Skip this instance, resource already
   366                                   * allocated by other OS */
   367                                  nnp = np;
   368                                  continue;

But the continue actually jumps down to the end of the loop like a break
would.

   369                          }
   370                  }
   371  
   372                  /* Select Timer-Instance on Timer Core. Default is zero */
   373                  leon3_gptimer_idx = ampopts & 0x7;
   374  
   375                  pp = of_find_property(np, "reg", &len);
   376                  if (pp)
   377                          leon3_gptimer_regs = *(struct leon3_gptimer_regs_map **)
   378                                                  pp->value;
   379                  pp = of_find_property(np, "interrupts", &len);
   380                  if (pp)
   381                          leon3_gptimer_irq = *(unsigned int *)pp->value;
   382          } while (0);
   383  

We jump to here instead.  Either way, it would probably be best to get
rid of the loop entirely and use a label and a goto.

   384          if (!(leon3_gptimer_regs && leon3_irqctrl_regs && leon3_gptimer_irq))
   385                  goto bad;

regards,
dan carpenter
