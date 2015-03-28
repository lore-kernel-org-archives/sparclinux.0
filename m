From: David Ahern <david.ahern@oracle.com>
Date: Sat, 28 Mar 2015 03:45:05 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <551623C1.2040300@oracle.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040102070402050608050007"
List-Id: <sparclinux.vger.kernel.org>
References: <5514391F.2030300@oracle.com>	<CAE9FiQXw3QUCNNZj2SVhn-AYWWnggT=7JXPkGNpYFzq-qAB1aQ@mail.gmail.com>	<551495EE.20201@oracle.com>	<CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>	<CAE9FiQWwU4gsq4y0+BTMtisBGQDxF1m_pxAT62PmP-Ct+O1c5A@mail.gmail.com>	<5515F6B8.8020606@oracle.com>	<5515F782.7060301@oracle.com> <CAE9FiQXpNKrX9BuC5-sgb8XEdFPN1a-wBRR2XqY5Mh1cnhXSPQ@mail.gmail.com>
In-Reply-To: <CAE9FiQXpNKrX9BuC5-sgb8XEdFPN1a-wBRR2XqY5Mh1cnhXSPQ@mail.gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040102070402050608050007
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/15 9:19 PM, Yinghai Lu wrote:
> Good. But we still have annoying warning about "no compatible window".
>
> Please try attached patch that support 64bit pci mem space for sparc.
>
> BTW, looks like you still do not have   CONFIG_PCI_DEBUG=y in your .config.
> otherwise we should more verbose print out.
> Or did you have DYNAMIC_DEBUG enabled ?
> If it is that case, can you remove that?
>

done. attached.


--------------040102070402050608050007
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg"

