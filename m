From: Konrad Eisele <konrad@gaisler.com>
Date: Fri, 05 Jun 2009 08:39:24 +0000
Subject: Re: LEON SPARC git repository
Message-Id: <4A28D9BC.2030707@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4A27926C.5010501@gaisler.com>
In-Reply-To: <4A27926C.5010501@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Sam Ravnborg wrote:
> On Thu, Jun 04, 2009 at 11:22:52AM +0200, Kristoffer Glembo wrote:
>> Hi,
>>
>> I have created a sparc-leon git repository on kernel.org. Currently the
>> master branch is just a clone of sparc-next. There is a branch named
>> experimental which contains our current patches:
>>
>> http://git.kernel.org/?p=3Dlinux/kernel/git/gaisler/sparc-leon.git;a=3Dl=
og;h=3Dexperimental
>>
>> To start with it would be great to receive feedback on the patches
>> against the SPARC architecture:
>>
>> http://git.kernel.org/?p=3Dlinux/kernel/git/gaisler/sparc-leon.git;a=3Dc=
ommitdiff;h=A45872c4e571b32ccde2acbecd2394b0fa152882
>>
>> Is it preferred that I post the patches directly to the list, instead of
>> a link? The patchset against arch is ~2k lines. The patches against
>> existing files is ~600 lines.
>=20
> I suggest that you start with:
> 1) Initial posting that explains what leon is.

Kristoffer sent a introduction to the mailing list on 06/01/2009. I appended
the mail again at the end of this mail.
Maybe to be added:
The LEON processor was created by Jiri Gaisler who has risen to fame lately=
 by
winning the Open Sparc Community award together with Martin Johansson .
https://sun.systemnews.com/articles/127/4/news/20648
They integrated the SPARC-T1 into the "GRLIB" framework. The sparc-LEON
processor is one part of "GRLIB".
The idea that might catch you is: when running linux on a FPGA
programmed with a sparc-LEON design you run a system that is open source
from the gate level upward.
the sparc-LEON is distributed as GPL source and can be downloaded from
www.gaisler.com.

> 2) A serie of patches against existing files - logically splitted.

Already did this. As you will see in the listing below the existing
file patches are marginal and easy to understand.

>=20
>    Quickly browsing the link you gave tell me there is some stuff
>    that needs to be redone.
>=20
> When 2) is reviewed and agreed on continue with the leon specific stuff.
> But do not expect much to be applied until the full set is reviewed.
>=20

The patches against existing code are written so that

   if the toplevel macro CONFIG_LEON is not defined, no code-change for
   the original sparc part is taking place.

Therefore I guess it should be not so difficult to review these patches. I'=
ll explain
the various parts here, for convenience I added a [ ] bracket so here
I would suggest to enter:
  [o] : obvious agreed
  [+] : agreed
  [?] : in question
  [-] : rejected
  [v] : rewrite
left is for your opinion, right is my suggestion

- arch/sparc/Kconfig: http://git.kernel.org/?p=3Dlinux/kernel/git/gaisler/s=
parc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd2394b0fa152882#pat=
ch1
   diff.1: @@ -435,6 +435,33 @@
   [ ][o] enable CONFIG_LEON option
           This macro will shield, if undefined, all LEON specific code. In=
 particular
           include/asm/leon.h will get empty through #ifdef
           arch/sparc/kernel/leon.c not compiled through Makefile:obj-$(CON=
FIG_LEON)
           arch/sparc/mm/leon.c not compiled through Makefile:obj-$(CONFIG_=
LEON)
   [ ][?] CONFIG_PAGE_SIZE_LEON_* The Leon processor can be configured to s=
upport
           page sizes !=3D 4k. The option is used in include/asm/leon.h, ho=
wever because
           at this point I cant see hope to get changes to arch/sparc/mm/sr=
mmu.c various
           header files regarding page sizes !=3D 4k applied, this option i=
s in practice
           unused. However because I'd like to introduce this patch maybe i=
n the future
           the option at least is presented.

- arch/sparc/configs/sparc32_defconfig: http://git.kernel.org/?p=3Dlinux/ke=
rnel/git/gaisler/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd=
2394b0fa152882#patch2
   diff.1: @@ -147,6 +147,7 @@
   [ ][o] update the default configuration

