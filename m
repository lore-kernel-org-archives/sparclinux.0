From: =?ISO-8859-1?Q?S=E9bastien_Bernard?= <sbernard@nerim.net>
Date: Sun, 06 Sep 2009 21:21:42 +0000
Subject: Re: Sparc release requalification
Message-Id: <4AA427E6.5000801@nerim.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 22 Aug 2009 21:32:43 +0100, Josip Rodin Wrote :
> [dropping debian-release, as it's not very interesting for them anymore]
>
> On Wed, Aug 19, 2009 at 12:00:54AM +0200, Josip Rodin wrote:
> > On Tue, Aug 18, 2009 at 10:30:29PM +0100, Jurij Smakov wrote:
> > > > > the sid kernels are not booting on my machine (SunBlade 1000), and I have
> > > > > an independent confirmation from someone with a similar machine that they
> > > > > are experiencing similar problems - I'm going to file a bug for that if
> > > > > the situation does not improve with the next kernel upload.
> > > > 
> > > > What seems to be the problem? FWIW the prtconfs.git repo has two SB1000
> > > > entries one of which is davem's, so we should have upstream support for
> > > > this at least.
> > > 
> > > After the message mentioning the console handoff from earlyprom to a real
> > > console it proceeds to clear the screen, however after a couple of lines
> > > it hangs.
> > 
> > Did you try to avoid the handoff? That patch davem keeps telling people to
> > try when something like this happens:
> > 
> > --- a/arch/sparc64/kernel/setup.c
> > +++ b/arch/sparc64/kernel/setup.c
> > @@ -82,7 +82,7 @@ unsigned long cmdline_memory_size = 0;
> >  static struct console prom_early_console = {
> >         .name =         "earlyprom",
> >         .write =        prom_console_write,
> > -       .flags =        CON_PRINTBUFFER | CON_BOOT | CON_ANYTIME,
> > +       .flags =        CON_PRINTBUFFER | CON_ANYTIME,
> >         .index =        -1,
> >  };
>
> I tried this patch, and the box still hangs early during boot with the
> latest kernel from unstable, even though console handover does not
> appear to be happening anymore. Here's the last screenful of messages
> I see on the serial console:
>
> [    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
> [    0.000000] Remapping the kernel... done.
> [    0.000000] OF stdout device is: /pci@8,700000/ebus@5/serial@1,400000:a
> [    0.000000] PROM: Built device tree with 73716 bytes of memory.
> [    0.000000] Top of RAM: 0x7fede000, Total RAM: 0x7fed6000
> [    0.000000] Memory hole size: 0MB
> [    0.000000] [0000000200000000-fffff80000400000] page_structs1072 node=0 entry=0/0
> [    0.000000] [0000000200000000-fffff80000800000] page_structs1072 node=0 entry=1/0
> [    0.000000] [0000000200800000-fffff80000c00000] page_structs1072 node=0 entry=2/0
> [    0.000000] [0000000200800000-fffff80001000000] page_structs1072 node=0 entry=3/0
> [    0.000000] Zone PFN ranges:
> [    0.000000]   Normal   0x00000000 -> 0x0003ff6f
> [    0.000000] Movable zone start PFN for each node
> [    0.000000] early_node_map[3] active PFN ranges
> [    0.000000]     0: 0x00000000 -> 0x0003f7ff
> [    0.000000]     0: 0x0003f800 -> 0x0003ff5d
> [    0.000000]     0: 0x0003ff60 -> 0x0003ff6f
> [    0.000000] Booting Linux...
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 259948
> [    0.000000] Kernel command line: root=LABEL=root ro
> [    0.000000] NR_IRQS:255
> [    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
> [    0.000000] clocksource: mult[c80000] shift[16]
> [    0.000000] clockevent: mult[147ae14] shift[32]
> [   57.812617] Console: colour dummy device 80x25
> [   57.865696] console [tty0] enabled
> [   60.031281] Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
> [   60.120115] Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
> [   60.311406] Memory: 2062032k available (3304k kernel code, 1248k data, 208k init) [fffff80000000000,000000007fede000]
> [   60.516890] Calibrating delay using timer specific routine.. 10.00 BogoMIPS (lpj 015)
> [   60.611164] Security Framework initialized
> [   60.659890] SELinux:  Disabled at boot.
> [   60.705771] Mount-cache hash table entries: 512
> [   60.760489] Initializing cgroup subsys ns
> [   60.807803] Initializing cgroup subsys cpuacct
> [   60.860920] Initializing cgroup subsys devices
> [   60.914042] Initializing cgroup subsys freezer
> [   60.967166] Initializing cgroup subsys net_cls
> [   61.022918] CPU 1: synchronized TICK with master CPU (last diff 0 cycles, maxerr 5 cycles)
> [   61.022933] Brought up 2 CPUs
> [   61.024050] net_namespace: 1936 bytes
> [   61.200137] regulator: core version 0.5
> [   61.245754] NET: Registered protocol family 16
> [   61
>
> It just hangs right there, with the last string only partially displayed
> and cursor blinking right after '61'.
>
> Best regards,
> -- 
> Jurij Smakov                                           jurij@wooyd.org
> Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
>
>   
I think you hit the same bug as I do on my V240 (same hardware I think).
Please Check this patch and see if it resolves your problem :
http://marc.info/?l=linux-sparc&m3922959800843&w=2 
<http://marc.info/?l=linux-sparc&m3922959800843&w=2>


You can also check the whole thread. At the present time, the kernel 
still freezes if this patch is not applied.
Unfortunately, all kernel now from debian or derived distribution are 
hanging my machine. There is no workaroung but
disabling the NMI watchdog by this patch.

David said, he'll look this bug later. I'll need to remind him.

Seb
