From: Meelis Roos <mroos@linux.ee>
Date: Fri, 29 Jun 2018 10:06:55 +0000
Subject: Re: sparc64 PCI BAR allocation is still problematic
Message-Id: <alpine.LRH.2.21.1806291158320.6026@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.21.1804081219340.17185@math.ut.ee> <20180620220525.GC108993@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180620220525.GC108993@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org

> > This is a followup on the thread https://lkml.org/lkml/2015/10/7/135 and 
> > corresponding https://bugzilla.kernel.org/show_bug.cgi?id7191 entry.
> > 
> > I saw some sparc64 PCI allocation changes in yesterdays git and compiled 
> > 4.16.0-10242-gf605ba9 on most of my sparc64 machines to test if the PCI 
> > BAR allocation problems introduced in 4.3 were fixed on some of them. 
> > Alas, no change at all - of the test machines, none showed any changes 
> > in the error messages in "dmesg | grep BAR".
> > 
> > There was one test machine, T1000 with no addon cards, that did not 
> > encounter any problem, before or after the recent patch. All the other 
> > test machines tried still have the BAR allocation problems.
> > 
> > The errors seem to cluster into 3 categories:
> > 
> > 1. many devices fail BAR allocations
> > 2. one of the Davicom Ethernet devices fails BAR allocation
> > 3. Uli ISA bridge fails BAR allocation.
> > 
> > Full current dmesg and lspci info is also available if there is any 
> > interest. I did not include it all here, which machines are interesting?
> 
> Hi Meelis,
> 
> Fixes for the worst of these issues are in v4.18-rc1.

Thank you!
 
> I think there are still cases where we will complain about conflicts.
> Some of these look like they result from OF/DT descriptions that
> contain conflicts, and they may not cause a problem other than the
> message itself.

Video RAM area related BAR messages are gone from all servers.

V100 OK
V120 OK
Netra X1 OK
Netra T1-200 OK
Netra T1-105 OK

T2000 still has "no compatible bridge window" about ULi ISA Bridge:

[    3.767832] pci 0001:05:02.0: can't claim BAR 0 [io  0xf010000000-0xf01000ffff]: no compatible bridge window

V245 still has "no compatible bridge window" about ULI ISA Bridge:

[    4.522892] pci 0000:05:1e.0: can't claim BAR 0 [io  0x7f810000000-0x7f810000fff]: no compatible bridge window


ULi PMU resource conflict still present on these servers:

V210
V240
V440
Blade 100

On Blade 100 it is different than the newer V*:
[    9.100363] pci 0000:00:07.0: can't claim BAR 0 [io  0x1fe02000000-0x1fe0200ffff]: address conflict with 0000:00:03.0 [io  0x1fe02000600-0x1fe0200061f]

00:03.0 Non-VGA unclassified device: ULi Electronics Inc. M7101 Power Management Controller [PMU]
00:07.0 ISA bridge: ULi Electronics Inc. M1533/M1535/M1543 PCI to ISA Bridge [Aladdin IV/V/V+]


Additionally, ULi ISA Bridge self-conflict still present - is that 
because it was already reserved by the OF? On these machines:

V210
V240
V440


-- 
Meelis Roos (mroos@linux.ee)