- arch/sparc/include/asm/leon.h: http://git.kernel.org/?p=3Dlinux/kernel/gi=
t/gaisler/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd2394b0f=
a152882#patch4
   diff.1: @@ -0,0 +1,652 @@
   [ ][+] new file that bundels all the leon specific defines.
           This file is shielded with a "#if defined(CONFIG_LEON)" from
           messing up anything within existing code. Roughly described here
           are the section (if you scroll though the file:
           1. #defines Various LEON ASI codes
           2. #defines Various bitfield macros for peripherals etc.
           3. static __inline__ various ASI-mmu-bypass inline functions.
              These are used by the drivers (that are the subject of other =
patches
              in driver/..)
           3. #defines Again various bitfield macros for peripherals etc.
           4. A row of struct definitions that define register mapping for
              Leon peripherals like timer-ctrl and irq-ctrl etc. The Leon
              system uses a extension to the AMBA bus standard that enables
              plug-and-play recognition of existing devices on the bus. The
              struct definitions starting with ...amba... are used in this
              context (they are also used in patches to driver/..)
           5. A row of amba plug and play ids for devices


- arch/sparc/include/asm/machines.h: http://git.kernel.org/?p=3Dlinux/kerne=
l/git/gaisler/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd239=
4b0fa152882#patch5
   diff.1: @@ -15,7 +15,7 @@
   [ ][o] new machine added =3D> increment machine count
   diff.2: @@ -30,6 +30,7 @@
   [ ][o] add M_LEON machine type
   diff.3: @@ -41,6 +42,9 @@
   [ ][o] add M_LEON3_SOC type

- arch/sparc/include/asm/pgtsrmmu.h: http://git.kernel.org/?p=3Dlinux/kerne=
l/git/gaisler/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd239=
4b0fa152882#patch6
   diff.1+2: @@ -267,6 +267,7 @@ @@ -278,6 +279,7 @@
   [ ][o]: Undefine srmmu_hwprobe in the CONFIG_LEON case.
             The LEON SRMMU has no mmu probe logic implemented. Instead
             function srmmu_swprobe() is used, see arch/sparc/mm/leon.c.
             in arch/sparc/include/asm/leon.h you can find:
             #define srmmu_hwprobe(addr) (srmmu_swprobe(addr,0) & SRMMU_PTE=
_PMASK)

- arch/sparc/include/asm/system_32.h: http://git.kernel.org/?p=3Dlinux/kern=
el/git/gaisler/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd23=
94b0fa152882#patch7
   diff.1: @@ -32,6 +32,7 @@
   [ ][o]: Add sparc_leon cpu type enum

- arch/sparc/kernel/Makefile: http://git.kernel.org/?p=3Dlinux/kernel/git/g=
aisler/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd2394b0fa15=
2882#patch8
   diff.1: @@ -40,6 +40,8 @@
   [ ][o]: Add conditional compile of arch/sparc/kernel/leon.c
             obj-$(CONFIG_LEON)      +=3D leon.o

- arch/sparc/kernel/cpu.c: http://git.kernel.org/?p=3Dlinux/kernel/git/gais=
ler/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd2394b0fa15288=
2#patch9
   diff.1: @@ -312,7 +312,12 @@
   [ ][o]: Leon can be configured (synthesized from vhdl) to
           not have a FPU. Therefore the get_fsr() can trap (read fsr status
           register). In case of CONFIG_LEON we hardcode the fpu_vers versi=
on number.

- arch/sparc/kernel/head_32.s: http://git.kernel.org/?p=3Dlinux/kernel/git/=
gaisler/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd2394b0fa1=
52882#patch10
   diff.1+2: @@ -814,6 +814,10 @@ @@ -836,6 +840,10 @@
   [ ][o]: Identify LEON on bootup

- arch/sparc/kernel/idprom.c: http://git.kernel.org/?p=3Dlinux/kernel/git/g=
aisler/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd2394b0fa15=
2882#patch11
   diff.1: @@ -31,6 +31,8 @@
   [ ][o]: Add Leon type entry

