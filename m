From: dl119@free.fr
Date: Sun, 25 Sep 2005 15:15:51 +0000
Subject: 2.6.14-rc2 kernel freezing
Message-Id: <1127661351.4336bf27ede3c@imp4-g19.free.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hello,

First of all I want to use this opportunity to thanks everybody for their work
on linux kernel especially for sparc systems.

I have an U80 with 4 CPUs and I bought few weeks ago a new LSI22320R scsi card.

When I put it at work (with the hardware raid0 option activated) I got some
kernel freezing experiences.

It does not happen for all actions. For instance I can use the followings
commands with no troubles :

  $badblock [-w] /dev/my_raid
  $dd if=/dev/my_raid of=/dev/null bs2k

For these actions the throughput is under 100MB/s (monitored by xosview)
But I can't do the following ones :

  $mkfs.ext2 /dev/my_raid
  $dd if=/dev/zero of=/dev/my_raid bs2k

In these cases I see before freezing a throughput beyond 150MB/s

At the begining I was thinking that the freezing was always complete.
I discover few days ago that sometimes (not always but quite often) I have
a delay (around 15 seconds) between the command hang up and the complete
kernel freeze.
I use this opportunity to switch to the console and to use the alt-sysRq-p
keyboard action. A least one of my CPU seems to be locked :

>>  TPC: pci_strbuf_flush+0x118/0x140
>>  RPC: _spin_lock_irqsave+0x10/0x20
>>  I7:  pci_unmap_sg+0x178/0x1a0
[with kernel linux-2.6.14-rc2-git4]

I can do 4 or 5 alt-sysRq-p during the 15 seconds period and I always observed
the same information but not always at the same position in the CPUs reg dumps.
It is a very bad place to be locked because this execution thread also hold a
spinlock (iommu->lock) which I think is never released.

I get the following information from my kernel ($objdump -S -d vmlinux)

>> 00000000004246c0 <pci_strbuf_flush>:
>>
>> static void pci_strbuf_flush(struct pci_strbuf *strbuf, struct pci_iommu
*iommu,
>>               u32 vaddr, unsigned long ctx, unsigned long npages, int
direction)
>> {
>>   4246c0:       9d e3 bf 40     save  %sp, -192, %sp
>>         int limit;
>>
>>         if (strbuf->strbuf_ctxflush &&
>>   4246c4:       ce 5e 20 20     ldx  [ %i0 + 0x20 ], %g7
>>
>>   ...
>>
>>         limit = 100000;
>>   42475c:       03 00 00 61     sethi  %hi(0x18400), %g1
>>         while (!PCI_STC_FLUSHFLAG_SET(strbuf)) {
>>   424760:       c6 5e 20 38     ldx  [ %i0 + 0x38 ], %g3
>>   424764:       ba 10 62 a0     or  %g1, 0x2a0, %i5
>>   424768:       c4 58 c0 00     ldx  [ %g3 ], %g2
>>   42476c:       0a c0 80 22     brnz,pn   %g2, 4247f4
<pci_strbuf_flush+0x134>
>>   424770:       39 00 10 c7     sethi  %hi(0x431c00), %i4
>>                 limit--;
>>                 if (!limit)
>>   424774:       ba 87 7f ff     addcc  %i5, -1, %i5
>>   424778:       02 40 00 0c     be,pn   %icc, 4247a8 <pci_strbuf_flush+0xe8>
>>   42477c:       91 37 30 0a     srlx  %i4, 0xa, %o0
>>                         break;
>>                 udelay(1);
>>   424780:       40 05 0c c8     call  567aa0 <__const_udelay>
>>   424784:       01 00 00 00     nop
>>                 rmb();
>>   424788:       10 68 00 02     b  %xcc, 424790 <pci_strbuf_flush+0xd0>
>>   42478c:       81 43 e0 01     membar  #LoadLoad
>>   424790:       c2 5e 20 38     ldx  [ %i0 + 0x38 ], %g1
>>   424794:       c4 58 40 00     ldx  [ %g1 ], %g2
>>   424798:       22 f8 bf f8     brz,a   %g2, 424778 <pci_strbuf_flush+0xb8>
>>   42479c:       ba 87 7f ff     addcc  %i5, -1, %i5
>>   4247a0:       10 68 00 15     b  %xcc, 4247f4 <pci_strbuf_flush+0x134>
>>   4247a4:       01 00 00 00     nop
>>         }
>>         if (!limit)
>>                 printk(KERN_WARNING "pci_strbuf_flush: flushflag timeout "
>>   4247a8:       31 00 1b 54     sethi  %hi(0x6d5000), %i0
>>   4247ac:       b4 10 00 10     mov  %l0, %i2
>>   4247b0:       b3 36 60 00     srl  %i1, 0, %i1
>>   4247b4:       40 00 b0 bb     call  450aa0 <printk>
>>   4247b8:       91 ee 21 e0     restore  %i0, 0x1e0, %o0
>>   4247bc:       94 10 00 10     mov  %l0, %o2
>>   4247c0:       40 00 b0 b8     call  450aa0 <printk>
>>   4247c4:       90 12 21 a0     or  %o0, 0x1a0, %o0
>>   4247c8:       02 f6 ff db     brz,pn   %i3, 424734 <pci_strbuf_flush+0x74>
>>   4247cc:       82 10 20 00     clr  %g1
>>   4247d0:       c4 5e 20 10     ldx  [ %i0 + 0x10 ], %g2
>>   4247d4:       07 00 00 08     sethi  %hi(0x2000), %g3
>>>  4247d8:       f2 f0 82 a0     stxa  %i1, [ %g2 ] (21)
>>   4247dc:       82 00 60 01     inc  %g1
>>   4247e0:       80 a0 40 1b     cmp  %g1, %i3
>>   4247e4:       0a 6f ff fd     bcs  %xcc, 4247d8 <pci_strbuf_flush+0x118>
>>   4247e8:       b2 06 40 03     add  %i1, %g3, %i1
>>   4247ec:       10 6f ff d3     b  %xcc, 424738 <pci_strbuf_flush+0x78>
>>   4247f0:       80 a7 60 01     cmp  %i5, 1
>>                        "vaddr[%08x] ctx[%lx] npages[%ld]\n",
>>                        vaddr, ctx, npages);

I repeat this experiment few times and I get the same values each time.

I did the same experiment with an older kernel (2.6.5) and I get the same
behaviour and similar values (from these experiments I learn that the call to
pci_unmap_sg() comes from mptscsih_io_done())

I am not sure that the bug comes from the kernel (it could be the mpt driver)
but I am not skilled enough on sparc architecture to go further. So if somebody
has some idea to help me I would be pleased to provide more informations and to
do more experiment.

Thanks in advance, have a nice week-end