sshlab root@ca-qasparc24 dmesg
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.36.2 2014/10/24 08:15'
[    0.000000] PROMLIB: Root node compatible: sun4v
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.0.0-rc5+ (root@ca-qasparc24) (gcc version 4.4.7 20120313 (Red Hat 4.4.7-4.0.9) (GCC) ) #1 SMP Fri Mar 27 23:32:21 EDT 2015
[    0.000000] debug: skip boot console de-registration.
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4V
[    0.000000] Ethernet address: 00:10:e0:35:15:f6
[    0.000000] MM: PAGE_OFFSET is 0xfff8000000000000 (max_phys_bits == 47)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0006000000000000]
[    0.000000] MM: VMEMMAP [0x0006000000000000 --> 0x000c000000000000]
[    0.000000] Kernel: Using 3 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /virtual-devices@100/console@1
[    0.000000] PROM: Built device tree with 1478492 bytes of memory.
[    0.000000] MDESC: Size is 774368 bytes.
[    0.000000] PLATFORM: banner-name [SPARC T5-8]
[    0.000000] PLATFORM: name [ORCL,SPARC-T5-8]
[    0.000000] PLATFORM: hostid [863515f6]
[    0.000000] PLATFORM: serial# [003515f6]
[    0.000000] PLATFORM: stick-frequency [3b9aca00]
[    0.000000] PLATFORM: mac-address [10e03515f6]
[    0.000000] PLATFORM: watchdog-resolution [1000 ms]
[    0.000000] PLATFORM: watchdog-max-timeout [31536000000 ms]
[    0.000000] PLATFORM: max-cpus [1024]
[    0.000000] Allocated 81920 bytes for kernel page tables.
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000030400000-0xffffffffffffffff]
[    0.000000]   Normal   [mem 0x0000000000000000-0x0000383fffd11fff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000030400000-0x0000003fddeeffff]
[    0.000000]   node   0: [mem 0x0000003fddef6000-0x0000003fddef7fff]
[    0.000000]   node   1: [mem 0x0000080000000000-0x0000083fffffffff]
[    0.000000]   node   2: [mem 0x0000100000000000-0x0000103fffffffff]
[    0.000000]   node   3: [mem 0x0000180000000000-0x0000183fffffffff]
[    0.000000]   node   4: [mem 0x0000200000000000-0x0000203fffffffff]
[    0.000000]   node   5: [mem 0x0000280000000000-0x0000283fffffffff]
[    0.000000]   node   6: [mem 0x0000300000000000-0x0000303fffffffff]
[    0.000000]   node   7: [mem 0x0000380000000000-0x0000383fffcddfff]
[    0.000000]   node   7: [mem 0x0000383fffcee000-0x0000383fffd11fff]
[    0.000000] Initmem setup node 0 [mem 0x0000000030400000-0x0000003fddef7fff]
[    0.000000] On node 0 totalpages: 33385849
[    0.000000]   Normal zone: 293431 pages used for memmap
[    0.000000]   Normal zone: 33385849 pages, LIFO batch:15
[    0.000000] Initmem setup node 1 [mem 0x0000080000000000-0x0000083fffffffff]
[    0.000000] On node 1 totalpages: 33554432
[    0.000000]   Normal zone: 294912 pages used for memmap
[    0.000000]   Normal zone: 33554432 pages, LIFO batch:15
[    0.000000] Initmem setup node 2 [mem 0x0000100000000000-0x0000103fffffffff]
[    0.000000] On node 2 totalpages: 33554432
[    0.000000]   Normal zone: 294912 pages used for memmap
[    0.000000]   Normal zone: 33554432 pages, LIFO batch:15
[    0.000000] Initmem setup node 3 [mem 0x0000180000000000-0x0000183fffffffff]
[    0.000000] On node 3 totalpages: 33554432
[    0.000000]   Normal zone: 294912 pages used for memmap
[    0.000000]   Normal zone: 33554432 pages, LIFO batch:15
[    0.000000] Initmem setup node 4 [mem 0x0000200000000000-0x0000203fffffffff]
[    0.000000] On node 4 totalpages: 33554432
[    0.000000]   Normal zone: 294912 pages used for memmap
[    0.000000]   Normal zone: 33554432 pages, LIFO batch:15
[    0.000000] Initmem setup node 5 [mem 0x0000280000000000-0x0000283fffffffff]
[    0.000000] On node 5 totalpages: 33554432
[    0.000000]   Normal zone: 294912 pages used for memmap
[    0.000000]   Normal zone: 33554432 pages, LIFO batch:15
[    0.000000] Initmem setup node 6 [mem 0x0000300000000000-0x0000303fffffffff]
[    0.000000] On node 6 totalpages: 33554432
[    0.000000]   Normal zone: 294912 pages used for memmap
[    0.000000]   Normal zone: 33554432 pages, LIFO batch:15
[    0.000000] Initmem setup node 7 [mem 0x0000380000000000-0x0000383fffd11fff]
[    0.000000] On node 7 totalpages: 33554049
[    0.000000]   Normal zone: 294909 pages used for memmap
[    0.000000]   Normal zone: 33554049 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]
[    0.000000] CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit,fmaf,vis3]
[    0.000000] CPU CAPS: [hpc,ima,pause,cbcond,aes,des,kasumi,camellia]
[    0.000000] CPU CAPS: [md5,sha1,sha256,sha512,mpmul,montmul,montsqr,crc32c]
[    0.000000] PERCPU: Embedded 8 pages/cpu @fff8003f4d000000 s27776 r8192 d29568 u65536
[    0.000000] pcpu-alloc: s27776 r8192 d29568 u65536 alloc=1*4194304
[    0.000000] pcpu-alloc: [0] 0000 0001 0002 0003 0004 0005 0006 0007 0008 0009 0010 0011 0012 0013 0014 0015 0016 0017 0018 0019 0020 0021 0022 0023 0024 0025 0026 0027 0028 0029 0030 0031 0032 0033 0034 0035 0036 0037 0038 0039 0040 0041 0042 0043 0044 0045 0046 0047 0048 0049 0050 0051 0052 0053 0054 0055 0056 0057 0058 0059 0060 0061 0062 0063 
[    0.000000] pcpu-alloc: [0] 0064 0065 0066 0067 0068 0069 0070 0071 0072 0073 0074 0075 0076 0077 0078 0079 0080 0081 0082 0083 0084 0085 0086 0087 0088 0089 0090 0091 0092 0093 0094 0095 0096 0097 0098 0099 0100 0101 0102 0103 0104 0105 0106 0107 0108 0109 0110 0111 0112 0113 0114 0115 0116 0117 0118 0119 0120 0121 0122 0123 0124 0125 0126 0127 
[    0.000000] pcpu-alloc: [1] 0128 0129 0130 0131 0132 0133 0134 0135 0136 0137 0138 0139 0140 0141 0142 0143 0144 0145 0146 0147 0148 0149 0150 0151 0152 0153 0154 0155 0156 0157 0158 0159 0160 0161 0162 0163 0164 0165 0166 0167 0168 0169 0170 0171 0172 0173 0174 0175 0176 0177 0178 0179 0180 0181 0182 0183 0184 0185 0186 0187 0188 0189 0190 0191 
[    0.000000] pcpu-alloc: [1] 0192 0193 0194 0195 0196 0197 0198 0199 0200 0201 0202 0203 0204 0205 0206 0207 0208 0209 0210 0211 0212 0213 0214 0215 0216 0217 0218 0219 0220 0221 0222 0223 0224 0225 0226 0227 0228 0229 0230 0231 0232 0233 0234 0235 0236 0237 0238 0239 0240 0241 0242 0243 0244 0245 0246 0247 0248 0249 0250 0251 0252 0253 0254 0255 
[    0.000000] pcpu-alloc: [2] 0256 0257 0258 0259 0260 0261 0262 0263 0264 0265 0266 0267 0268 0269 0270 0271 0272 0273 0274 0275 0276 0277 0278 0279 0280 0281 0282 0283 0284 0285 0286 0287 0288 0289 0290 0291 0292 0293 0294 0295 0296 0297 0298 0299 0300 0301 0302 0303 0304 0305 0306 0307 0308 0309 0310 0311 0312 0313 0314 0315 0316 0317 0318 0319 
[    0.000000] pcpu-alloc: [2] 0320 0321 0322 0323 0324 0325 0326 0327 0328 0329 0330 0331 0332 0333 0334 0335 0336 0337 0338 0339 0340 0341 0342 0343 0344 0345 0346 0347 0348 0349 0350 0351 0352 0353 0354 0355 0356 0357 0358 0359 0360 0361 0362 0363 0364 0365 0366 0367 0368 0369 0370 0371 0372 0373 0374 0375 0376 0377 0378 0379 0380 0381 0382 0383 
[    0.000000] pcpu-alloc: [3] 0384 0385 0386 0387 0388 0389 0390 0391 0392 0393 0394 0395 0396 0397 0398 0399 0400 0401 0402 0403 0404 0405 0406 0407 0408 0409 0410 0411 0412 0413 0414 0415 0416 0417 0418 0419 0420 0421 0422 0423 0424 0425 0426 0427 0428 0429 0430 0431 0432 0433 0434 0435 0436 0437 0438 0439 0440 0441 0442 0443 0444 0445 0446 0447 
[    0.000000] pcpu-alloc: [3] 0448 0449 0450 0451 0452 0453 0454 0455 0456 0457 0458 0459 0460 0461 0462 0463 0464 0465 0466 0467 0468 0469 0470 0471 0472 0473 0474 0475 0476 0477 0478 0479 0480 0481 0482 0483 0484 0485 0486 0487 0488 0489 0490 0491 0492 0493 0494 0495 0496 0497 0498 0499 0500 0501 0502 0503 0504 0505 0506 0507 0508 0509 0510 0511 
[    0.000000] pcpu-alloc: [4] 0512 0513 0514 0515 0516 0517 0518 0519 0520 0521 0522 0523 0524 0525 0526 0527 0528 0529 0530 0531 0532 0533 0534 0535 0536 0537 0538 0539 0540 0541 0542 0543 0544 0545 0546 0547 0548 0549 0550 0551 0552 0553 0554 0555 0556 0557 0558 0559 0560 0561 0562 0563 0564 0565 0566 0567 0568 0569 0570 0571 0572 0573 0574 0575 
[    0.000000] pcpu-alloc: [4] 0576 0577 0578 0579 0580 0581 0582 0583 0584 0585 0586 0587 0588 0589 0590 0591 0592 0593 0594 0595 0596 0597 0598 0599 0600 0601 0602 0603 0604 0605 0606 0607 0608 0609 0610 0611 0612 0613 0614 0615 0616 0617 0618 0619 0620 0621 0622 0623 0624 0625 0626 0627 0628 0629 0630 0631 0632 0633 0634 0635 0636 0637 0638 0639 
[    0.000000] pcpu-alloc: [5] 0640 0641 0642 0643 0644 0645 0646 0647 0648 0649 0650 0651 0652 0653 0654 0655 0656 0657 0658 0659 0660 0661 0662 0663 0664 0665 0666 0667 0668 0669 0670 0671 0672 0673 0674 0675 0676 0677 0678 0679 0680 0681 0682 0683 0684 0685 0686 0687 0688 0689 0690 0691 0692 0693 0694 0695 0696 0697 0698 0699 0700 0701 0702 0703 
[    0.000000] pcpu-alloc: [5] 0704 0705 0706 0707 0708 0709 0710 0711 0712 0713 0714 0715 0716 0717 0718 0719 0720 0721 0722 0723 0724 0725 0726 0727 0728 0729 0730 0731 0732 0733 0734 0735 0736 0737 0738 0739 0740 0741 0742 0743 0744 0745 0746 0747 0748 0749 0750 0751 0752 0753 0754 0755 0756 0757 0758 0759 0760 0761 0762 0763 0764 0765 0766 0767 
[    0.000000] pcpu-alloc: [6] 0768 0769 0770 0771 0772 0773 0774 0775 0776 0777 0778 0779 0780 0781 0782 0783 0784 0785 0786 0787 0788 0789 0790 0791 0792 0793 0794 0795 0796 0797 0798 0799 0800 0801 0802 0803 0804 0805 0806 0807 0808 0809 0810 0811 0812 0813 0814 0815 0816 0817 0818 0819 0820 0821 0822 0823 0824 0825 0826 0827 0828 0829 0830 0831 
[    0.000000] pcpu-alloc: [6] 0832 0833 0834 0835 0836 0837 0838 0839 0840 0841 0842 0843 0844 0845 0846 0847 0848 0849 0850 0851 0852 0853 0854 0855 0856 0857 0858 0859 0860 0861 0862 0863 0864 0865 0866 0867 0868 0869 0870 0871 0872 0873 0874 0875 0876 0877 0878 0879 0880 0881 0882 0883 0884 0885 0886 0887 0888 0889 0890 0891 0892 0893 0894 0895 
[    0.000000] pcpu-alloc: [7] 0896 0897 0898 0899 0900 0901 0902 0903 0904 0905 0906 0907 0908 0909 0910 0911 0912 0913 0914 0915 0916 0917 0918 0919 0920 0921 0922 0923 0924 0925 0926 0927 0928 0929 0930 0931 0932 0933 0934 0935 0936 0937 0938 0939 0940 0941 0942 0943 0944 0945 0946 0947 0948 0949 0950 0951 0952 0953 0954 0955 0956 0957 0958 0959 
[    0.000000] pcpu-alloc: [7] 0960 0961 0962 0963 0964 0965 0966 0967 0968 0969 0970 0971 0972 0973 0974 0975 0976 0977 0978 0979 0980 0981 0982 0983 0984 0985 0986 0987 0988 0989 0990 0991 0992 0993 0994 0995 0996 0997 0998 0999 1000 1001 1002 1003 1004 1005 1006 1007 1008 1009 1010 1011 1012 1013 1014 1015 1016 1017 1018 1019 1020 1021 1022 1023 
[    0.000000] SUN4V: Mondo queue sizes [cpu(131072) dev(16384) r(8192) nr(256)]
[    0.000000] Built 8 zonelists in Node order, mobility grouping on.  Total pages: 265908678
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: root=/dev/mapper/VolGroup-lv_root ro rd_NO_LUKS LANG=en_US.UTF-8 rd_NO_MD rd_LVM_LV=VolGroup/lv_swap SYSFONT=latarcyrheb-sun16 rd_LVM_LV=VolGroup/lv_root KEYBOARDTYPE=pc KEYTABLE=us rd_NO_DM keep_bootcon debug ignore_loglevel
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 4190208 bytes
[    0.000000] log_buf_len min size: 1048576 bytes
[    0.000000] log_buf_len: 8388608 bytes
[    0.000000] early log buf free: 1036920(98%)
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 2127126480K/2146131920K available (5650K kernel code, 902K rwdata, 2384K rodata, 536K init, 2010K bss, 19005440K reserved, 0K cma-reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
[    0.000000] SUN4V: Using IRQ API major 3, cookie only virqs enabled
[99503.072265] clocksource: mult[800000] shift[23]
[99503.127107] clockevent: mult[80000000] shift[31]
[99503.193690] Console: colour dummy device 80x25
[99503.246837] console [tty0] enabled
[99503.368791] Calibrating delay using timer specific routine.. 2001.27 BogoMIPS (lpj=4002541)
[99503.467934] pid_max: default: 1048576 minimum: 8192
[99503.527670] Security Framework initialized
[99503.576114] SELinux:  Initializing.
[99503.618965] SELinux:  Starting in permissive mode
[99503.828145] Dentry cache hash table entries: 268435456 (order: 18, 2147483648 bytes)
[99505.601320] Inode-cache hash table entries: 134217728 (order: 17, 1073741824 bytes)
[99506.500091] Mount-cache hash table entries: 4194304 (order: 12, 33554432 bytes)
[99506.590995] Mountpoint-cache hash table entries: 4194304 (order: 12, 33554432 bytes)
[99506.740519] Initializing cgroup subsys blkio
[99506.791097] Initializing cgroup subsys memory
[99506.843747] Initializing cgroup subsys devices
[99506.894882] Initializing cgroup subsys freezer
[99506.948348] Initializing cgroup subsys net_cls
[99507.000550] Initializing cgroup subsys perf_event
[99507.056425] Initializing cgroup subsys hugetlb
[99507.111056] ftrace: allocating 20497 entries in 41 pages
[99508.616635] Brought up 1024 CPUs
[99508.720943] devtmpfs: initialized
[99508.760658] Performance events: 
[99508.797536] Testing NMI watchdog ... OK.
[99508.925535] Supported PMU type is 'niagara5'
[99509.036528] ldc.c:v1.1 (July 22, 2008)
[99509.131897] NET: Registered protocol family 16
[99509.263661] VIO: Adding device channel-devices
[99509.318108] VIO: Adding device vldc-port-0-0
[99509.370888] VIO: Adding device vldc-port-0-1
[99509.423651] VIO: Adding device vldc-port-0-2
[99509.476413] VIO: Adding device vldc-port-1-0
[99509.528588] VIO: Adding device vldc-port-2-0
[99509.582064] VIO: Adding device vldc-port-3-0
[99509.634835] VIO: Adding device vldc-port-3-1
[99509.687597] VIO: Adding device vldc-port-3-4
[99509.739710] VIO: Adding device vldc-port-3-3
[99509.792484] VIO: Adding device vlds-port-0-0
[99509.845297] VIO: Adding device ds-0
[99509.888595] VIO: Adding device ds-1
[99510.148795] pci_sun4v: Registered hvapi major[1] minor[0]
[99510.215242] /pci@300: SUN4V PCI Bus Module
[99510.263707] /pci@300: On NUMA node -1
[99510.306883] /pci@300: PCI IO[804000000000] MEM[800000000000] MEM64[800100000000]
[99510.393281] /pci@300: Unable to request IOMMU resource.
[99510.474440] /pci@300: Imported 26 TSB entries from OBP
[99510.599133] /pci@300: MSI Queue first[0] num[56] count[512] devino[0x6]
[99510.678076] /pci@300: MSI first[0] num[512] mask[0x3ff] width[32]
[99510.750344] /pci@300: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
[99510.848215] /pci@300: MSI queues at RA [0000083f52c00000]
[99510.912425] PCI: Scanning PBM /pci@300
[99510.956337] pci_sun4v f02dbcfc: PCI host bridge to bus 0000:00
[99511.025812] pci_bus 0000:00: root bus resource [io  0x804000000000-0x80400fffffff] (bus address [0x0000-0xfffffff])
[99511.151039] pci_bus 0000:00: root bus resource [mem 0x800000000000-0x80007effffff] (bus address [0x00000000-0x7effffff])
[99511.282693] pci_bus 0000:00: root bus resource [mem 0x800100000000-0x8007ffffffff] (bus address [0x00000000-0x6ffffffff])
[99511.414878] pci_bus 0000:00: root bus resource [bus 00-77]
[99511.480699] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[99511.553694] pci 0000:00:01.0: PME# disabled
[99511.605095] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[99511.677979] pci 0000:01:00.0: PME# disabled
[99511.728118] pci 0000:02:04.0: PME# supported from D0 D3hot D3cold
[99511.801870] pci 0000:02:04.0: PME# disabled
[99511.852010] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[99511.924648] pci 0000:03:00.0: PME# disabled
[99511.974932] pci 0000:04:06.0: PME# supported from D0 D3hot D3cold
[99512.047804] pci 0000:04:06.0: PME# disabled
[99512.098102] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[99512.170743] pci 0000:05:00.0: PME# disabled
[99512.220810] pci 0000:04:08.0: PME# supported from D0 D3hot D3cold
[99512.293448] pci 0000:04:08.0: PME# disabled
[99512.343744] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
[99512.416385] pci 0000:06:00.0: PME# disabled
[99512.466446] pci 0000:06:00.0: reg 0x184: [mem 0x800210204000-0x800210207fff 64bit]
[99512.557430] pci 0000:06:00.0: reg 0x190: [mem 0x800210304000-0x800210307fff 64bit]
[99512.648562] pci 0000:06:00.1: PME# supported from D0 D3hot D3cold
[99512.721203] pci 0000:06:00.1: PME# disabled
[99512.771407] pci 0000:06:00.1: reg 0x184: [mem 0x800210408000-0x80021040bfff 64bit]
[99512.862024] pci 0000:06:00.1: reg 0x190: [mem 0x800210800000-0x800210803fff 64bit]
[99512.951786] pci 0000:04:0c.0: PME# supported from D0 D3hot D3cold
[99513.024426] pci 0000:04:0c.0: PME# disabled
[99513.074980] pci 0000:07:00.0: supports D1 D2
[99513.126076] pci 0000:02:06.0: PME# supported from D0 D3hot D3cold
[99513.199379] pci 0000:02:06.0: PME# disabled
[99513.249214] pci 0000:05:00.0: can't claim BAR 0 [mem 0x800100000000-0x800100001fff]: no compatible bridge window
[99513.371531] pci 0000:06:00.0: can't claim BAR 0 [mem 0x800110000000-0x8001101fffff pref]: no compatible bridge window
[99513.499033] pci 0000:06:00.0: can't claim BAR 4 [mem 0x800110200000-0x800110203fff pref]: no compatible bridge window
[99513.627043] pci 0000:06:00.0: can't claim BAR 7 [mem 0x800210204000-0x800210303fff 64bit]: no compatible bridge window
[99513.755417] pci 0000:06:00.0: can't claim BAR 10 [mem 0x800210304000-0x800210403fff 64bit]: no compatible bridge window
[99513.884840] pci 0000:06:00.1: can't claim BAR 0 [mem 0x800110600000-0x8001107fffff pref]: no compatible bridge window
[99514.012160] pci 0000:06:00.1: can't claim BAR 4 [mem 0x800110404000-0x800110407fff pref]: no compatible bridge window
[99514.140459] pci 0000:06:00.1: can't claim BAR 7 [mem 0x800210408000-0x800210507fff 64bit]: no compatible bridge window
[99514.269519] pci 0000:06:00.1: can't claim BAR 10 [mem 0x800210800000-0x8002108fffff 64bit]: no compatible bridge window
[99514.400725] pci 0000:07:00.0: can't claim BAR 1 [mem 0x800120000000-0x80012000ffff]: no compatible bridge window
[99514.523057] pci 0000:07:00.0: can't claim BAR 3 [mem 0x800120040000-0x80012007ffff]: no compatible bridge window
[99514.648065] /pci@340: SUN4V PCI Bus Module
[99514.696315] /pci@340: On NUMA node -1
[99514.740020] /pci@340: PCI IO[804100000000] MEM[801000000000] MEM64[801100000000]
[99514.826423] /pci@340: Unable to request IOMMU resource.
[99514.970597] /pci@340: MSI Queue first[0] num[56] count[512] devino[0x6]
[99515.050828] /pci@340: MSI first[0] num[512] mask[0x3ff] width[32]
[99515.124125] /pci@340: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
[99515.220275] /pci@340: MSI queues at RA [0000083f52e00000]
[99515.285167] PCI: Scanning PBM /pci@340
[99515.329471] pci_sun4v f02eab24: PCI host bridge to bus 0001:00
[99515.399091] pci_bus 0001:00: root bus resource [io  0x804100000000-0x80410fffffff] (bus address [0x0000-0xfffffff])
[99515.526725] pci_bus 0001:00: root bus resource [mem 0x801000000000-0x80107effffff] (bus address [0x00000000-0x7effffff])
[99515.656457] pci_bus 0001:00: root bus resource [mem 0x801100000000-0x8017ffffffff] (bus address [0x00000000-0x6ffffffff])
[99515.787989] pci_bus 0001:00: root bus resource [bus 00-e2]
[99515.853588] pci 0001:00:01.0: PME# supported from D0 D3hot D3cold
[99515.926225] pci 0001:00:01.0: PME# disabled
[99515.976278] pci 0001:01:00.0: PME# supported from D0 D3hot D3cold
[99516.048915] pci 0001:01:00.0: PME# disabled
[99516.099049] pci 0001:02:06.0: PME# supported from D0 D3hot D3cold
[99516.171689] pci 0001:02:06.0: PME# disabled
[99516.221488] pci 0001:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99516.343554] pci 0001:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99516.466973] /pci@380: SUN4V PCI Bus Module
[99516.515408] /pci@380: On NUMA node -1
[99516.558582] /pci@380: PCI IO[80c000000000] MEM[808000000000] MEM64[808100000000]
[99516.644967] /pci@380: Unable to request IOMMU resource.
[99516.789501] /pci@380: MSI Queue first[0] num[56] count[512] devino[0x6]
[99516.870571] /pci@380: MSI first[0] num[512] mask[0x3ff] width[32]
[99516.943870] /pci@380: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
[99517.040954] /pci@380: MSI queues at RA [0000003f22c00000]
[99517.106841] PCI: Scanning PBM /pci@380
[99517.151136] pci_sun4v f02f994c: PCI host bridge to bus 0002:00
[99517.221541] pci_bus 0002:00: root bus resource [io  0x80c000000000-0x80c00fffffff] (bus address [0x0000-0xfffffff])
[99517.346955] pci_bus 0002:00: root bus resource [mem 0x808000000000-0x80807effffff] (bus address [0x00000000-0x7effffff])
[99517.478007] pci_bus 0002:00: root bus resource [mem 0x808100000000-0x8087ffffffff] (bus address [0x00000000-0x6ffffffff])
[99517.609842] pci_bus 0002:00: root bus resource [bus 00-e2]
[99517.676159] pci 0002:00:01.0: PME# supported from D0 D3hot D3cold
[99517.748800] pci 0002:00:01.0: PME# disabled
[99517.799058] pci 0002:01:00.0: PME# supported from D0 D3hot D3cold
[99517.871700] pci 0002:01:00.0: PME# disabled
[99517.922039] pci 0002:02:0a.0: PME# supported from D0 D3hot D3cold
[99517.994682] pci 0002:02:0a.0: PME# disabled
[99518.046128] pci 0002:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99518.168194] pci 0002:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99518.292879] pci 0002:03:00.0: can't claim BAR 1 [mem 0x808100000000-0x808100003fff]: no compatible bridge window
[99518.415656] pci 0002:03:00.1: can't claim BAR 1 [mem 0x808100004000-0x808100007fff]: no compatible bridge window
[99518.536997] /pci@3c0: SUN4V PCI Bus Module
[99518.585302] /pci@3c0: On NUMA node -1
[99518.628853] /pci@3c0: PCI IO[80c100000000] MEM[809000000000] MEM64[809100000000]
[99518.715316] /pci@3c0: Unable to request IOMMU resource.
[99518.858825] /pci@3c0: MSI Queue first[0] num[56] count[512] devino[0x6]
[99518.936925] /pci@3c0: MSI first[0] num[512] mask[0x3ff] width[32]
[99519.009846] /pci@3c0: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
[99519.108371] /pci@3c0: MSI queues at RA [0000383f51000000]
[99519.172273] PCI: Scanning PBM /pci@3c0
[99519.216858] pci_sun4v f0308774: PCI host bridge to bus 0003:00
[99519.287180] pci_bus 0003:00: root bus resource [io  0x80c100000000-0x80c10fffffff] (bus address [0x0000-0xfffffff])
[99519.412960] pci_bus 0003:00: root bus resource [mem 0x809000000000-0x80907effffff] (bus address [0x00000000-0x7effffff])
[99519.544976] pci_bus 0003:00: root bus resource [mem 0x809100000000-0x8097ffffffff] (bus address [0x00000000-0x6ffffffff])
[99519.678059] pci_bus 0003:00: root bus resource [bus 00-e2]
[99519.743919] pci 0003:00:01.0: PME# supported from D0 D3hot D3cold
[99519.814818] pci 0003:00:01.0: PME# disabled
[99519.866431] pci 0003:01:00.0: PME# supported from D0 D3hot D3cold
[99519.939865] pci 0003:01:00.0: PME# disabled
[99519.990211] pci 0003:02:0e.0: PME# supported from D0 D3hot D3cold
[99520.062856] pci 0003:02:0e.0: PME# disabled
[99520.113650] pci 0003:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99520.235330] pci 0003:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99520.357772] /pci@400: SUN4V PCI Bus Module
[99520.405817] /pci@400: On NUMA node -1
[99520.448992] /pci@400: PCI IO[814000000000] MEM[810000000000] MEM64[810100000000]
[99520.536091] /pci@400: Unable to request IOMMU resource.
[99520.680558] /pci@400: MSI Queue first[0] num[56] count[512] devino[0x6]
[99520.759504] /pci@400: MSI first[0] num[512] mask[0x3ff] width[32]
[99520.832344] /pci@400: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
[99520.930212] /pci@400: MSI queues at RA [0000303f52000000]
[99520.994424] PCI: Scanning PBM /pci@400
[99521.038711] pci_sun4v f031759c: PCI host bridge to bus 0004:00
[99521.108229] pci_bus 0004:00: root bus resource [io  0x814000000000-0x81400fffffff] (bus address [0x0000-0xfffffff])
[99521.233481] pci_bus 0004:00: root bus resource [mem 0x810000000000-0x81007effffff] (bus address [0x00000000-0x7effffff])
[99521.363957] pci_bus 0004:00: root bus resource [mem 0x810100000000-0x8107ffffffff] (bus address [0x00000000-0x6ffffffff])
[99521.496396] pci_bus 0004:00: root bus resource [bus 00-72]
[99521.562164] pci 0004:00:01.0: PME# supported from D0 D3hot D3cold
[99521.634804] pci 0004:00:01.0: PME# disabled
[99521.685036] pci 0004:01:00.0: PME# supported from D0 D3hot D3cold
[99521.757678] pci 0004:01:00.0: PME# disabled
[99521.808242] pci 0004:02:0c.0: PME# supported from D0 D3hot D3cold
[99521.880883] pci 0004:02:0c.0: PME# disabled
[99521.930888] /pci@440: SUN4V PCI Bus Module
[99521.979323] /pci@440: On NUMA node -1
[99522.022497] /pci@440: PCI IO[814100000000] MEM[811000000000] MEM64[811100000000]
[99522.109696] /pci@440: Unable to request IOMMU resource.
[99522.254072] /pci@440: MSI Queue first[0] num[56] count[512] devino[0x6]
[99522.333014] /pci@440: MSI first[0] num[512] mask[0x3ff] width[32]
[99522.405638] /pci@440: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
[99522.503650] /pci@440: MSI queues at RA [0000303f52200000]
[99522.568261] PCI: Scanning PBM /pci@440
[99522.612761] pci_sun4v f03263c4: PCI host bridge to bus 0005:00
[99522.682232] pci_bus 0005:00: root bus resource [io  0x814100000000-0x81410fffffff] (bus address [0x0000-0xfffffff])
[99522.806451] pci_bus 0005:00: root bus resource [mem 0x811000000000-0x81107effffff] (bus address [0x00000000-0x7effffff])
[99522.938227] pci_bus 0005:00: root bus resource [mem 0x811100000000-0x8117ffffffff] (bus address [0x00000000-0x6ffffffff])
[99523.069754] pci_bus 0005:00: root bus resource [bus 00-e2]
[99523.135815] pci 0005:00:01.0: PME# supported from D0 D3hot D3cold
[99523.208736] pci 0005:00:01.0: PME# disabled
[99523.258961] pci 0005:01:00.0: PME# supported from D0 D3hot D3cold
[99523.331797] pci 0005:01:00.0: PME# disabled
[99523.383485] pci 0005:02:0c.0: PME# supported from D0 D3hot D3cold
[99523.456568] pci 0005:02:0c.0: PME# disabled
[99523.506432] pci 0005:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99523.629143] pci 0005:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99523.753414] /pci@480: SUN4V PCI Bus Module
[99523.801849] /pci@480: On NUMA node -1
[99523.845022] /pci@480: PCI IO[81c000000000] MEM[818000000000] MEM64[818100000000]
[99523.932615] /pci@480: Unable to request IOMMU resource.
[99524.076906] /pci@480: MSI Queue first[0] num[56] count[512] devino[0x6]
[99524.155853] /pci@480: MSI first[0] num[512] mask[0x3ff] width[32]
[99524.228476] /pci@480: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
[99524.325497] /pci@480: MSI queues at RA [0000283f52e00000]
[99524.389705] PCI: Scanning PBM /pci@480
[99524.433989] pci_sun4v f03351ec: PCI host bridge to bus 0006:00
[99524.503926] pci_bus 0006:00: root bus resource [io  0x81c000000000-0x81c00fffffff] (bus address [0x0000-0xfffffff])
[99524.629142] pci_bus 0006:00: root bus resource [mem 0x818000000000-0x81807effffff] (bus address [0x00000000-0x7effffff])
[99524.759618] pci_bus 0006:00: root bus resource [mem 0x818100000000-0x8187ffffffff] (bus address [0x00000000-0x6ffffffff])
[99524.893376] pci_bus 0006:00: root bus resource [bus 00-e2]
[99524.960220] pci 0006:00:01.0: PME# supported from D0 D3hot D3cold
[99525.031339] pci 0006:00:01.0: PME# disabled
[99525.081576] pci 0006:01:00.0: PME# supported from D0 D3hot D3cold
[99525.154216] pci 0006:01:00.0: PME# disabled
[99525.205799] pci 0006:02:04.0: PME# supported from D0 D3hot D3cold
[99525.278771] pci 0006:02:04.0: PME# disabled
[99525.329385] pci 0006:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99525.452093] pci 0006:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99525.574897] /pci@4c0: SUN4V PCI Bus Module
[99525.623340] /pci@4c0: On NUMA node -1
[99525.666512] /pci@4c0: PCI IO[81c100000000] MEM[819000000000] MEM64[819100000000]
[99525.753114] /pci@4c0: Unable to request IOMMU resource.
[99525.897360] /pci@4c0: MSI Queue first[0] num[56] count[512] devino[0x6]
[99525.976307] /pci@4c0: MSI first[0] num[512] mask[0x3ff] width[32]
[99526.048930] /pci@4c0: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
[99526.146795] /pci@4c0: MSI queues at RA [0000203f52000000]
[99526.211003] PCI: Scanning PBM /pci@4c0
[99526.255286] pci_sun4v f0344014: PCI host bridge to bus 0007:00
[99526.324756] pci_bus 0007:00: root bus resource [io  0x81c100000000-0x81c10fffffff] (bus address [0x0000-0xfffffff])
[99526.450340] pci_bus 0007:00: root bus resource [mem 0x819000000000-0x81907effffff] (bus address [0x00000000-0x7effffff])
[99526.581713] pci_bus 0007:00: root bus resource [mem 0x819100000000-0x8197ffffffff] (bus address [0x00000000-0x6ffffffff])
[99526.713241] pci_bus 0007:00: root bus resource [bus 00-e2]
[99526.781211] pci 0007:00:01.0: PME# supported from D0 D3hot D3cold
[99526.852852] pci 0007:00:01.0: PME# disabled
[99526.903084] pci 0007:01:00.0: PME# supported from D0 D3hot D3cold
[99526.976241] pci 0007:01:00.0: PME# disabled
[99527.027245] pci 0007:02:08.0: PME# supported from D0 D3hot D3cold
[99527.100229] pci 0007:02:08.0: PME# disabled
[99527.150104] pci 0007:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99527.274705] pci 0007:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99527.397074] /pci@500: SUN4V PCI Bus Module
[99527.446322] /pci@500: On NUMA node -1
[99527.489514] /pci@500: PCI IO[824000000000] MEM[820000000000] MEM64[820100000000]
[99527.575901] /pci@500: Unable to request IOMMU resource.
[99527.719516] /pci@500: MSI Queue first[0] num[56] count[512] devino[0x6]
[99527.798459] /pci@500: MSI first[0] num[512] mask[0x3ff] width[32]
[99527.870387] /pci@500: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
[99527.969430] /pci@500: MSI queues at RA [0000203f52400000]
[99528.033638] PCI: Scanning PBM /pci@500
[99528.078677] pci_sun4v f0352e3c: PCI host bridge to bus 0008:00
[99528.149236] pci_bus 0008:00: root bus resource [io  0x824000000000-0x82400fffffff] (bus address [0x0000-0xfffffff])
[99528.274452] pci_bus 0008:00: root bus resource [mem 0x820000000000-0x82007effffff] (bus address [0x00000000-0x7effffff])
[99528.404926] pci_bus 0008:00: root bus resource [mem 0x820100000000-0x8207ffffffff] (bus address [0x00000000-0x6ffffffff])
[99528.536452] pci_bus 0008:00: root bus resource [bus 00-e2]
[99528.602200] pci 0008:00:01.0: PME# supported from D0 D3hot D3cold
[99528.674840] pci 0008:00:01.0: PME# disabled
[99528.725176] pci 0008:01:00.0: PME# supported from D0 D3hot D3cold
[99528.799173] pci 0008:01:00.0: PME# disabled
[99528.849512] pci 0008:02:0e.0: PME# supported from D0 D3hot D3cold
[99528.922152] pci 0008:02:0e.0: PME# disabled
[99528.972146] pci 0008:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99529.094208] pci 0008:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99529.216981] /pci@540: SUN4V PCI Bus Module
[99529.265415] /pci@540: On NUMA node -1
[99529.308588] /pci@540: PCI IO[824100000000] MEM[821000000000] MEM64[821100000000]
[99529.395957] /pci@540: Unable to request IOMMU resource.
[99529.540284] /pci@540: MSI Queue first[0] num[56] count[512] devino[0x6]
[99529.619589] /pci@540: MSI first[0] num[512] mask[0x3ff] width[32]
[99529.691263] /pci@540: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
[99529.789745] /pci@540: MSI queues at RA [0000103f52200000]
[99529.853951] PCI: Scanning PBM /pci@540
[99529.898235] pci_sun4v f0361c64: PCI host bridge to bus 0009:00
[99529.967707] pci_bus 0009:00: root bus resource [io  0x824100000000-0x82410fffffff] (bus address [0x0000-0xfffffff])
[99530.093622] pci_bus 0009:00: root bus resource [mem 0x821000000000-0x82107effffff] (bus address [0x00000000-0x7effffff])
[99530.224956] pci_bus 0009:00: root bus resource [mem 0x821100000000-0x8217ffffffff] (bus address [0x00000000-0x6ffffffff])
[99530.356482] pci_bus 0009:00: root bus resource [bus 00-e2]
[99530.422229] pci 0009:00:01.0: PME# supported from D0 D3hot D3cold
[99530.494870] pci 0009:00:01.0: PME# disabled
[99530.545099] pci 0009:01:00.0: PME# supported from D0 D3hot D3cold
[99530.617740] pci 0009:01:00.0: PME# disabled
[99530.668075] pci 0009:02:0e.0: PME# supported from D0 D3hot D3cold
[99530.742156] pci 0009:02:0e.0: PME# disabled
[99530.793011] pci 0009:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99530.915120] pci 0009:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99531.037712] /pci@580: SUN4V PCI Bus Module
[99531.085749] /pci@580: On NUMA node -1
[99531.129374] /pci@580: PCI IO[82c000000000] MEM[828000000000] MEM64[828100000000]
[99531.216490] /pci@580: Unable to request IOMMU resource.
[99531.358697] /pci@580: MSI Queue first[0] num[56] count[512] devino[0x6]
[99531.436548] /pci@580: MSI first[0] num[512] mask[0x3ff] width[32]
[99531.509171] /pci@580: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
[99531.608172] /pci@580: MSI queues at RA [0000103f52400000]
[99531.672723] PCI: Scanning PBM /pci@580
[99531.717012] pci_sun4v f0370a8c: PCI host bridge to bus 000a:00
[99531.786483] pci_bus 000a:00: root bus resource [io  0x82c000000000-0x82c00fffffff] (bus address [0x0000-0xfffffff])
[99531.910756] pci_bus 000a:00: root bus resource [mem 0x828000000000-0x82807effffff] (bus address [0x00000000-0x7effffff])
[99532.041232] pci_bus 000a:00: root bus resource [mem 0x828100000000-0x8287ffffffff] (bus address [0x00000000-0x6ffffffff])
[99532.172204] pci_bus 000a:00: root bus resource [bus 00-e2]
[99532.237154] pci 000a:00:01.0: PME# supported from D0 D3hot D3cold
[99532.310079] pci 000a:00:01.0: PME# disabled
[99532.360363] pci 000a:01:00.0: PME# supported from D0 D3hot D3cold
[99532.434003] pci 000a:01:00.0: PME# disabled
[99532.485752] pci 000a:02:0a.0: PME# supported from D0 D3hot D3cold
[99532.558392] pci 000a:02:0a.0: PME# disabled
[99532.608261] pci 000a:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99532.731887] pci 000a:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99532.853554] /pci@5c0: SUN4V PCI Bus Module
[99532.901989] /pci@5c0: On NUMA node -1
[99532.945163] /pci@5c0: PCI IO[82c100000000] MEM[829000000000] MEM64[829100000000]
[99533.031552] /pci@5c0: Unable to request IOMMU resource.
[99533.174637] /pci@5c0: MSI Queue first[0] num[56] count[512] devino[0x6]
[99533.253577] /pci@5c0: MSI first[0] num[512] mask[0x3ff] width[32]
[99533.326201] /pci@5c0: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
[99533.424766] /pci@5c0: MSI queues at RA [0000083f52000000]
[99533.489295] PCI: Scanning PBM /pci@5c0
[99533.533589] pci_sun4v f037f8b4: PCI host bridge to bus 000b:00
[99533.603223] pci_bus 000b:00: root bus resource [io  0x82c100000000-0x82c10fffffff] (bus address [0x0000-0xfffffff])
[99533.729026] pci_bus 000b:00: root bus resource [mem 0x829000000000-0x82907effffff] (bus address [0x00000000-0x7effffff])
[99533.858109] pci_bus 000b:00: root bus resource [mem 0x829100000000-0x8297ffffffff] (bus address [0x00000000-0x6ffffffff])
[99533.990444] pci_bus 000b:00: root bus resource [bus 00-72]
[99534.056219] pci 000b:00:01.0: PME# supported from D0 D3hot D3cold
[99534.127991] pci 000b:00:01.0: PME# disabled
[99534.178218] pci 000b:01:00.0: PME# supported from D0 D3hot D3cold
[99534.251087] pci 000b:01:00.0: PME# disabled
[99534.301416] pci 000b:02:08.0: PME# supported from D0 D3hot D3cold
[99534.374056] pci 000b:02:08.0: PME# disabled
[99534.424013] /pci@600: SUN4V PCI Bus Module
[99534.472448] /pci@600: On NUMA node -1
[99534.515622] /pci@600: PCI IO[834000000000] MEM[830000000000] MEM64[830100000000]
[99534.602324] /pci@600: Unable to request IOMMU resource.
[99534.745582] /pci@600: MSI Queue first[0] num[56] count[512] devino[0x6]
[99534.824522] /pci@600: MSI first[0] num[512] mask[0x3ff] width[32]
[99534.897145] /pci@600: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
[99534.995012] /pci@600: MSI queues at RA [0000083f52200000]
[99535.059222] PCI: Scanning PBM /pci@600
[99535.103508] pci_sun4v f038e6dc: PCI host bridge to bus 000c:00
[99535.174381] pci_bus 000c:00: root bus resource [io  0x834000000000-0x83400fffffff] (bus address [0x0000-0xfffffff])
[99535.300370] pci_bus 000c:00: root bus resource [mem 0x830000000000-0x83007effffff] (bus address [0x00000000-0x7effffff])
[99535.432186] pci_bus 000c:00: root bus resource [mem 0x830100000000-0x8307ffffffff] (bus address [0x00000000-0x6ffffffff])
[99535.564608] pci_bus 000c:00: root bus resource [bus 00-e2]
[99535.630975] pci 000c:00:01.0: PME# supported from D0 D3hot D3cold
[99535.704258] pci 000c:00:01.0: PME# disabled
[99535.754501] pci 000c:01:00.0: PME# supported from D0 D3hot D3cold
[99535.827829] pci 000c:01:00.0: PME# disabled
[99535.878167] pci 000c:02:08.0: PME# supported from D0 D3hot D3cold
[99535.951074] pci 000c:02:08.0: PME# disabled
[99536.000958] pci 000c:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99536.122642] pci 000c:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99536.243745] /pci@640: SUN4V PCI Bus Module
[99536.292179] /pci@640: On NUMA node -1
[99536.335352] /pci@640: PCI IO[834100000000] MEM[831000000000] MEM64[831100000000]
[99536.422293] /pci@640: Unable to request IOMMU resource.
[99536.565187] /pci@640: MSI Queue first[0] num[56] count[512] devino[0x6]
[99536.643237] /pci@640: MSI first[0] num[512] mask[0x3ff] width[32]
[99536.714600] /pci@640: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
[99536.813118] /pci@640: MSI queues at RA [0000083f52400000]
[99536.877326] PCI: Scanning PBM /pci@640
[99536.921617] pci_sun4v f039d504: PCI host bridge to bus 000d:00
[99536.991088] pci_bus 000d:00: root bus resource [io  0x834100000000-0x83410fffffff] (bus address [0x0000-0xfffffff])
[99537.116303] pci_bus 000d:00: root bus resource [mem 0x831000000000-0x83107effffff] (bus address [0x00000000-0x7effffff])
[99537.246778] pci_bus 000d:00: root bus resource [mem 0x831100000000-0x8317ffffffff] (bus address [0x00000000-0x6ffffffff])
[99537.378309] pci_bus 000d:00: root bus resource [bus 00-e2]
[99537.444041] pci 000d:00:01.0: PME# supported from D0 D3hot D3cold
[99537.516683] pci 000d:00:01.0: PME# disabled
[99537.566930] pci 000d:01:00.0: PME# supported from D0 D3hot D3cold
[99537.640404] pci 000d:01:00.0: PME# disabled
[99537.690747] pci 000d:02:08.0: PME# supported from D0 D3hot D3cold
[99537.764736] pci 000d:02:08.0: PME# disabled
[99537.816255] pci 000d:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99537.938319] pci 000d:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99538.060380] pci 000d:03:00.0: can't claim BAR 0 [mem 0x831100000000-0x831100001fff]: no compatible bridge window
[99538.182619] pci 000d:03:00.0: can't claim BAR 2 [mem 0x831100004000-0x831100007fff]: no compatible bridge window
[99538.304976] pci 000d:03:00.1: can't claim BAR 0 [mem 0x831100002000-0x831100003fff]: no compatible bridge window
[99538.427982] pci 000d:03:00.1: can't claim BAR 2 [mem 0x831100008000-0x83110000bfff]: no compatible bridge window
[99538.551205] /pci@680: SUN4V PCI Bus Module
[99538.599709] /pci@680: On NUMA node -1
[99538.642881] /pci@680: PCI IO[83c000000000] MEM[838000000000] MEM64[838100000000]
[99538.729266] /pci@680: Unable to request IOMMU resource.
[99538.871447] /pci@680: MSI Queue first[0] num[56] count[512] devino[0x6]
[99538.951833] /pci@680: MSI first[0] num[512] mask[0x3ff] width[32]
[99539.024456] /pci@680: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
[99539.122322] /pci@680: MSI queues at RA [0000303f52400000]
[99539.186530] PCI: Scanning PBM /pci@680
[99539.230817] pci_sun4v f03ac32c: PCI host bridge to bus 000e:00
[99539.300292] pci_bus 000e:00: root bus resource [io  0x83c000000000-0x83c00fffffff] (bus address [0x0000-0xfffffff])
[99539.425508] pci_bus 000e:00: root bus resource [mem 0x838000000000-0x83807effffff] (bus address [0x00000000-0x7effffff])
[99539.556059] pci_bus 000e:00: root bus resource [mem 0x838100000000-0x8387ffffffff] (bus address [0x00000000-0x6ffffffff])
[99539.688095] pci_bus 000e:00: root bus resource [bus 00-e2]
[99539.754096] pci 000e:00:01.0: PME# supported from D0 D3hot D3cold
[99539.826738] pci 000e:00:01.0: PME# disabled
[99539.877564] pci 000e:01:00.0: PME# supported from D0 D3hot D3cold
[99539.951138] pci 000e:01:00.0: PME# disabled
[99540.001474] pci 000e:02:04.0: PME# supported from D0 D3hot D3cold
[99540.074169] pci 000e:02:04.0: PME# disabled
[99540.124571] pci 000e:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99540.246677] pci 000e:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
[99540.369663] /pci@6c0: SUN4V PCI Bus Module
[99540.418097] /pci@6c0: On NUMA node -1
[99540.461269] /pci@6c0: PCI IO[83c100000000] MEM[839000000000] MEM64[839100000000]
[99540.547683] /pci@6c0: Unable to request IOMMU resource.
[99540.627341] /pci@6c0: Imported 13 TSB entries from OBP
[99540.751465] /pci@6c0: MSI Queue first[0] num[56] count[512] devino[0x6]
[99540.830403] /pci@6c0: MSI first[0] num[512] mask[0x3ff] width[32]
[99540.903814] /pci@6c0: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
[99541.001681] /pci@6c0: MSI queues at RA [0000303f52600000]
[99541.065890] PCI: Scanning PBM /pci@6c0
[99541.110179] pci_sun4v f03bb154: PCI host bridge to bus 000f:00
[99541.179649] pci_bus 000f:00: root bus resource [io  0x83c100000000-0x83c10fffffff] (bus address [0x0000-0xfffffff])
[99541.304866] pci_bus 000f:00: root bus resource [mem 0x839000000000-0x83907effffff] (bus address [0x00000000-0x7effffff])
[99541.436005] pci_bus 000f:00: root bus resource [mem 0x839100000000-0x8397ffffffff] (bus address [0x00000000-0x6ffffffff])
[99541.567578] pci_bus 000f:00: root bus resource [bus 00-78]
[99541.633939] pci 000f:00:01.0: PME# supported from D0 D3hot D3cold
[99541.706581] pci 000f:00:01.0: PME# disabled
[99541.756813] pci 000f:01:00.0: PME# supported from D0 D3hot D3cold
[99541.829453] pci 000f:01:00.0: PME# disabled
[99541.879786] pci 000f:02:04.0: PME# supported from D0 D3hot D3cold
[99541.953244] pci 000f:02:04.0: PME# disabled
[99542.004364] pci 000f:02:0c.0: PME# supported from D0 D3hot D3cold
[99542.077004] pci 000f:02:0c.0: PME# disabled
[99542.127321] pci 000f:73:00.0: PME# supported from D0 D3hot D3cold
[99542.199963] pci 000f:73:00.0: PME# disabled
[99542.251137] pci 000f:74:04.0: PME# supported from D0 D3hot D3cold
[99542.324001] pci 000f:74:04.0: PME# disabled
[99542.374523] pci 000f:75:00.0: PME# supported from D0 D3hot D3cold
[99542.447166] pci 000f:75:00.0: PME# disabled
[99542.496977] pci 000f:75:00.0: reg 0x184: [mem 0x839580204000-0x839580207fff 64bit]
[99542.588188] pci 000f:75:00.0: reg 0x190: [mem 0x839580304000-0x839580307fff 64bit]
[99542.678494] pci 000f:75:00.1: PME# supported from D0 D3hot D3cold
[99542.751137] pci 000f:75:00.1: PME# disabled
[99542.800912] pci 000f:75:00.1: reg 0x184: [mem 0x839580408000-0x83958040bfff 64bit]
[99542.891572] pci 000f:75:00.1: reg 0x190: [mem 0x839580800000-0x839580803fff 64bit]
[99542.982228] pci 000f:74:06.0: PME# supported from D0 D3hot D3cold
[99543.055221] pci 000f:74:06.0: PME# disabled
[99543.106229] pci 000f:76:00.0: PME# supported from D0 D3hot D3cold
[99543.178872] pci 000f:76:00.0: PME# disabled
[99543.230026] pci 000f:74:07.0: PME# supported from D0 D3hot D3cold
[99543.303975] pci 000f:74:07.0: PME# disabled
[99543.355128] pci 000f:74:0c.0: PME# supported from D0 D3hot D3cold
[99543.428146] pci 000f:74:0c.0: PME# disabled
[99543.478993] pci 000f:78:00.0: supports D1 D2
[99543.530717] pci 000f:75:00.0: can't claim BAR 0 [mem 0x839480000000-0x8394801fffff pref]: no compatible bridge window
[99543.656894] pci 000f:75:00.0: can't claim BAR 4 [mem 0x839480200000-0x839480203fff pref]: no compatible bridge window
[99543.785141] pci 000f:75:00.0: can't claim BAR 7 [mem 0x839580204000-0x839580303fff 64bit]: no compatible bridge window
[99543.915709] pci 000f:75:00.0: can't claim BAR 10 [mem 0x839580304000-0x839580403fff 64bit]: no compatible bridge window
[99544.045948] pci 000f:75:00.1: can't claim BAR 0 [mem 0x839480600000-0x8394807fffff pref]: no compatible bridge window
[99544.174797] pci 000f:75:00.1: can't claim BAR 4 [mem 0x839480404000-0x839480407fff pref]: no compatible bridge window
[99544.302988] pci 000f:75:00.1: can't claim BAR 7 [mem 0x839580408000-0x839580507fff 64bit]: no compatible bridge window
[99544.432331] pci 000f:75:00.1: can't claim BAR 10 [mem 0x839580800000-0x8395808fffff 64bit]: no compatible bridge window
[99544.560901] pci 000f:76:00.0: can't claim BAR 0 [mem 0x839490000000-0x839490001fff]: no compatible bridge window
[99544.684447] pci 000f:78:00.0: can't claim BAR 1 [mem 0x8394a0000000-0x8394a000ffff]: no compatible bridge window
[99544.806738] pci 000f:78:00.0: can't claim BAR 3 [mem 0x8394a0040000-0x8394a007ffff]: no compatible bridge window
[99544.995877] vgaarb: device added: PCI:000f:77:00.0,decodes=io+mem,owns=none,locks=none
[99545.090858] vgaarb: loaded
[99545.122797] vgaarb: bridge control possible 000f:77:00.0
[99545.196673] SCSI subsystem initialized
[99545.246572] libata version 3.00 loaded.
[99545.292053] usbcore: registered new interface driver usbfs
[99545.357354] usbcore: registered new interface driver hub
[99545.428267] usbcore: registered new device driver usb
[99545.501630] NetLabel: Initializing
[99545.541658] NetLabel:  domain hash size = 128
[99545.594193] NetLabel:  protocols = UNLABELED CIPSOv4
[99545.653584] NetLabel:  unlabeled traffic allowed by default
[99545.721925] SUN4V: Reboot data supported (maj=1,min=0).
[99545.783202] ds.c:v1.0 (Jul 11, 2007)
[99545.834883] Switched to clocksource stick
[99545.863230] ds-1: Registered pri service.
[99545.868944] ds-1: Registered var-config-backup service.
[99546.078703] NET: Registered protocol family 2
[99546.146274] TCP established hash table entries: 524288 (order: 9, 4194304 bytes)
[99546.238320] TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
[99546.319143] TCP: Hash tables configured (established 524288 bind 65536)
[99546.397230] TCP: reno registered
[99546.436150] UDP hash table entries: 65536 (order: 8, 2097152 bytes)
[99546.513175] UDP-Lite hash table entries: 65536 (order: 8, 2097152 bytes)
[99546.609346] NET: Registered protocol family 1
[99546.661055] pci 0000:05:00.0: calling quirk_usb_early_handoff+0x0/0x220
[99546.747867] pci 0000:05:00.0: xHCI BIOS handoff failed (BIOS bug ?) 00010401
[99546.838131] pci 0000:06:00.0: calling quirk_e100_interrupt+0x0/0x220
[99546.913932] pci 0000:06:00.1: calling quirk_e100_interrupt+0x0/0x220
[99546.990254] pci 000f:75:00.0: calling quirk_e100_interrupt+0x0/0x220
[99547.066051] pci 000f:75:00.1: calling quirk_e100_interrupt+0x0/0x220
[99547.141854] pci 000f:76:00.0: calling quirk_usb_early_handoff+0x0/0x220
[99547.227385] pci 000f:76:00.0: xHCI BIOS handoff failed (BIOS bug ?) 00010401
[99547.318557] PCI: CLS mismatch (64 != 512), using 64 bytes
[99547.383082] Trying to unpack rootfs image as initramfs...
[99547.723565] Freeing initrd memory: 7408K (fff8380004000000 - fff838000473c000)
[99547.839330] futex hash table entries: 262144 (order: 11, 16777216 bytes)
[99547.928300] Initialise system trusted keyring
[99547.984333] audit: initializing netlink subsys (disabled)
[99548.048598] audit: type=2000 audit(11.048:1): initialized
[99548.116166] HugeTLB registered 8 MB page size, pre-allocated 0 pages
[99548.203415] VFS: Disk quotas dquot_6.5.2
[99548.257670] VFS: Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
[99548.369004] SELinux:  Registering netfilter hooks
[99548.429625] alg: No test for stdrng (krng)
[99548.478146] Key type asymmetric registered
[99548.527042] Asymmetric key parser 'x509' registered
[99548.586173] bounce: pool size: 64 pages
[99548.636263] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[99548.730489] io scheduler noop registered
[99548.775819] io scheduler deadline registered (default)
[99548.840996] io scheduler cfq registered
[99548.887239] f0290cf4: ttyS0 at I/O 0x0 (irq = 1, base_baud = 115200) is a SUN4V HCONS
[99557.711898] console [ttyHV0] enabled
[99557.763936] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[99557.941059] brd: module loaded
[99558.150688] loop: module loaded
[99558.198824] zram: Created 1 device(s)
[99558.255226] libphy: Fixed MDIO Bus: probed
[99558.313021] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[99558.404743] ehci-pci: EHCI PCI platform driver
[99558.468170] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[99558.556329] ohci-pci: OHCI PCI platform driver
[99558.618745] uhci_hcd: USB Universal Host Controller Interface driver
[99558.709195] mousedev: PS/2 mouse device common for all mice
[99558.789488] rtc-sun4v rtc-sun4v: rtc core: registered sun4v as rtc0
[99558.878301] hidraw: raw HID events driver (C) Jiri Kosina
[99558.954449] usbcore: registered new interface driver usbhid
[99559.031777] usbhid: USB HID core driver
[99559.085632] drop_monitor: Initializing network drop monitor service
[99559.175368] TCP: cubic registered
[99559.221754] Initializing XFRM netlink socket
[99559.281720] NET: Registered protocol family 17
[99559.345109] Key type dns_resolver registered
[99559.410546] Loading compiled-in X.509 certificates
[99559.478705] Loaded X.509 cert 'Magrathea: Glacier signing key: dbc223be1a955463bb52b6d4075d495a808a787e'
[99559.612730] registered taskstats version 1
[99559.670244] ima: No TPM chip found, activating TPM-bypass!
[99559.758915] rtc-sun4v rtc-sun4v: setting system clock to 2015-03-28 03:44:08 UTC (1427514248)
[99559.917299] dracut: dracut-004-336.0.2.el6_5.2
[99559.994479] dracut: rd_NO_LUKS: removing cryptoluks activation
[99560.088959] dm_mod: module verification failed: signature and/or required key missing - tainting kernel
[99560.229347] device-mapper: uevent: version 1.0.3
[99560.301351] device-mapper: ioctl: 4.30.0-ioctl (2014-12-22) initialised: dm-devel@redhat.com
[99560.444289] udev: starting version 147
[99560.696120] dracut: Starting plymouth daemon
[99560.898411] sha256_sparc64: Using sparc64 sha256 opcode optimized SHA-256/SHA-224 implementation
[99561.023617] aes_sparc64: Using sparc64 aes opcodes optimized AES implementation
[99563.861017] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 8.07.00.16-k.
[99563.976276] qla2xxx [0002:03:00.0]-001d: : Found an ISP2532 irq 11 iobase 0x0000808100000000.
[99564.102864] qla2xxx 0002:03:00.0: enabling Mem-Wr-Inval
[99567.047422] scsi host0: qla2xxx
[99567.107118] qla2xxx [0002:03:00.0]-00fb:0: QLogic QLE2562 - Sun StorageTek 8Gb FC PCIe HBA, dual port.
[99567.238521] qla2xxx [0002:03:00.0]-00fc:0: ISP2532: PCIe (2.5GT/s x8) @ 0002:03:00.0 hdma- host#=0 fw=7.03.00 (90d5).
[99567.318490] qla2xxx [0002:03:00.0]-500a:0: LOOP UP detected (8 Gbps).
[99567.479109] qla2xxx [0002:03:00.1]-001d: : Found an ISP2532 irq 12 iobase 0x0000808100004000.
[99567.604749] qla2xxx 0002:03:00.1: enabling Mem-Wr-Inval
[99567.808718] qla2xxx [0002:03:00.0]-2064:0: SNS scan failed -- assuming zero-entry result.
[99570.547399] scsi host1: qla2xxx
[99570.606221] qla2xxx [0002:03:00.1]-00fb:1: QLogic QLE2562 - Sun StorageTek 8Gb FC PCIe HBA, dual port.
[99570.738878] qla2xxx [0002:03:00.1]-00fc:1: ISP2532: PCIe (2.5GT/s x8) @ 0002:03:00.1 hdma- host#=1 fw=7.03.00 (90d5).
[99575.626200] Emulex LightPulse Fibre Channel SCSI driver 10.4.8000.0.
[99575.715500] Copyright(c) 2004-2014 Emulex.  All rights reserved.
[99575.801146] lpfc 000d:03:00.0: enabling Mem-Wr-Inval
[99575.872884] scsi host2: Emulex LPe12000-S PCIe Fibre Channel Adapter  on PCI bus 03 device 00 irq 35
[99578.459989] lpfc 000d:03:00.1: enabling Mem-Wr-Inval
[99578.531736] scsi host3: Emulex LPe12000-S PCIe Fibre Channel Adapter  on PCI bus 03 device 01 irq 36
[99581.186870] mpt2sas version 20.100.00.00 loaded
[99581.251058] mpt2sas 0000:07:00.0: enabling bus mastering
[99581.325675] mpt2sas0: 32 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (2127134424 kB)
[99581.727355] mpt2sas0: MSI-X vectors supported: 8, no of cores: 1024, max_msix_vectors: 8
[99581.850980] mpt2sas0-msix0: PCI-MSI-X enabled: IRQ 973
[99581.923760] mpt2sas0-msix1: PCI-MSI-X enabled: IRQ 974
[99581.996620] mpt2sas0-msix2: PCI-MSI-X enabled: IRQ 975
[99582.069204] mpt2sas0-msix3: PCI-MSI-X enabled: IRQ 976
[99582.141586] mpt2sas0-msix4: PCI-MSI-X enabled: IRQ 977
[99582.214026] mpt2sas0-msix5: PCI-MSI-X enabled: IRQ 978
[99582.286707] mpt2sas0-msix6: PCI-MSI-X enabled: IRQ 979
[99582.360328] mpt2sas0-msix7: PCI-MSI-X enabled: IRQ 980
[99582.432544] mpt2sas0: iomem(0x0000800120000000), mapped(0x0000800120000000), size(65536)
[99582.546129] mpt2sas0: ioport(0x0000804000001000), size(256)
[99583.059890] mpt2sas0: Allocated physical memory: size(4603 kB)
[99583.141804] mpt2sas0: Current Controller Queue Depth(2811), Max Controller Queue Depth(3072)
[99583.260579] mpt2sas0: Scatter Gather Elements per IO(128)
[99583.568932] mpt2sas0: LSISAS2308: FWVersion(14.00.00.00), ChipRevision(0x05), BiosVersion(00.00.00.00)
[99583.700422] mpt2sas0: Protocol=(Initiator), Capabilities=(Raid,TLR,EEDP,Snapshot Buffer,Diag Trace Buffer,Task Set Full,NCQ)
[99583.858220] scsi host4: Fusion MPT SAS Host
[99583.923540] mpt2sas0: sending port enable !!
[99583.924088] mpt2sas1: 32 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (2127134424 kB)
[99584.211350] mpt2sas1: MSI-X vectors supported: 8, no of cores: 1024, max_msix_vectors: 8
[99584.334957] mpt2sas1-msix0: PCI-MSI-X enabled: IRQ 981
[99584.407435] mpt2sas1-msix1: PCI-MSI-X enabled: IRQ 982
[99584.479651] mpt2sas1-msix2: PCI-MSI-X enabled: IRQ 983
[99584.551869] mpt2sas1-msix3: PCI-MSI-X enabled: IRQ 984
[99584.623721] mpt2sas1-msix4: PCI-MSI-X enabled: IRQ 985
[99584.695936] mpt2sas1-msix5: PCI-MSI-X enabled: IRQ 986
[99584.768644] mpt2sas1-msix6: PCI-MSI-X enabled: IRQ 987
[99584.843729] mpt2sas1-msix7: PCI-MSI-X enabled: IRQ 988
[99584.916193] mpt2sas1: iomem(0x00008394a0000000), mapped(0x00008394a0000000), size(65536)
[99585.030699] mpt2sas1: ioport(0x000083c104001000), size(256)
[99585.543784] mpt2sas1: Allocated physical memory: size(4603 kB)
[99585.625695] mpt2sas1: Current Controller Queue Depth(2811), Max Controller Queue Depth(3072)
[99585.716420] mpt2sas0: host_add: handle(0x0001), sas_addr(0x508002000159c0d0), phys(8)
[99585.854932] mpt2sas1: Scatter Gather Elements per IO(128)
[99586.164464] mpt2sas1: LSISAS2308: FWVersion(14.00.00.00), ChipRevision(0x05), BiosVersion(00.00.00.00)
[99586.296231] mpt2sas1: Protocol=(Initiator), Capabilities=(Raid,TLR,EEDP,Snapshot Buffer,Diag Trace Buffer,Task Set Full,NCQ)
[99586.454056] scsi host5: Fusion MPT SAS Host
[99586.516626] mpt2sas1: sending port enable !!
[99588.116973] mpt2sas1: host_add: handle(0x0001), sas_addr(0x508002000159c0d1), phys(8)
[99591.843255] mpt2sas0: port enable: SUCCESS
[99591.880328] qla2xxx [0002:03:00.1]-8038:1: Cable is unplugged...
[99591.993355] scsi 4:0:0:0: Direct-Access     HITACHI  H109030SESUN300G A31A PQ: 0 ANSI: 6
[99592.106313] scsi 4:0:0:0: SSP: handle(0x0009), sas_addr(0x5000cca0163295b1), phy(1), device_name(0x5000cca0163295b3)
[99592.255426] scsi 4:0:0:0: SSP: enclosure_logical_id(0x508002000159c0d0), slot(1)
[99592.368374] scsi 4:0:1:0: Direct-Access     HITACHI  H109030SESUN300G A31A PQ: 0 ANSI: 6
[99592.483014] scsi 4:0:1:0: SSP: handle(0x000a), sas_addr(0x5000cca0162a4c1d), phy(2), device_name(0x5000cca0162a4c1f)
[99592.630984] scsi 4:0:1:0: SSP: enclosure_logical_id(0x508002000159c0d0), slot(2)
[99592.689305] random: nonblocking pool is initialized
[99594.239254] mpt2sas1: port enable: SUCCESS
[99594.305340] scsi 5:0:0:0: Direct-Access     HITACHI  H109030SESUN300G A31A PQ: 0 ANSI: 6
[99594.420929] scsi 5:0:0:0: SSP: handle(0x0009), sas_addr(0x5000cca0162f2e39), phy(0), device_name(0x5000cca0162f2e3b)
[99594.570333] scsi 5:0:0:0: SSP: enclosure_logical_id(0x508002000159c0d1), slot(0)
[99594.684670] scsi 5:0:1:0: Direct-Access     HITACHI  H109030SESUN300G A31A PQ: 0 ANSI: 6
[99594.798919] scsi 5:0:1:0: SSP: handle(0x000a), sas_addr(0x5000cca016322ee5), phy(1), device_name(0x5000cca016322ee7)
[99594.945454] scsi 5:0:1:0: SSP: enclosure_logical_id(0x508002000159c0d1), slot(1)
[99595.058059] scsi 5:0:2:0: Direct-Access     HITACHI  H109030SESUN300G A31A PQ: 0 ANSI: 6
[99595.174354] scsi 5:0:2:0: SSP: handle(0x000b), sas_addr(0x5000cca016322f71), phy(2), device_name(0x5000cca016322f73)
[99595.323927] scsi 5:0:2:0: SSP: enclosure_logical_id(0x508002000159c0d1), slot(2)
[99595.476079] sd 4:0:0:0: [sda] Enabling DIF Type 1 protection
[99595.487523] sd 5:0:0:0: [sdc] Enabling DIF Type 1 protection
[99595.487530] sd 5:0:0:0: [sdc] 585937500 512-byte logical blocks: (300 GB/279 GiB)
[99595.487561] sd 5:0:1:0: [sdd] Enabling DIF Type 1 protection
[99595.487566] sd 5:0:1:0: [sdd] 585937500 512-byte logical blocks: (300 GB/279 GiB)
[99595.487567] sd 5:0:2:0: [sde] Enabling DIF Type 1 protection
[99595.487572] sd 5:0:2:0: [sde] 585937500 512-byte logical blocks: (300 GB/279 GiB)
[99595.487583] sd 4:0:1:0: [sdb] Enabling DIF Type 1 protection
[99595.487589] sd 4:0:1:0: [sdb] 585937500 512-byte logical blocks: (300 GB/279 GiB)
[99595.488500] sd 4:0:1:0: [sdb] Write Protect is off
[99595.488504] sd 4:0:1:0: [sdb] Mode Sense: e7 00 10 08
[99595.488985] sd 4:0:1:0: [sdb] Write cache: disabled, read cache: enabled, supports DPO and FUA
[99595.492381] sd 5:0:1:0: [sdd] Write Protect is off
[99595.492384] sd 5:0:1:0: [sdd] Mode Sense: e7 00 10 08
[99595.492387] sd 5:0:2:0: [sde] Write Protect is off
[99595.492390] sd 5:0:2:0: [sde] Mode Sense: e7 00 10 08
[99595.492396] sd 5:0:0:0: [sdc] Write Protect is off
[99595.492400] sd 5:0:0:0: [sdc] Mode Sense: e7 00 10 08
[99595.492891] sd 5:0:1:0: [sdd] Write cache: disabled, read cache: enabled, supports DPO and FUA
[99595.492907] sd 5:0:2:0: [sde] Write cache: disabled, read cache: enabled, supports DPO and FUA
[99595.492915] sd 5:0:0:0: [sdc] Write cache: disabled, read cache: enabled, supports DPO and FUA
[99595.497242]  sdb: sdb1 sdb2 sdb3 sdb7
[99595.500715]  sdc: sdc1 sdc2 sdc3 sdc7
[99595.500718]  sdd: sdd1 sdd2 sdd3 sdd7
[99595.500721]  sde: sde1 sde2 sde3
[99595.506066] sd 4:0:1:0: [sdb] Attached SCSI disk
[99595.512323] sd 5:0:2:0: [sde] Attached SCSI disk
[99595.512447] sd 5:0:1:0: [sdd] Attached SCSI disk
[99595.512452] sd 5:0:0:0: [sdc] Attached SCSI disk
[99597.807230] sd 4:0:0:0: [sda] 585937500 512-byte logical blocks: (300 GB/279 GiB)
[99597.913800] sd 4:0:0:0: [sda] Write Protect is off
[99597.981961] sd 4:0:0:0: [sda] Mode Sense: e7 00 10 08
[99598.053548] sd 4:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[99598.182142]  sda: sda1 sda2 sda3
[99598.234500] sd 4:0:0:0: [sda] Attached SCSI disk
[99598.467691] dracut: Scanning devices sda2 sde2  for LVM logical volumes VolGroup/lv_swap VolGroup/lv_root 
[99598.941161] dracut: inactive '/dev/VolGroup/lv_root' [274.38 GiB] inherit
[99599.037555] dracut: inactive '/dev/VolGroup/lv_swap' [4.00 GiB] inherit
[99599.132490] dracut: inactive '/dev/vg/root' [10.00 GiB] inherit
[99599.215798] dracut: inactive '/dev/vg/swap' [2.00 GiB] inherit
[99599.297845] dracut: inactive '/dev/vg/tmpdir' [10.00 GiB] inherit
[99599.383575] dracut: inactive '/dev/vg/mountpoint' [5.00 GiB] inherit
[99599.797911] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null)
[99599.971525] dracut: Mounted root filesystem /dev/mapper/VolGroup-lv_root
[99600.269090] dracut: Loading SELinux policy
[99600.541574] audit: type=1404 audit(1427514289.280:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
[99600.846087] SELinux: 2048 avtab hash slots, 277818 rules.
[99601.027953] SELinux: 2048 avtab hash slots, 277818 rules.
[99601.422111] SELinux:  9 users, 12 roles, 3918 types, 217 bools, 1 sens, 1024 cats
[99601.530047] SELinux:  81 classes, 277818 rules
[99601.600355] SELinux:  Permission audit_access in class file not defined in policy.
[99601.708831] SELinux:  Permission audit_access in class dir not defined in policy.
[99601.814132] SELinux:  Permission execmod in class dir not defined in policy.
[99601.913651] SELinux:  Permission audit_access in class lnk_file not defined in policy.
[99602.029029] SELinux:  Permission open in class lnk_file not defined in policy.
[99602.130658] SELinux:  Permission execmod in class lnk_file not defined in policy.
[99602.240196] SELinux:  Permission audit_access in class chr_file not defined in policy.
[99602.351625] SELinux:  Permission audit_access in class blk_file not defined in policy.
[99602.463925] SELinux:  Permission execmod in class blk_file not defined in policy.
[99602.569658] SELinux:  Permission audit_access in class sock_file not defined in policy.
[99602.685137] SELinux:  Permission execmod in class sock_file not defined in policy.
[99602.792350] SELinux:  Permission audit_access in class fifo_file not defined in policy.
[99602.905002] SELinux:  Permission execmod in class fifo_file not defined in policy.
[99603.014037] SELinux:  Permission syslog in class capability2 not defined in policy.
[99603.121685] SELinux:  Permission wake_alarm in class capability2 not defined in policy.
[99603.235050] SELinux:  Permission block_suspend in class capability2 not defined in policy.
[99603.351377] SELinux:  Permission audit_read in class capability2 not defined in policy.
[99603.464040] SELinux:  Permission attach_queue in class tun_socket not defined in policy.
[99603.577918] SELinux:  Class binder not defined in policy.
[99603.653813] SELinux: the above unknown classes and permissions will be allowed
[99603.755458] SELinux:  Completing initialization.
[99603.820800] SELinux:  Setting up existing superblocks.
[99603.992394] audit: type=1403 audit(1427514292.732:3): policy loaded auid=4294967295 ses=4294967295
[99604.123452] dracut: 
[99606.106168] dracut: Switching root
[99609.187581] udev: starting version 147
[99609.585103] sha1_sparc64: Using sparc64 sha1 opcode optimized SHA-1 implementation
[99609.715318] sha512_sparc64: Using sparc64 sha512 opcode optimized SHA-512/SHA-384 implementation
[99609.872770] md5_sparc64: Using sparc64 md5 opcode optimized MD5 implementation
[99610.025707] des_sparc64: Using sparc64 des opcodes optimized DES implementation
[99610.146999] camellia_sparc64: Using sparc64 camellia opcodes optimized CAMELLIA implementation
[99610.315649] crc32c_sparc64: Using sparc64 crc32c opcode optimized CRC32C implementation
[99614.894973] pps_core: LinuxPPS API ver. 1 registered
[99614.964850] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[99615.115882] PTP clock support registered
[99615.280262] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 4.0.1-k
[99615.388722] ixgbe: Copyright (c) 1999-2014 Intel Corporation.
[99615.470843] PCI: Enabling device: (0000:06:00.0), cmd 2
[99615.545164] ixgbe 0000:06:00.0: enabling bus mastering
[99616.020098] ixgbe 0000:06:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63
[99616.198953] ixgbe 0000:06:00.0: PCI Express bandwidth of 32GT/s available
[99616.294710] ixgbe 0000:06:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[99616.433980] ixgbe 0000:06:00.0: MAC: 3, PHY: 0, PBA No: 000000-000
[99616.522003] ixgbe 0000:06:00.0: 00:10:e0:35:15:f6
[99616.834119] ixgbe 0000:06:00.0: Intel(R) 10 Gigabit Network Connection
[99616.926306] PCI: Enabling device: (0000:06:00.1), cmd 2
[99616.998903] ixgbe 0000:06:00.1: enabling bus mastering
[99617.475785] ixgbe 0000:06:00.1: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63
[99617.655311] ixgbe 0000:06:00.1: PCI Express bandwidth of 32GT/s available
[99617.752233] ixgbe 0000:06:00.1: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[99617.894125] ixgbe 0000:06:00.1: MAC: 3, PHY: 0, PBA No: 000000-000
[99617.980939] ixgbe 0000:06:00.1: 00:10:e0:35:15:f7
[99618.293397] ixgbe 0000:06:00.1: Intel(R) 10 Gigabit Network Connection
[99618.386539] PCI: Enabling device: (000f:75:00.0), cmd 2
[99618.460358] ixgbe 000f:75:00.0: enabling bus mastering
[99618.929983] ixgbe 000f:75:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63
[99619.108845] ixgbe 000f:75:00.0: PCI Express bandwidth of 32GT/s available
[99619.204348] ixgbe 000f:75:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[99619.344961] ixgbe 000f:75:00.0: MAC: 3, PHY: 0, PBA No: 000000-000
[99619.432566] ixgbe 000f:75:00.0: 00:10:e0:35:15:f8
[99619.742724] ixgbe 000f:75:00.0: Intel(R) 10 Gigabit Network Connection
[99619.837738] PCI: Enabling device: (000f:75:00.1), cmd 2
[99619.911152] ixgbe 000f:75:00.1: enabling bus mastering
[99620.380276] ixgbe 000f:75:00.1: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63
[99620.562492] ixgbe 000f:75:00.1: PCI Express bandwidth of 32GT/s available
[99620.658105] ixgbe 000f:75:00.1: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[99620.800997] ixgbe 000f:75:00.1: MAC: 3, PHY: 0, PBA No: 000000-000
[99620.885884] ixgbe 000f:75:00.1: 00:10:e0:35:15:f9
[99621.199165] ixgbe 000f:75:00.1: Intel(R) 10 Gigabit Network Connection
[99621.369395] sd 4:0:0:0: Attached scsi generic sg0 type 0
[99621.444713] sd 4:0:1:0: Attached scsi generic sg1 type 0
[99621.521116] sd 5:0:0:0: Attached scsi generic sg2 type 0
[99621.596335] sd 5:0:1:0: Attached scsi generic sg3 type 0
[99621.671617] sd 5:0:2:0: Attached scsi generic sg4 type 0
[99621.888362] xhci_hcd 0000:05:00.0: enabling bus mastering
[99621.964233] xhci_hcd 0000:05:00.0: xHCI Host Controller
[99622.039329] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus number 1
[99622.148868] xhci_hcd 0000:05:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x00000010
[99622.268143] xhci_hcd 0000:05:00.0: enabling Mem-Wr-Inval
[99622.352567] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[99622.448311] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[99622.549923] usb usb1: Product: xHCI Host Controller
[99622.618448] usb usb1: Manufacturer: Linux 4.0.0-rc5+ xhci-hcd
[99622.699839] usb usb1: SerialNumber: 0000:05:00.0
[99622.765055] hub 1-0:1.0: USB hub found
[99622.817581] hub 1-0:1.0: 4 ports detected
[99622.874182] xhci_hcd 0000:05:00.0: xHCI Host Controller
[99622.947624] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus number 2
[99623.051781] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[99623.147191] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[99623.249641] usb usb2: Product: xHCI Host Controller
[99623.318165] usb usb2: Manufacturer: Linux 4.0.0-rc5+ xhci-hcd
[99623.399830] usb usb2: SerialNumber: 0000:05:00.0
[99623.464967] hub 2-0:1.0: USB hub found
[99623.517493] hub 2-0:1.0: 4 ports detected
[99623.572559] xhci_hcd 000f:76:00.0: enabling bus mastering
[99623.583276] usb 1-3: new high-speed USB device number 2 using xhci_hcd
[99623.745847] xhci_hcd 000f:76:00.0: xHCI Host Controller
[99623.820529] xhci_hcd 000f:76:00.0: new USB bus registered, assigned bus number 3
[99623.929984] xhci_hcd 000f:76:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x00000010
[99624.050245] xhci_hcd 000f:76:00.0: enabling Mem-Wr-Inval
[99624.134171] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[99624.195740] usb 1-3: New USB device found, idVendor=090c, idProduct=1000
[99624.195743] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[99624.195745] usb 1-3: Product: USB DISK
[99624.195746] usb 1-3: Manufacturer: SMI Corporation
[99624.195749] usb 1-3: SerialNumber: 2011081500000723
[99624.195899] usb 1-3: ep 0x81 - rounding interval to 128 microframes, ep desc says 255 microframes
[99624.195911] usb 1-3: ep 0x2 - rounding interval to 128 microframes, ep desc says 255 microframes
[99624.865755] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[99624.968158] usb usb3: Product: xHCI Host Controller
[99625.036706] usb usb3: Manufacturer: Linux 4.0.0-rc5+ xhci-hcd
[99625.117501] usb usb3: SerialNumber: 000f:76:00.0
[99625.182792] hub 3-0:1.0: USB hub found
[99625.235319] hub 3-0:1.0: 4 ports detected
[99625.291826] xhci_hcd 000f:76:00.0: xHCI Host Controller
[99625.365312] xhci_hcd 000f:76:00.0: new USB bus registered, assigned bus number 4
[99625.469504] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[99625.564899] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[99625.666666] usb usb4: Product: xHCI Host Controller
[99625.735604] usb usb4: Manufacturer: Linux 4.0.0-rc5+ xhci-hcd
[99625.816506] usb usb4: SerialNumber: 000f:76:00.0
[99625.881572] hub 4-0:1.0: USB hub found
[99625.934097] hub 4-0:1.0: 4 ports detected
[99626.223612] usb-storage 1-3:1.0: USB Mass Storage device detected
[99626.310511] scsi host6: usb-storage 1-3:1.0
[99626.369314] usbcore: registered new interface driver usb-storage
[99627.465271] scsi 6:0:0:0: Direct-Access     SMI      USB DISK         3000 PQ: 0 ANSI: 0 CCS
[99627.589364] sd 6:0:0:0: Attached scsi generic sg5 type 0
[99627.589379] sd 6:0:0:0: [sdf] 62652416 512-byte logical blocks: (32.0 GB/29.8 GiB)
[99627.601804] sd 6:0:0:0: [sdf] Write Protect is off
[99627.601808] sd 6:0:0:0: [sdf] Mode Sense: 43 00 00 00
[99627.602568] sd 6:0:0:0: [sdf] No Caching mode page found
[99627.602571] sd 6:0:0:0: [sdf] Assuming drive cache: write through
[99627.608756]  sdf: sdf1 sdf2 sdf3
[99627.613943] sd 6:0:0:0: [sdf] Attached SCSI removable disk
[99629.188686] EXT4-fs (dm-0): re-mounted. Opts: (null)
[99630.087314] kjournald starting.  Commit interval 5 seconds
[99630.098100] EXT3-fs (sde1): using internal journal
[99630.098104] EXT3-fs (sde1): mounted filesystem with ordered data mode
[99631.290149] Adding 4194296k swap on /dev/mapper/VolGroup-lv_swap.  Priority:-1 extents:1 across:4194296k FS
[99635.813745] NET: Registered protocol family 10
[99636.912008] pps pps0: new PPS source ptp0
[99636.968275] ixgbe 0000:06:00.0: registered PHC device on eth0
[99637.273621] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[99640.194121] ixgbe 0000:06:00.0 eth0: NIC Link is Up 1 Gbps, Flow Control: RX/TX
[99640.298014] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[99640.304172] audit: type=1305 audit(1427514329.044:4): audit_pid=11694 old=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:auditd_t:s0 res=1

--------------040102070402050608050007--