- arch/sparc/kernel/irq_32.c: http://git.kernel.org/?p=3Dlinux/kernel/git/g=
aisler/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd2394b0fa15=
2882#patch12
   diff.1+2: @@ -639,6 +639,7 @@ @@ -661,6 +662,10 @@
   [ ][o]: irq initialization leon_init_IRQ() for LEON, defined in
           arch/sparc/kernel/leon.c (added)

- arch/sparc/kernel/leon.c: http://git.kernel.org/?p=3Dlinux/kernel/git/gai=
sler/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd2394b0fa1528=
82#patch13
   diff.1: @@ -0,0 +1,305 @@
   [ ][o]: IRQ and timer handling routines specific to LEON.
            The timer handling is grouped around the 2 register map structu=
res:
            volatile LEON3_IrqCtrl_Regs_Map *LEON3_IrqCtrl_Regs =3D 0;
            volatile LEON3_GpTimer_Regs_Map *LEON3_GpTimer_Regs =3D 0;
            These 2 sturcture pointers are initialized by the AMBA plug and
            play discovery routine. This discovery routine is called throug=
h:
             ->arch/sparc/kernel/prom_common.c:prom_build_tree() <see patch=
 below
               ->sparc/kernel/leon.c:leon_node_init()
                 ->drivers/amabpp/amba.c:_amba_init()
            The function _amba_init() is the only reference outside the arc=
h/sparc
            directory. This routine is defined in driver/ambapp/...
            However as for I added a
            obj-$(CONFIG_LEON)      +=3D leon.o
            this should not be a problem.

- arch/sparc/kernel/of_device_32.c: http://git.kernel.org/?p=3Dlinux/kernel=
/git/gaisler/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd2394=
b0fa152882#patch14
   diff.1: @@ -8,6 +8,9 @@
   [ ][o]: shieleded asm/leon.h include
   diff.2: @@ -125,7 +128,10 @@
   [ ][-]: sorry, dangling from debugging,
   diff.3+4: @@ -269,6 +275,37 @@ @@ -293,6 +330,17 @@
   [ ][o]: The Leon system uses a AMBA bus.
            Added support for AMBA bus. The device is a AMBA bus if
            it is a child of prom node "ambapp" (AMBA plug and play).
   diff.5: @@ -560,6 +608,7 @@
   [ ][-]: sorry, dangling from debugging,

- arch/sparc/kernel/prom_32.c: http://git.kernel.org/?p=3Dlinux/kernel/git/=
gaisler/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd2394b0fa1=
52882#patch15
   diff.1+2: @@ -131,6 +131,43 @@ @@ -143,6 +180,10 @@
   [ ][o]: Add support for LEON's AMBA bus, likewise to the sbus and ebus d=
efines.

- arch/sparc/kernel/prom_common.c: http://git.kernel.org/?p=3Dlinux/kernel/=
git/gaisler/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd2394b=
0fa152882#patch16
   diff.1: @@ -22,6 +22,10 @@
   [ ][o]: forward definition to leon_trans_init() and leon_node_init()
            These 2 funtions where defined in arch/sparc/kernel/leon.c().
            As for they require "struct device_node *" it would be inconven=
ient
            to add them to arch/sparc/include/asm/leon.h as for I would have
            to include more files from the to define struct device_node...
   diff.2: @@ -161,7 +165,7 @@
   [ ][o]: some extra check, needed by LEON
   diff.3: @@ -237,12 +241,22 @@
   [ ][o]: some extra transform, needed by LEON, CONFIG_LEON shielded
   [ ][-]: sorry, debug stuff, to be removed
        -static char * __init build_full_name(struct device_node *dp)
        +#if !defined(CONFIG_LEON)
   diff.4: @@ -289,6 +303,10 @@
   [ ][o]: call leon_node_init(). CONFIG_LEON shielded
            This function is defined in arch/sparc/kernel/leon.c. It
            will wait until a node "ambapp" is deliverd and then call
            AMBA plug and play discovery via __amba_init().
            drivers/amabpp/amba.c:_amba_init() will scan the AMBA bus
            and dynamically build up the device node tree with "ambapp"
            node as parent.

- arch/sparc/kernel/setup_32.c: http://git.kernel.org/?p=3Dlinux/kernel/git=
/gaisler/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd2394b0fa=
152882#patch17
   diff.1: @@ -235,6 +235,8 @@ @@ -256,6 +258,9 @@
   [ ][o]: Leon specific discovery


