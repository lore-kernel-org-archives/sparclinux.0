From: Meelis Roos <mroos@linux.ee>
Date: Sun, 08 Apr 2018 18:44:57 +0000
Subject: sparc64 PCI BAR allocation is still problematic
Message-Id: <alpine.LRH.2.21.1804081219340.17185@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, sparclinux@vger.kernel.org

This is a followup on the thread https://lkml.org/lkml/2015/10/7/135 and 
corresponding https://bugzilla.kernel.org/show_bug.cgi?id7191 entry.

I saw some sparc64 PCI allocation changes in yesterdays git and compiled 
4.16.0-10242-gf605ba9 on most of my sparc64 machines to test if the PCI 
BAR allocation problems introduced in 4.3 were fixed on some of them. 
Alas, no change at all - of the test machines, none showed any changes 
in the error messages in "dmesg | grep BAR".

There was one test machine, T1000 with no addon cards, that did not 
encounter any problem, before or after the recent patch. All the other 
test machines tried still have the BAR allocation problems.

The errors seem to cluster into 3 categories:

1. many devices fail BAR allocations
2. one of the Davicom Ethernet devices fails BAR allocation
3. Uli ISA bridge fails BAR allocation.

Full current dmesg and lspci info is also available if there is any 
interest. I did not include it all here, which machines are interesting?

Details:

1. Many devices, including preventing FC HBA from working on T1-105:

T1-105:
pci 0000:00:01.0: can't claim BAR 8 [mem 0x1ff00000000-0x1ffbfffffff]: address conflict with Video RAM area [??? 0x1ff000a0000-0x1ff000bffff flags 0x80000000]
pci 0000:02:01.0: can't claim BAR 8 [mem 0x1ff00100000-0x1ff028fffff]: no compatible bridge window
pci 0000:03:0f.0: can't claim BAR 8 [mem 0x1ff00100000-0x1ff028fffff]: no compatible bridge window
pci 0000:04:00.0: can't claim BAR 0 [mem 0x1ff01000000-0x1ff01ffffff]: no compatible bridge window
pci 0000:04:00.0: can't claim BAR 1 [mem 0x1ff02000000-0x1ff027fffff]: no compatible bridge window
pci 0000:04:00.1: can't claim BAR 0 [mem 0x1ff02800000-0x1ff0280702f]: no compatible bridge window
pci 0000:04:04.0: can't claim BAR 1 [mem 0x1ff02808000-0x1ff02808fff]: no compatible bridge window
pci 0000:04:04.0: can't claim BAR 6 [mem 0x1ff02810000-0x1ff0281ffff]: no compatible bridge windowqla1280 0000:04:04.0: can't ioremap BAR 1: [mem size 0x00001000]

T1-200:
pci 0000:00:01.0: can't claim BAR 8 [mem 0x1ff00000000-0x1ffbfffffff]: address conflict with Video RAM area [??? 0x1ff000a0000-0x1ff000bffff flags 0x80000000]
pci 0000:02:08.0: can't claim BAR 1 [mem 0x1ff00002000-0x1ff00003fff 64bit]: no compatible bridge window
pci 0000:02:08.0: can't claim BAR 3 [mem 0x1ff00004000-0x1ff00005fff 64bit]: no compatible bridge window
pci 0000:02:08.1: can't claim BAR 1 [mem 0x1ff00006000-0x1ff00007fff 64bit]: no compatible bridge window
pci 0000:02:08.1: can't claim BAR 3 [mem 0x1ff00008000-0x1ff00009fff 64bit]: no compatible bridge window
pci 0000:02:05.0: can't claim BAR 1 [mem 0x1ff0000a000-0x1ff0000bfff]: no compatible bridge window
pci 0000:02:05.0: can't claim BAR 6 [mem 0x1ff00020000-0x1ff0003ffff]: no compatible bridge window

V120:
pci 0000:00:01.0: can't claim BAR 8 [mem 0x1ff00000000-0x1ffbfffffff]: address conflict with Video RAM area [??? 0x1ff000a0000-0x1ff000bffff flags 0x80000000]
pci 0000:02:08.0: can't claim BAR 1 [mem 0x1ff00002000-0x1ff00003fff 64bit]: no compatible bridge window
pci 0000:02:08.0: can't claim BAR 3 [mem 0x1ff00004000-0x1ff00005fff 64bit]: no compatible bridge window
pci 0000:02:08.1: can't claim BAR 1 [mem 0x1ff00006000-0x1ff00007fff 64bit]: no compatible bridge window
pci 0000:02:08.1: can't claim BAR 3 [mem 0x1ff00008000-0x1ff00009fff 64bit]: no compatible bridge window

2. Davicom Ethernet:

Netra X1:
pci 0000:00:05.0: can't claim BAR 6 [mem 0x1ff00080000-0x1ff000bffff]: address conflict with Video RAM area [??? 0x1ff000a0000-0x1ff000bffff flags 0x80000000]

Fire V100:
pci 0000:00:05.0: can't claim BAR 6 [mem 0x1ff00080000-0x1ff000bffff]: address conflict with Video RAM area [??? 0x1ff000a0000-0x1ff000bffff flags 0x80000000]


3. ULi ISA bridge:

T2000:
pci 0001:05:02.0: can't claim BAR 0 [io  0xf010000000-0xf01000ffff]: no compatible bridge window

V245:
pci 0000:05:1e.0: can't claim BAR 0 [io  0x7f810000000-0x7f810000fff]: no compatible bridge window

V210:
pci 0001:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe0100061f]
pci 0001:00:07.0: can't claim BAR 1 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]
pci 0001:00:07.0: can't claim BAR 2 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]

V240:
pci 0001:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe0100061f]
pci 0001:00:07.0: can't claim BAR 1 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]
pci 0001:00:07.0: can't claim BAR 2 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]

V440:
pci 0002:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0002:00:06.0 [io  0x7fe01000600-0x7fe0100061f]
pci 0002:00:07.0: can't claim BAR 1 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]
pci 0002:00:07.0: can't claim BAR 2 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]

Blade 100:
pci 0000:00:07.0: can't claim BAR 0 [io  0x1fe02000000-0x1fe0200ffff]: address conflict with 0000:00:03.0 [io  0x1fe02000600-0x1fe0200061f]
pci 0000:00:07.0: can't claim BAR 1 [mem 0x1ff00000000-0x1ff000fffff]: address conflict with Video RAM area [??? 0x1ff000a0000-0x1ff000bffff flags 0x80000000]


-- 
Meelis Roos (mroos@linux.ee)
