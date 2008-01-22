From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 22 Jan 2008 05:14:01 +0000
Subject: Re: [PATCH] sparc64: fix of section mismatch warnings
Message-Id: <20080122051401.GB3992@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080121202210.GA552@uranus.ravnborg.org>
In-Reply-To: <20080121202210.GA552@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jan 21, 2008 at 05:24:58PM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Mon, 21 Jan 2008 21:22:10 +0100
> 
> > Fix following Section mismatch warning in sparc64:
> > 
> > WARNING: arch/sparc64/kernel/built-in.o(.text+0x13dec): Section mismatch: reference to .devinit.text:pci_scan_one_pbm (between 'psycho_scan_bus' and 'psycho_pbm_init')
> > WARNING: arch/sparc64/kernel/built-in.o(.text+0x14b58): Section mismatch: reference to .devinit.text:pci_scan_one_pbm (between 'sabre_scan_bus' and 'sabre_init')
> > WARNING: arch/sparc64/kernel/built-in.o(.text+0x15ea4): Section mismatch: reference to .devinit.text:pci_scan_one_pbm (between 'schizo_scan_bus' and 'schizo_pbm_init')
> > WARNING: arch/sparc64/kernel/built-in.o(.text+0x17780): Section mismatch: reference to .devinit.text:pci_scan_one_pbm (between 'pci_sun4v_scan_bus' and 'pci_sun4v_get_head')
> > WARNING: arch/sparc64/kernel/built-in.o(.text+0x17d5c): Section mismatch: reference to .devinit.text:pci_scan_one_pbm (between 'pci_fire_scan_bus' and 'pci_fire_get_head')
> > WARNING: arch/sparc64/kernel/built-in.o(.text+0x23860): Section mismatch: reference to .devinit.text:vio_dev_release (between 'vio_create_one' and 'vio_add')
> > WARNING: arch/sparc64/kernel/built-in.o(.text+0x23868): Section mismatch: reference to .devinit.text:vio_dev_release (between 'vio_create_one' and 'vio_add')
> > 
> > The pci_* were all missing __init annotations.
> > For the vio.c case it was a function with a wrong annotation which was removed.
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Applied, but let's discuss this ;-)
> 
> > It all looked trivial to me but plase review.
> > Note: The warnigns were generated with a more recent modpost than
> > in mainline / kbuild.git.
> > I had -fno-inline-functions-called-once added to gcc when seeing these.
> 
> pci_scan_one_pbm() is __devinit
> 
> The implementations ({psycho,sabre,schizo,pci_sun4v,pci_fire}_scan_bus())
> are now marked __init.
> 
> Furthermore, pointers to those functions get assigned to
> pci_pbm_info->scan_bus() which the modpost resolver has no way to
> follow calls of.

In eg. psycho_pbm_init() we have:
	pbm->scan_bus = psycho_scan_bus;

I found only one usage of pbm->scan_bus:
static void __init pci_scan_each_controller_bus(void)
{
	struct pci_pbm_info *pbm;

	for (pbm = pci_pbm_root; pbm; pbm = pbm->next)
		pbm->scan_bus(pbm);
}

This function is marked __init so it looks OK from this suage to
annotate the functions __init.


We have:
void __init psycho_init(struct device_node *dp, char *model_name)
	=> psycho_pbm_init()
		=> psycho_scan_bus()
			=> pci_scan_one_pbm()

And I did not find any usage of pci_scan_one_pbm()
from __devinit so I think we should annotate
pci_scan_one_pbm() with __init too to be consistent.
(That is with the patch applied obviously)


and psycho_init is used in:
pci_controller_table[] __initdata = {
	{ "SUNW,sabre", sabre_init },
	{ "pci108e,a000", sabre_init },
	{ "pci108e,a001", sabre_init },
	{ "SUNW,psycho", psycho_init },
	{ "pci108e,8000", psycho_init },

So again a reference from __init (this time data).

So it all looks OK to me.

	Sam


