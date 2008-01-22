From: David Miller <davem@davemloft.net>
Date: Tue, 22 Jan 2008 01:24:58 +0000
Subject: Re: [PATCH] sparc64: fix of section mismatch warnings
Message-Id: <20080121.172458.192563233.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080121202210.GA552@uranus.ravnborg.org>
In-Reply-To: <20080121202210.GA552@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Jan 2008 21:22:10 +0100

> Fix following Section mismatch warning in sparc64:
> 
> WARNING: arch/sparc64/kernel/built-in.o(.text+0x13dec): Section mismatch: reference to .devinit.text:pci_scan_one_pbm (between 'psycho_scan_bus' and 'psycho_pbm_init')
> WARNING: arch/sparc64/kernel/built-in.o(.text+0x14b58): Section mismatch: reference to .devinit.text:pci_scan_one_pbm (between 'sabre_scan_bus' and 'sabre_init')
> WARNING: arch/sparc64/kernel/built-in.o(.text+0x15ea4): Section mismatch: reference to .devinit.text:pci_scan_one_pbm (between 'schizo_scan_bus' and 'schizo_pbm_init')
> WARNING: arch/sparc64/kernel/built-in.o(.text+0x17780): Section mismatch: reference to .devinit.text:pci_scan_one_pbm (between 'pci_sun4v_scan_bus' and 'pci_sun4v_get_head')
> WARNING: arch/sparc64/kernel/built-in.o(.text+0x17d5c): Section mismatch: reference to .devinit.text:pci_scan_one_pbm (between 'pci_fire_scan_bus' and 'pci_fire_get_head')
> WARNING: arch/sparc64/kernel/built-in.o(.text+0x23860): Section mismatch: reference to .devinit.text:vio_dev_release (between 'vio_create_one' and 'vio_add')
> WARNING: arch/sparc64/kernel/built-in.o(.text+0x23868): Section mismatch: reference to .devinit.text:vio_dev_release (between 'vio_create_one' and 'vio_add')
> 
> The pci_* were all missing __init annotations.
> For the vio.c case it was a function with a wrong annotation which was removed.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied, but let's discuss this ;-)

> It all looked trivial to me but plase review.
> Note: The warnigns were generated with a more recent modpost than
> in mainline / kbuild.git.
> I had -fno-inline-functions-called-once added to gcc when seeing these.

pci_scan_one_pbm() is __devinit

The implementations ({psycho,sabre,schizo,pci_sun4v,pci_fire}_scan_bus())
are now marked __init.

Furthermore, pointers to those functions get assigned to
pci_pbm_info->scan_bus() which the modpost resolver has no way to
follow calls of.