- arch/sparc/mm/Makefile: http://git.kernel.org/?p=3Dlinux/kernel/git/gaisl=
er/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd2394b0fa152882=
#patch18
   diff.1: @@ -11,6 +11,7 @@
   [ ][o]: Compile leon.c if CONFIG_LEON is set

- arch/sparc/mm/fault_32.c: http://git.kernel.org/?p=3Dlinux/kernel/git/gai=
sler/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd2394b0fa1528=
82#patch19
   diff.1: @@ -227,7 +227,11 @@
   [ ][o]: This fixes a leon specific hardware bug, CONFIG_LEON shielded

- arch/sparc/mm/init_32.c: http://git.kernel.org/?p=3Dlinux/kernel/git/gais=
ler/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd2394b0fa15288=
2#patch20
   diff.1: @@ -328,6 +328,7 @@
   [ ][o]: Add leon to paging_init set.

- arch/sparc/mm/leon.c: http://git.kernel.org/?p=3Dlinux/kernel/git/gaisler=
/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd2394b0fa152882#p=
atch21
   diff.1: @@ -0,0 +1,269 @@
   [ ][o]: This file supplies function srmmu_swprobe()
            The Leon MMU doesnt support a hardware probe. Therefore this
            functionality is defined in software. srmmu_swprobe() will
            traverse the page table using ASI MMU bypass accesses.
           Also included are cache/tlb flush operations.

- arch/sparc/mm/loadmmu.c: http://git.kernel.org/?p=3Dlinux/kernel/git/gais=
ler/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd2394b0fa15288=
2#patch22
   diff.1: @@ -33,6 +33,7 @@
   [ ][o]: Add leon to init set.

finally:
- arch/sparc/mm/srmmu.c: http://git.kernel.org/?p=3Dlinux/kernel/git/gaisle=
r/sparc-leon.git;a=3Dcommitdiff;h=A45872c4e571b32ccde2acbecd2394b0fa152882#=
patch23
   diff.1: @@ -46,6 +46,10 @@,  @@ -1976,6 +1986,48 @@
   [ ][o]: include asm/leon.h CONFIG_LEON shielded.
   diff.2: @@ -568,6 +572,12 @@
   [ ][o]: Leon's cache is virtualy tagged. Therefore a flush is needed. CO=
NFIG_LEON shielded
   diff.3: @@ -1976,6 +1986,48 @@
   [ ][o]: Leon dependent init. CONFIG_LEON shielded





---------------------------------- 06/01/2009 -----------------------------


Hello everybody,


I work for Aeroflex Gaisler (formely Gaisler Research) which develops
the LEON SPARC V8 processor. It is a synthesizable soft core CPU written
in VHDL and used in a wide range of applications.

We are currently maintaining our own Linux kernel and distribution for
the processor but would like to contribute it into the mainline kernel.
We understand that this will require some time and work in cooperation
with the SPARC Linux community.

Some technical background information about the LEON CPU:

LEON3 is fully SPARC V8 compliant and has a standard SRMMU as well
(except we support 4 to 32 kB pages). The cache system is VIVT with
keys but can do snooping on the physical addresses. The cache is
write through and configurable in regards to number of sets, way size
and replacement algorithm.

It has a AMBA AHB/APB bus system and supports SMP. There is a rich set
of peripherals that can be added to your typical SoC system such as
10/100/1G Ethernet MAC, USB host controller (EHCI/UHCI), USB device
controller, PCI, ATA, SPI, CAN, etc.


We have received an account on kernel.org and will maintain a sparc-leon
git repository there. I guess sparc-next is the proper repository to
clone as a base for our patches?

Is there any special way that you would like us to structure our code
to fit into the current SPARC tree as painlessly as possible?

Currently our kernel sources can be downloaded here:
ftp://gaisler.com/gaisler.com/linux/linux-2.6/linux/linux-2.6.21.1-leon23-1=
.0.3.tar.bz2

Internally we are however at version 2.6.29 and will be setting up
an up to date git repository for you to scrutinize.


Best regards,
Kristoffer Glembo
--=20
To unsubscribe from this list: send the line "unsubscribe sparclinux" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


---------------------------------------------------------------------------=
-------
