From: David Ahern <david.ahern@oracle.com>
Date: Sat, 28 Mar 2015 00:32:56 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <5515F6B8.8020606@oracle.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030006090303010302040702"
List-Id: <sparclinux.vger.kernel.org>
References: <5514391F.2030300@oracle.com>	<CAE9FiQXw3QUCNNZj2SVhn-AYWWnggT=7JXPkGNpYFzq-qAB1aQ@mail.gmail.com>	<551495EE.20201@oracle.com>	<CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com> <CAE9FiQWwU4gsq4y0+BTMtisBGQDxF1m_pxAT62PmP-Ct+O1c5A@mail.gmail.com>
In-Reply-To: <CAE9FiQWwU4gsq4y0+BTMtisBGQDxF1m_pxAT62PmP-Ct+O1c5A@mail.gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------030006090303010302040702
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/15 5:57 PM, Yinghai Lu wrote:
> On Fri, Mar 27, 2015 at 2:01 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Thu, Mar 26, 2015 at 4:27 PM, David Ahern <david.ahern@oracle.com> wrote:
>
>> Also please make sure your config have
>>
>> CONFIG_PCI_DEBUG=y
>>
>> and capture serial console with "debug ignore_loglevel", so we check if
>> pci 0000:00:01.0 really have resource assigned.
>
> Please check attached patch and send out boot log with above config.

patched applied. PCI_DEBUG enabled. options added. log attached. This is 
with d63e2e1f3df reverted still.


--------------030006090303010302040702
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg"

PROMLIB: Sun IEEE Boot Prom 'OBP 4.36.2 2014/10/24 08:15'
PROMLIB: Root node compatible: sun4v
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Initializing cgroup subsys cpuacct
Linux version 4.0.0-rc5+ (root@ca-qasparc24) (gcc version 4.4.7 20120313 (Red Hat 4.4.7-4.0.9) (GCC) ) #2 SMP Fri Mar 27 20:12:10 EDT 2015
debug: skip boot console de-registration.
debug: ignoring loglevel setting.
bootconsole [earlyprom0] enabled
ARCH: SUN4V
Ethernet address: 00:10:e0:35:15:f6
MM: PAGE_OFFSET is 0xfff8000000000000 (max_phys_bits == 47)
MM: VMALLOC [0x0000000100000000 --> 0x0006000000000000]
MM: VMEMMAP [0x0006000000000000 --> 0x000c000000000000]
Kernel: Using 3 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /virtual-devices@100/console@1
PROM: Built device tree with 1478490 bytes of memory.
MDESC: Size is 774368 bytes.
PLATFORM: banner-name [SPARC T5-8]
PLATFORM: name [ORCL,SPARC-T5-8]
PLATFORM: hostid [863515f6]
PLATFORM: serial# [003515f6]
PLATFORM: stick-frequency [3b9aca00]
PLATFORM: mac-address [10e03515f6]
PLATFORM: watchdog-resolution [1000 ms]
PLATFORM: watchdog-max-timeout [31536000000 ms]
PLATFORM: max-cpus [1024]
Allocated 81920 bytes for kernel page tables.
Zone ranges:
  DMA      [mem 0x0000000030400000-0xffffffffffffffff]
  Normal   [mem 0x0000000000000000-0x0000383fffd11fff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000030400000-0x0000003fddeeffff]
  node   0: [mem 0x0000003fddef6000-0x0000003fddef7fff]
  node   1: [mem 0x0000080000000000-0x0000083fffffffff]
  node   2: [mem 0x0000100000000000-0x0000103fffffffff]
  node   3: [mem 0x0000180000000000-0x0000183fffffffff]
  node   4: [mem 0x0000200000000000-0x0000203fffffffff]
  node   5: [mem 0x0000280000000000-0x0000283fffffffff]
  node   6: [mem 0x0000300000000000-0x0000303fffffffff]
  node   7: [mem 0x0000380000000000-0x0000383fffcddfff]
  node   7: [mem 0x0000383fffcee000-0x0000383fffd11fff]
Initmem setup node 0 [mem 0x0000000030400000-0x0000003fddef7fff]
On node 0 totalpages: 33385849
  Normal zone: 293431 pages used for memmap
  Normal zone: 33385849 pages, LIFO batch:15
Initmem setup node 1 [mem 0x0000080000000000-0x0000083fffffffff]
On node 1 totalpages: 33554432
  Normal zone: 294912 pages used for memmap
  Normal zone: 33554432 pages, LIFO batch:15
Initmem setup node 2 [mem 0x0000100000000000-0x0000103fffffffff]
On node 2 totalpages: 33554432
  Normal zone: 294912 pages used for memmap
  Normal zone: 33554432 pages, LIFO batch:15
Initmem setup node 3 [mem 0x0000180000000000-0x0000183fffffffff]
On node 3 totalpages: 33554432
  Normal zone: 294912 pages used for memmap
  Normal zone: 33554432 pages, LIFO batch:15
Initmem setup node 4 [mem 0x0000200000000000-0x0000203fffffffff]
On node 4 totalpages: 33554432
  Normal zone: 294912 pages used for memmap
  Normal zone: 33554432 pages, LIFO batch:15
Initmem setup node 5 [mem 0x0000280000000000-0x0000283fffffffff]
On node 5 totalpages: 33554432
  Normal zone: 294912 pages used for memmap
  Normal zone: 33554432 pages, LIFO batch:15
Initmem setup node 6 [mem 0x0000300000000000-0x0000303fffffffff]
On node 6 totalpages: 33554432
  Normal zone: 294912 pages used for memmap
  Normal zone: 33554432 pages, LIFO batch:15
Initmem setup node 7 [mem 0x0000380000000000-0x0000383fffd11fff]
On node 7 totalpages: 33554049
  Normal zone: 294909 pages used for memmap
  Normal zone: 33554049 pages, LIFO batch:15
Booting Linux...
CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]
CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit,fmaf,vis3]
CPU CAPS: [hpc,ima,pause,cbcond,aes,des,kasumi,camellia]
CPU CAPS: [md5,sha1,sha256,sha512,mpmul,montmul,montsqr,crc32c]
PERCPU: Embedded 8 pages/cpu @fff8003f4d000000 s27776 r8192 d29568 u65536
pcpu-alloc: s27776 r8192 d29568 u65536 alloc=1*4194304
pcpu-alloc: [0] 0000 0001 0002 0003 0004 0005 0006 0007 0008 0009 0010 0011 0012 0013 0014 0015 0016 0017 0018 0019 0020 0021 0022 0023 0024 0025 0026 0027 0028 0029 0030 0031 0032 0033 0034 0035 0036 0037 0038 0039 0040 0041 0042 0043 0044 0045 0046 0047 0048 0049 0050 0051 0052 0053 0054 0055 0056 0057 0058 0059 0060 0061 0062 0063 
pcpu-alloc: [0] 0064 0065 0066 0067 0068 0069 0070 0071 0072 0073 0074 0075 0076 0077 0078 0079 0080 0081 0082 0083 0084 0085 0086 0087 0088 0089 0090 0091 0092 0093 0094 0095 0096 0097 0098 0099 0100 0101 0102 0103 0104 0105 0106 0107 0108 0109 0110 0111 0112 0113 0114 0115 0116 0117 0118 0119 0120 0121 0122 0123 0124 0125 0126 0127 
pcpu-alloc: [1] 0128 0129 0130 0131 0132 0133 0134 0135 0136 0137 0138 0139 0140 0141 0142 0143 0144 0145 0146 0147 0148 0149 0150 0151 0152 0153 0154 0155 0156 0157 0158 0159 0160 0161 0162 0163 0164 0165 0166 0167 0168 0169 0170 0171 0172 0173 0174 0175 0176 0177 0178 0179 0180 0181 0182 0183 0184 0185 0186 0187 0188 0189 0190 0191 
pcpu-alloc: [1] 0192 0193 0194 0195 0196 0197 0198 0199 0200 0201 0202 0203 0204 0205 0206 0207 0208 0209 0210 0211 0212 0213 0214 0215 0216 0217 0218 0219 0220 0221 0222 0223 0224 0225 0226 0227 0228 0229 0230 0231 0232 0233 0234 0235 0236 0237 0238 0239 0240 0241 0242 0243 0244 0245 0246 0247 0248 0249 0250 0251 0252 0253 0254 0255 
pcpu-alloc: [2] 0256 0257 0258 0259 0260 0261 0262 0263 0264 0265 0266 0267 0268 0269 0270 0271 0272 0273 0274 0275 0276 0277 0278 0279 0280 0281 0282 0283 0284 0285 0286 0287 0288 0289 0290 0291 0292 0293 0294 0295 0296 0297 0298 0299 0300 0301 0302 0303 0304 0305 0306 0307 0308 0309 0310 0311 0312 0313 0314 0315 0316 0317 0318 0319 
pcpu-alloc: [2] 0320 0321 0322 0323 0324 0325 0326 0327 0328 0329 0330 0331 0332 0333 0334 0335 0336 0337 0338 0339 0340 0341 0342 0343 0344 0345 0346 0347 0348 0349 0350 0351 0352 0353 0354 0355 0356 0357 0358 0359 0360 0361 0362 0363 0364 0365 0366 0367 0368 0369 0370 0371 0372 0373 0374 0375 0376 0377 0378 0379 0380 0381 0382 0383 
pcpu-alloc: [3] 0384 0385 0386 0387 0388 0389 0390 0391 0392 0393 0394 0395 0396 0397 0398 0399 0400 0401 0402 0403 0404 0405 0406 0407 0408 0409 0410 0411 0412 0413 0414 0415 0416 0417 0418 0419 0420 0421 0422 0423 0424 0425 0426 0427 0428 0429 0430 0431 0432 0433 0434 0435 0436 0437 0438 0439 0440 0441 0442 0443 0444 0445 0446 0447 
pcpu-alloc: [3] 0448 0449 0450 0451 0452 0453 0454 0455 0456 0457 0458 0459 0460 0461 0462 0463 0464 0465 0466 0467 0468 0469 0470 0471 0472 0473 0474 0475 0476 0477 0478 0479 0480 0481 0482 0483 0484 0485 0486 0487 0488 0489 0490 0491 0492 0493 0494 0495 0496 0497 0498 0499 0500 0501 0502 0503 0504 0505 0506 0507 0508 0509 0510 0511 
pcpu-alloc: [4] 0512 0513 0514 0515 0516 0517 0518 0519 0520 0521 0522 0523 0524 0525 0526 0527 0528 0529 0530 0531 0532 0533 0534 0535 0536 0537 0538 0539 0540 0541 0542 0543 0544 0545 0546 0547 0548 0549 0550 0551 0552 0553 0554 0555 0556 0557 0558 0559 0560 0561 0562 0563 0564 0565 0566 0567 0568 0569 0570 0571 0572 0573 0574 0575 
pcpu-alloc: [4] 0576 0577 0578 0579 0580 0581 0582 0583 0584 0585 0586 0587 0588 0589 0590 0591 0592 0593 0594 0595 0596 0597 0598 0599 0600 0601 0602 0603 0604 0605 0606 0607 0608 0609 0610 0611 0612 0613 0614 0615 0616 0617 0618 0619 0620 0621 0622 0623 0624 0625 0626 0627 0628 0629 0630 0631 0632 0633 0634 0635 0636 0637 0638 0639 
pcpu-alloc: [5] 0640 0641 0642 0643 0644 0645 0646 0647 0648 0649 0650 0651 0652 0653 0654 0655 0656 0657 0658 0659 0660 0661 0662 0663 0664 0665 0666 0667 0668 0669 0670 0671 0672 0673 0674 0675 0676 0677 0678 0679 0680 0681 0682 0683 0684 0685 0686 0687 0688 0689 0690 0691 0692 0693 0694 0695 0696 0697 0698 0699 0700 0701 0702 0703 
pcpu-alloc: [5] 0704 0705 0706 0707 0708 0709 0710 0711 0712 0713 0714 0715 0716 0717 0718 0719 0720 0721 0722 0723 0724 0725 0726 0727 0728 0729 0730 0731 0732 0733 0734 0735 0736 0737 0738 0739 0740 0741 0742 0743 0744 0745 0746 0747 0748 0749 0750 0751 0752 0753 0754 0755 0756 0757 0758 0759 0760 0761 0762 0763 0764 0765 0766 0767 
pcpu-alloc: [6] 0768 0769 0770 0771 0772 0773 0774 0775 0776 0777 0778 0779 0780 0781 0782 0783 0784 0785 0786 0787 0788 0789 0790 0791 0792 0793 0794 0795 0796 0797 0798 0799 0800 0801 0802 0803 0804 0805 0806 0807 0808 0809 0810 0811 0812 0813 0814 0815 0816 0817 0818 0819 0820 0821 0822 0823 0824 0825 0826 0827 0828 0829 0830 0831 
pcpu-alloc: [6] 0832 0833 0834 0835 0836 0837 0838 0839 0840 0841 0842 0843 0844 0845 0846 0847 0848 0849 0850 0851 0852 0853 0854 0855 0856 0857 0858 0859 0860 0861 0862 0863 0864 0865 0866 0867 0868 0869 0870 0871 0872 0873 0874 0875 0876 0877 0878 0879 0880 0881 0882 0883 0884 0885 0886 0887 0888 0889 0890 0891 0892 0893 0894 0895 
pcpu-alloc: [7] 0896 0897 0898 0899 0900 0901 0902 0903 0904 0905 0906 0907 0908 0909 0910 0911 0912 0913 0914 0915 0916 0917 0918 0919 0920 0921 0922 0923 0924 0925 0926 0927 0928 0929 0930 0931 0932 0933 0934 0935 0936 0937 0938 0939 0940 0941 0942 0943 0944 0945 0946 0947 0948 0949 0950 0951 0952 0953 0954 0955 0956 0957 0958 0959 
pcpu-alloc: [7] 0960 0961 0962 0963 0964 0965 0966 0967 0968 0969 0970 0971 0972 0973 0974 0975 0976 0977 0978 0979 0980 0981 0982 0983 0984 0985 0986 0987 0988 0989 0990 0991 0992 0993 0994 0995 0996 0997 0998 0999 1000 1001 1002 1003 1004 1005 1006 1007 1008 1009 1010 1011 1012 1013 1014 1015 1016 1017 1018 1019 1020 1021 1022 1023 
SUN4V: Mondo queue sizes [cpu(131072) dev(16384) r(8192) nr(256)]
Built 8 zonelists in Node order, mobility grouping on.  Total pages: 265908678
Policy zone: Normal
Kernel command line: root=/dev/mapper/VolGroup-lv_root ro rd_NO_LUKS LANG=en_US.UTF-8 rd_NO_MD rd_LVM_LV=VolGroup/lv_swap SYSFONT=latarcyrheb-sun16 rd_LVM_LV=VolGroup/lv_root KEYBOARDTYPE=pc KEYTABLE=us rd_NO_DM keep_bootcon debug ignore_loglevel
log_buf_len individual max cpu contribution: 4096 bytes
log_buf_len total cpu_extra contributions: 4190208 bytes
log_buf_len min size: 1048576 bytes
log_buf_len: 8388608 bytes
early log buf free: 1036920(98%)
PID hash table entries: 4096 (order: 2, 32768 bytes)
Sorting __ex_table...
Memory: 2127126200K/2146131920K available (5730K kernel code, 937K rwdata, 2488K rodata, 544K init, 2010K bss, 19005720K reserved, 0K cma-reserved)
Hierarchical RCU implementation.
NR_IRQS:2048 nr_irqs:2048 1
SUN4V: Using IRQ API major 3, cookie only virqs enabled
clocksource: mult[800000] shift[23]
clockevent: mult[80000000] shift[31]
Console: colour dummy device 80x25
console [tty0] enabled
Calibrating delay using timer specific routine.. 2001.25 BogoMIPS (lpj=4002516)
pid_max: default: 1048576 minimum: 8192
Security Framework initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Dentry cache hash table entries: 268435456 (order: 18, 2147483648 bytes)
Inode-cache hash table entries: 134217728 (order: 17, 1073741824 bytes)
Mount-cache hash table entries: 4194304 (order: 12, 33554432 bytes)
Mountpoint-cache hash table entries: 4194304 (order: 12, 33554432 bytes)
Initializing cgroup subsys blkio
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys net_cls
Initializing cgroup subsys perf_event
Initializing cgroup subsys hugetlb
ftrace: allocating 20541 entries in 41 pages
Brought up 1024 CPUs
devtmpfs: initialized
Performance events: 
Testing NMI watchdog ... OK.
Supported PMU type is 'niagara5'
ldc.c:v1.1 (July 22, 2008)
NET: Registered protocol family 16
VIO: Adding device channel-devices
VIO: Adding device vldc-port-0-0
VIO: Adding device vldc-port-0-1
VIO: Adding device vldc-port-0-2
VIO: Adding device vldc-port-1-0
VIO: Adding device vldc-port-2-0
VIO: Adding device vldc-port-3-0
VIO: Adding device vldc-port-3-1
VIO: Adding device vldc-port-3-4
VIO: Adding device vldc-port-3-3
VIO: Adding device vlds-port-0-0
VIO: Adding device ds-0
VIO: Adding device ds-1
pci_sun4v: Registered hvapi major[1] minor[0]
/pci@300: SUN4V PCI Bus Module
/pci@300: On NUMA node -1
/pci@300: PCI IO[804000000000] MEM[800000000000]
/pci@300: Unable to request IOMMU resource.
/pci@300: Imported 26 TSB entries from OBP
/pci@300: MSI Queue first[0] num[56] count[512] devino[0x6]
/pci@300: MSI first[0] num[512] mask[0x3ff] width[32]
/pci@300: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
/pci@300: MSI queues at RA [0000383f51000000]
PCI: Scanning PBM /pci@300
pci_sun4v f02dbcfc: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x804000000000-0x80400fffffff] (bus address [0x0000-0xfffffff])
pci_bus 0000:00: root bus resource [mem 0x800000000000-0x80007effffff] (bus address [0x00000000-0x7effffff])
pci_bus 0000:00: root bus resource [bus 00-77]
pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
pci 0000:00:01.0: PME# disabled
pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
pci 0000:01:00.0: PME# disabled
pci 0000:02:04.0: PME# supported from D0 D3hot D3cold
pci 0000:02:04.0: PME# disabled
pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
pci 0000:03:00.0: PME# disabled
pci 0000:04:06.0: PME# supported from D0 D3hot D3cold
pci 0000:04:06.0: PME# disabled
pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
pci 0000:05:00.0: PME# disabled
pci 0000:04:08.0: PME# supported from D0 D3hot D3cold
pci 0000:04:08.0: PME# disabled
pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
pci 0000:06:00.0: PME# disabled
pci 0000:06:00.0: reg 0x184: [mem 0x110204000-0x110207fff 64bit]
pci 0000:06:00.0: reg 0x190: [mem 0x110304000-0x110307fff 64bit]
pci 0000:06:00.1: PME# supported from D0 D3hot D3cold
pci 0000:06:00.1: PME# disabled
pci 0000:06:00.1: reg 0x184: [mem 0x110408000-0x11040bfff 64bit]
pci 0000:06:00.1: reg 0x190: [mem 0x110800000-0x110803fff 64bit]
pci 0000:04:0c.0: PME# supported from D0 D3hot D3cold
pci 0000:04:0c.0: PME# disabled
pci 0000:07:00.0: supports D1 D2
pci 0000:02:06.0: PME# supported from D0 D3hot D3cold
pci 0000:02:06.0: PME# disabled
pci 0000:00:01.0: can't claim BAR 15 [mem 0x100000000-0x4afffffff pref]: no compatible bridge window
pci 0000:00:01.0: can't claim BAR 15 [mem 0x100000000-0x4afffffff pref]: no compatible bridge window
pci 0000:05:00.0: can't claim BAR 0 [mem 0x800100000000-0x800100001fff]: no compatible bridge window
pci 0000:06:00.0: can't claim BAR 0 [mem 0x800110000000-0x8001101fffff pref]: no compatible bridge window
pci 0000:06:00.0: can't claim BAR 4 [mem 0x800110200000-0x800110203fff pref]: no compatible bridge window
pci 0000:06:00.0: can't claim BAR 7 [mem 0x110204000-0x110303fff 64bit]: no compatible bridge window
pci 0000:06:00.0: can't claim BAR 10 [mem 0x110304000-0x110403fff 64bit]: no compatible bridge window
pci 0000:06:00.1: can't claim BAR 0 [mem 0x800110600000-0x8001107fffff pref]: no compatible bridge window
pci 0000:06:00.1: can't claim BAR 4 [mem 0x800110404000-0x800110407fff pref]: no compatible bridge window
pci 0000:06:00.1: can't claim BAR 7 [mem 0x110408000-0x110507fff 64bit]: no compatible bridge window
pci 0000:06:00.1: can't claim BAR 10 [mem 0x110800000-0x1108fffff 64bit]: no compatible bridge window
pci 0000:07:00.0: can't claim BAR 1 [mem 0x800120000000-0x80012000ffff]: no compatible bridge window
pci 0000:07:00.0: can't claim BAR 3 [mem 0x800120040000-0x80012007ffff]: no compatible bridge window
/pci@340: SUN4V PCI Bus Module
/pci@340: On NUMA node -1
/pci@340: PCI IO[804100000000] MEM[801000000000]
/pci@340: Unable to request IOMMU resource.
/pci@340: MSI Queue first[0] num[56] count[512] devino[0x6]
/pci@340: MSI first[0] num[512] mask[0x3ff] width[32]
/pci@340: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
/pci@340: MSI queues at RA [0000283f52000000]
PCI: Scanning PBM /pci@340
pci_sun4v f02eab24: PCI host bridge to bus 0001:00
pci_bus 0001:00: root bus resource [io  0x804100000000-0x80410fffffff] (bus address [0x0000-0xfffffff])
pci_bus 0001:00: root bus resource [mem 0x801000000000-0x80107effffff] (bus address [0x00000000-0x7effffff])
pci_bus 0001:00: root bus resource [bus 00-e2]
pci 0001:00:01.0: PME# supported from D0 D3hot D3cold
pci 0001:00:01.0: PME# disabled
pci 0001:01:00.0: PME# supported from D0 D3hot D3cold
pci 0001:01:00.0: PME# disabled
pci 0001:02:06.0: PME# supported from D0 D3hot D3cold
pci 0001:02:06.0: PME# disabled
pci 0001:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
pci 0001:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
/pci@380: SUN4V PCI Bus Module
/pci@380: On NUMA node -1
/pci@380: PCI IO[80c000000000] MEM[808000000000]
/pci@380: Unable to request IOMMU resource.
/pci@380: MSI Queue first[0] num[56] count[512] devino[0x6]
/pci@380: MSI first[0] num[512] mask[0x3ff] width[32]
/pci@380: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
/pci@380: MSI queues at RA [0000103f52200000]
PCI: Scanning PBM /pci@380
pci_sun4v f02f994c: PCI host bridge to bus 0002:00
pci_bus 0002:00: root bus resource [io  0x80c000000000-0x80c00fffffff] (bus address [0x0000-0xfffffff])
pci_bus 0002:00: root bus resource [mem 0x808000000000-0x80807effffff] (bus address [0x00000000-0x7effffff])
pci_bus 0002:00: root bus resource [bus 00-e2]
pci 0002:00:01.0: PME# supported from D0 D3hot D3cold
pci 0002:00:01.0: PME# disabled
pci 0002:01:00.0: PME# supported from D0 D3hot D3cold
pci 0002:01:00.0: PME# disabled
pci 0002:02:0a.0: PME# supported from D0 D3hot D3cold
pci 0002:02:0a.0: PME# disabled
pci 0002:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
pci 0002:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
pci 0002:03:00.0: can't claim BAR 1 [mem 0x808100000000-0x808100003fff]: no compatible bridge window
pci 0002:03:00.1: can't claim BAR 1 [mem 0x808100004000-0x808100007fff]: no compatible bridge window
/pci@3c0: SUN4V PCI Bus Module
/pci@3c0: On NUMA node -1
/pci@3c0: PCI IO[80c100000000] MEM[809000000000]
/pci@3c0: Unable to request IOMMU resource.
/pci@3c0: MSI Queue first[0] num[56] count[512] devino[0x6]
/pci@3c0: MSI first[0] num[512] mask[0x3ff] width[32]
/pci@3c0: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
/pci@3c0: MSI queues at RA [0000383f50a00000]
PCI: Scanning PBM /pci@3c0
pci_sun4v f0308774: PCI host bridge to bus 0003:00
pci_bus 0003:00: root bus resource [io  0x80c100000000-0x80c10fffffff] (bus address [0x0000-0xfffffff])
pci_bus 0003:00: root bus resource [mem 0x809000000000-0x80907effffff] (bus address [0x00000000-0x7effffff])
pci_bus 0003:00: root bus resource [bus 00-e2]
pci 0003:00:01.0: PME# supported from D0 D3hot D3cold
pci 0003:00:01.0: PME# disabled
pci 0003:01:00.0: PME# supported from D0 D3hot D3cold
pci 0003:01:00.0: PME# disabled
pci 0003:02:0e.0: PME# supported from D0 D3hot D3cold
pci 0003:02:0e.0: PME# disabled
pci 0003:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
pci 0003:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
/pci@400: SUN4V PCI Bus Module
/pci@400: On NUMA node -1
/pci@400: PCI IO[814000000000] MEM[810000000000]
/pci@400: Unable to request IOMMU resource.
/pci@400: MSI Queue first[0] num[56] count[512] devino[0x6]
/pci@400: MSI first[0] num[512] mask[0x3ff] width[32]
/pci@400: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
/pci@400: MSI queues at RA [0000203f52200000]
PCI: Scanning PBM /pci@400
pci_sun4v f031759c: PCI host bridge to bus 0004:00
pci_bus 0004:00: root bus resource [io  0x814000000000-0x81400fffffff] (bus address [0x0000-0xfffffff])
pci_bus 0004:00: root bus resource [mem 0x810000000000-0x81007effffff] (bus address [0x00000000-0x7effffff])
pci_bus 0004:00: root bus resource [bus 00-72]
pci 0004:00:01.0: PME# supported from D0 D3hot D3cold
pci 0004:00:01.0: PME# disabled
pci 0004:01:00.0: PME# supported from D0 D3hot D3cold
pci 0004:01:00.0: PME# disabled
pci 0004:02:0c.0: PME# supported from D0 D3hot D3cold
pci 0004:02:0c.0: PME# disabled
pci 0004:00:01.0: can't claim BAR 15 [mem 0x100000000-0x47fffffff pref]: no compatible bridge window
pci 0004:00:01.0: can't claim BAR 15 [mem 0x100000000-0x47fffffff pref]: no compatible bridge window
/pci@440: SUN4V PCI Bus Module
/pci@440: On NUMA node -1
/pci@440: PCI IO[814100000000] MEM[811000000000]
/pci@440: Unable to request IOMMU resource.
/pci@440: MSI Queue first[0] num[56] count[512] devino[0x6]
/pci@440: MSI first[0] num[512] mask[0x3ff] width[32]
/pci@440: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
/pci@440: MSI queues at RA [0000103f52400000]
PCI: Scanning PBM /pci@440
pci_sun4v f03263c4: PCI host bridge to bus 0005:00
pci_bus 0005:00: root bus resource [io  0x814100000000-0x81410fffffff] (bus address [0x0000-0xfffffff])
pci_bus 0005:00: root bus resource [mem 0x811000000000-0x81107effffff] (bus address [0x00000000-0x7effffff])
pci_bus 0005:00: root bus resource [bus 00-e2]
pci 0005:00:01.0: PME# supported from D0 D3hot D3cold
pci 0005:00:01.0: PME# disabled
pci 0005:01:00.0: PME# supported from D0 D3hot D3cold
pci 0005:01:00.0: PME# disabled
pci 0005:02:0c.0: PME# supported from D0 D3hot D3cold
pci 0005:02:0c.0: PME# disabled
pci 0005:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
pci 0005:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
/pci@480: SUN4V PCI Bus Module
/pci@480: On NUMA node -1
/pci@480: PCI IO[81c000000000] MEM[818000000000]
/pci@480: Unable to request IOMMU resource.
/pci@480: MSI Queue first[0] num[56] count[512] devino[0x6]
/pci@480: MSI first[0] num[512] mask[0x3ff] width[32]
/pci@480: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
/pci@480: MSI queues at RA [0000383f50c00000]
PCI: Scanning PBM /pci@480
pci_sun4v f03351ec: PCI host bridge to bus 0006:00
pci_bus 0006:00: root bus resource [io  0x81c000000000-0x81c00fffffff] (bus address [0x0000-0xfffffff])
pci_bus 0006:00: root bus resource [mem 0x818000000000-0x81807effffff] (bus address [0x00000000-0x7effffff])
pci_bus 0006:00: root bus resource [bus 00-e2]
pci 0006:00:01.0: PME# supported from D0 D3hot D3cold
pci 0006:00:01.0: PME# disabled
pci 0006:01:00.0: PME# supported from D0 D3hot D3cold
pci 0006:01:00.0: PME# disabled
pci 0006:02:04.0: PME# supported from D0 D3hot D3cold
pci 0006:02:04.0: PME# disabled
pci 0006:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
pci 0006:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
/pci@4c0: SUN4V PCI Bus Module
/pci@4c0: On NUMA node -1
/pci@4c0: PCI IO[81c100000000] MEM[819000000000]
/pci@4c0: Unable to request IOMMU resource.
/pci@4c0: MSI Queue first[0] num[56] count[512] devino[0x6]
/pci@4c0: MSI first[0] num[512] mask[0x3ff] width[32]
/pci@4c0: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
/pci@4c0: MSI queues at RA [0000203f52400000]
PCI: Scanning PBM /pci@4c0
pci_sun4v f0344014: PCI host bridge to bus 0007:00
pci_bus 0007:00: root bus resource [io  0x81c100000000-0x81c10fffffff] (bus address [0x0000-0xfffffff])
pci_bus 0007:00: root bus resource [mem 0x819000000000-0x81907effffff] (bus address [0x00000000-0x7effffff])
pci_bus 0007:00: root bus resource [bus 00-e2]
pci 0007:00:01.0: PME# supported from D0 D3hot D3cold
pci 0007:00:01.0: PME# disabled
pci 0007:01:00.0: PME# supported from D0 D3hot D3cold
pci 0007:01:00.0: PME# disabled
pci 0007:02:08.0: PME# supported from D0 D3hot D3cold
pci 0007:02:08.0: PME# disabled
pci 0007:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
pci 0007:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
/pci@500: SUN4V PCI Bus Module
/pci@500: On NUMA node -1
/pci@500: PCI IO[824000000000] MEM[820000000000]
/pci@500: Unable to request IOMMU resource.
/pci@500: MSI Queue first[0] num[56] count[512] devino[0x6]
/pci@500: MSI first[0] num[512] mask[0x3ff] width[32]
/pci@500: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
/pci@500: MSI queues at RA [0000103f52600000]
PCI: Scanning PBM /pci@500
pci_sun4v f0352e3c: PCI host bridge to bus 0008:00
pci_bus 0008:00: root bus resource [io  0x824000000000-0x82400fffffff] (bus address [0x0000-0xfffffff])
pci_bus 0008:00: root bus resource [mem 0x820000000000-0x82007effffff] (bus address [0x00000000-0x7effffff])
pci_bus 0008:00: root bus resource [bus 00-e2]
pci 0008:00:01.0: PME# supported from D0 D3hot D3cold
pci 0008:00:01.0: PME# disabled
pci 0008:01:00.0: PME# supported from D0 D3hot D3cold
pci 0008:01:00.0: PME# disabled
pci 0008:02:0e.0: PME# supported from D0 D3hot D3cold
pci 0008:02:0e.0: PME# disabled
pci 0008:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
pci 0008:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
/pci@540: SUN4V PCI Bus Module
/pci@540: On NUMA node -1
/pci@540: PCI IO[824100000000] MEM[821000000000]
/pci@540: Unable to request IOMMU resource.
/pci@540: MSI Queue first[0] num[56] count[512] devino[0x6]
/pci@540: MSI first[0] num[512] mask[0x3ff] width[32]
/pci@540: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
/pci@540: MSI queues at RA [0000303f52000000]
PCI: Scanning PBM /pci@540
pci_sun4v f0361c64: PCI host bridge to bus 0009:00
pci_bus 0009:00: root bus resource [io  0x824100000000-0x82410fffffff] (bus address [0x0000-0xfffffff])
pci_bus 0009:00: root bus resource [mem 0x821000000000-0x82107effffff] (bus address [0x00000000-0x7effffff])
pci_bus 0009:00: root bus resource [bus 00-e2]
pci 0009:00:01.0: PME# supported from D0 D3hot D3cold
pci 0009:00:01.0: PME# disabled
pci 0009:01:00.0: PME# supported from D0 D3hot D3cold
pci 0009:01:00.0: PME# disabled
pci 0009:02:0e.0: PME# supported from D0 D3hot D3cold
pci 0009:02:0e.0: PME# disabled
pci 0009:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
pci 0009:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
/pci@580: SUN4V PCI Bus Module
/pci@580: On NUMA node -1
/pci@580: PCI IO[82c000000000] MEM[828000000000]
/pci@580: Unable to request IOMMU resource.
/pci@580: MSI Queue first[0] num[56] count[512] devino[0x6]
/pci@580: MSI first[0] num[512] mask[0x3ff] width[32]
/pci@580: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
/pci@580: MSI queues at RA [0000203f52600000]
PCI: Scanning PBM /pci@580
pci_sun4v f0370a8c: PCI host bridge to bus 000a:00
pci_bus 000a:00: root bus resource [io  0x82c000000000-0x82c00fffffff] (bus address [0x0000-0xfffffff])
pci_bus 000a:00: root bus resource [mem 0x828000000000-0x82807effffff] (bus address [0x00000000-0x7effffff])
pci_bus 000a:00: root bus resource [bus 00-e2]
pci 000a:00:01.0: PME# supported from D0 D3hot D3cold
pci 000a:00:01.0: PME# disabled
pci 000a:01:00.0: PME# supported from D0 D3hot D3cold
pci 000a:01:00.0: PME# disabled
pci 000a:02:0a.0: PME# supported from D0 D3hot D3cold
pci 000a:02:0a.0: PME# disabled
pci 000a:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
pci 000a:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
/pci@5c0: SUN4V PCI Bus Module
/pci@5c0: On NUMA node -1
/pci@5c0: PCI IO[82c100000000] MEM[829000000000]
/pci@5c0: Unable to request IOMMU resource.
/pci@5c0: MSI Queue first[0] num[56] count[512] devino[0x6]
/pci@5c0: MSI first[0] num[512] mask[0x3ff] width[32]
/pci@5c0: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
/pci@5c0: MSI queues at RA [0000083f52c00000]
PCI: Scanning PBM /pci@5c0
pci_sun4v f037f8b4: PCI host bridge to bus 000b:00
pci_bus 000b:00: root bus resource [io  0x82c100000000-0x82c10fffffff] (bus address [0x0000-0xfffffff])
pci_bus 000b:00: root bus resource [mem 0x829000000000-0x82907effffff] (bus address [0x00000000-0x7effffff])
pci_bus 000b:00: root bus resource [bus 00-72]
pci 000b:00:01.0: PME# supported from D0 D3hot D3cold
pci 000b:00:01.0: PME# disabled
pci 000b:01:00.0: PME# supported from D0 D3hot D3cold
pci 000b:01:00.0: PME# disabled
pci 000b:02:08.0: PME# supported from D0 D3hot D3cold
pci 000b:02:08.0: PME# disabled
pci 000b:00:01.0: can't claim BAR 15 [mem 0x100000000-0x47fffffff pref]: no compatible bridge window
pci 000b:00:01.0: can't claim BAR 15 [mem 0x100000000-0x47fffffff pref]: no compatible bridge window
/pci@600: SUN4V PCI Bus Module
/pci@600: On NUMA node -1
/pci@600: PCI IO[834000000000] MEM[830000000000]
/pci@600: Unable to request IOMMU resource.
/pci@600: MSI Queue first[0] num[56] count[512] devino[0x6]
/pci@600: MSI first[0] num[512] mask[0x3ff] width[32]
/pci@600: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
/pci@600: MSI queues at RA [0000383f50e00000]
PCI: Scanning PBM /pci@600
pci_sun4v f038e6dc: PCI host bridge to bus 000c:00
pci_bus 000c:00: root bus resource [io  0x834000000000-0x83400fffffff] (bus address [0x0000-0xfffffff])
pci_bus 000c:00: root bus resource [mem 0x830000000000-0x83007effffff] (bus address [0x00000000-0x7effffff])
pci_bus 000c:00: root bus resource [bus 00-e2]
pci 000c:00:01.0: PME# supported from D0 D3hot D3cold
pci 000c:00:01.0: PME# disabled
pci 000c:01:00.0: PME# supported from D0 D3hot D3cold
pci 000c:01:00.0: PME# disabled
pci 000c:02:08.0: PME# supported from D0 D3hot D3cold
pci 000c:02:08.0: PME# disabled
pci 000c:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
pci 000c:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
/pci@640: SUN4V PCI Bus Module
/pci@640: On NUMA node -1
/pci@640: PCI IO[834100000000] MEM[831000000000]
/pci@640: Unable to request IOMMU resource.
/pci@640: MSI Queue first[0] num[56] count[512] devino[0x6]
/pci@640: MSI first[0] num[512] mask[0x3ff] width[32]
/pci@640: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
/pci@640: MSI queues at RA [0000283f52200000]
PCI: Scanning PBM /pci@640
pci_sun4v f039d504: PCI host bridge to bus 000d:00
pci_bus 000d:00: root bus resource [io  0x834100000000-0x83410fffffff] (bus address [0x0000-0xfffffff])
pci_bus 000d:00: root bus resource [mem 0x831000000000-0x83107effffff] (bus address [0x00000000-0x7effffff])
pci_bus 000d:00: root bus resource [bus 00-e2]
pci 000d:00:01.0: PME# supported from D0 D3hot D3cold
pci 000d:00:01.0: PME# disabled
pci 000d:01:00.0: PME# supported from D0 D3hot D3cold
pci 000d:01:00.0: PME# disabled
pci 000d:02:08.0: PME# supported from D0 D3hot D3cold
pci 000d:02:08.0: PME# disabled
pci 000d:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
pci 000d:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
pci 000d:03:00.0: can't claim BAR 0 [mem 0x831100000000-0x831100001fff]: no compatible bridge window
pci 000d:03:00.0: can't claim BAR 2 [mem 0x831100004000-0x831100007fff]: no compatible bridge window
pci 000d:03:00.1: can't claim BAR 0 [mem 0x831100002000-0x831100003fff]: no compatible bridge window
pci 000d:03:00.1: can't claim BAR 2 [mem 0x831100008000-0x83110000bfff]: no compatible bridge window
/pci@680: SUN4V PCI Bus Module
/pci@680: On NUMA node -1
/pci@680: PCI IO[83c000000000] MEM[838000000000]
/pci@680: Unable to request IOMMU resource.
/pci@680: MSI Queue first[0] num[56] count[512] devino[0x6]
/pci@680: MSI first[0] num[512] mask[0x3ff] width[32]
/pci@680: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
/pci@680: MSI queues at RA [0000003f22e00000]
PCI: Scanning PBM /pci@680
pci_sun4v f03ac32c: PCI host bridge to bus 000e:00
pci_bus 000e:00: root bus resource [io  0x83c000000000-0x83c00fffffff] (bus address [0x0000-0xfffffff])
pci_bus 000e:00: root bus resource [mem 0x838000000000-0x83807effffff] (bus address [0x00000000-0x7effffff])
pci_bus 000e:00: root bus resource [bus 00-e2]
pci 000e:00:01.0: PME# supported from D0 D3hot D3cold
pci 000e:00:01.0: PME# disabled
pci 000e:01:00.0: PME# supported from D0 D3hot D3cold
pci 000e:01:00.0: PME# disabled
pci 000e:02:04.0: PME# supported from D0 D3hot D3cold
pci 000e:02:04.0: PME# disabled
pci 000e:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
pci 000e:00:01.0: can't claim BAR 15 [mem 0x100000000-0x7efffffff pref]: no compatible bridge window
/pci@6c0: SUN4V PCI Bus Module
/pci@6c0: On NUMA node -1
/pci@6c0: PCI IO[83c100000000] MEM[839000000000]
/pci@6c0: Unable to request IOMMU resource.
/pci@6c0: Imported 13 TSB entries from OBP
/pci@6c0: MSI Queue first[0] num[56] count[512] devino[0x6]
/pci@6c0: MSI first[0] num[512] mask[0x3ff] width[32]
/pci@6c0: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
/pci@6c0: MSI queues at RA [0000303f52200000]
PCI: Scanning PBM /pci@6c0
pci_sun4v f03bb154: PCI host bridge to bus 000f:00
pci_bus 000f:00: root bus resource [io  0x83c100000000-0x83c10fffffff] (bus address [0x0000-0xfffffff])
pci_bus 000f:00: root bus resource [mem 0x839000000000-0x83907effffff] (bus address [0x00000000-0x7effffff])
pci_bus 000f:00: root bus resource [bus 00-78]
pci 000f:00:01.0: PME# supported from D0 D3hot D3cold
pci 000f:00:01.0: PME# disabled
pci 000f:01:00.0: PME# supported from D0 D3hot D3cold
pci 000f:01:00.0: PME# disabled
pci 000f:02:04.0: PME# supported from D0 D3hot D3cold
pci 000f:02:04.0: PME# disabled
pci 000f:02:0c.0: PME# supported from D0 D3hot D3cold
pci 000f:02:0c.0: PME# disabled
pci 000f:73:00.0: PME# supported from D0 D3hot D3cold
pci 000f:73:00.0: PME# disabled
pci 000f:74:04.0: PME# supported from D0 D3hot D3cold
pci 000f:74:04.0: PME# disabled
pci 000f:75:00.0: PME# supported from D0 D3hot D3cold
pci 000f:75:00.0: PME# disabled
pci 000f:75:00.0: reg 0x184: [mem 0x480204000-0x480207fff 64bit]
pci 000f:75:00.0: reg 0x190: [mem 0x480304000-0x480307fff 64bit]
pci 000f:75:00.1: PME# supported from D0 D3hot D3cold
pci 000f:75:00.1: PME# disabled
pci 000f:75:00.1: reg 0x184: [mem 0x480408000-0x48040bfff 64bit]
pci 000f:75:00.1: reg 0x190: [mem 0x480800000-0x480803fff 64bit]
pci 000f:74:06.0: PME# supported from D0 D3hot D3cold
pci 000f:74:06.0: PME# disabled
pci 000f:76:00.0: PME# supported from D0 D3hot D3cold
pci 000f:76:00.0: PME# disabled
pci 000f:74:07.0: PME# supported from D0 D3hot D3cold
pci 000f:74:07.0: PME# disabled
pci 000f:74:0c.0: PME# supported from D0 D3hot D3cold
pci 000f:74:0c.0: PME# disabled
pci 000f:78:00.0: supports D1 D2
pci 000f:00:01.0: can't claim BAR 15 [mem 0x100000000-0x4afffffff pref]: no compatible bridge window
pci 000f:00:01.0: can't claim BAR 15 [mem 0x100000000-0x4afffffff pref]: no compatible bridge window
pci 000f:75:00.0: can't claim BAR 0 [mem 0x839480000000-0x8394801fffff pref]: no compatible bridge window
pci 000f:75:00.0: can't claim BAR 4 [mem 0x839480200000-0x839480203fff pref]: no compatible bridge window
pci 000f:75:00.0: can't claim BAR 7 [mem 0x480204000-0x480303fff 64bit]: no compatible bridge window
pci 000f:75:00.0: can't claim BAR 10 [mem 0x480304000-0x480403fff 64bit]: no compatible bridge window
pci 000f:75:00.1: can't claim BAR 0 [mem 0x839480600000-0x8394807fffff pref]: no compatible bridge window
pci 000f:75:00.1: can't claim BAR 4 [mem 0x839480404000-0x839480407fff pref]: no compatible bridge window
pci 000f:75:00.1: can't claim BAR 7 [mem 0x480408000-0x480507fff 64bit]: no compatible bridge window
pci 000f:75:00.1: can't claim BAR 10 [mem 0x480800000-0x4808fffff 64bit]: no compatible bridge window
pci 000f:76:00.0: can't claim BAR 0 [mem 0x839490000000-0x839490001fff]: no compatible bridge window
pci 000f:78:00.0: can't claim BAR 1 [mem 0x8394a0000000-0x8394a000ffff]: no compatible bridge window
pci 000f:78:00.0: can't claim BAR 3 [mem 0x8394a0040000-0x8394a007ffff]: no compatible bridge window
vgaarb: device added: PCI:000f:77:00.0,decodes=io+mem,owns=none,locks=none
vgaarb: loaded
vgaarb: bridge control possible 000f:77:00.0
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
SUN4V: Reboot data supported (maj=1,min=0).
ds.c:v1.0 (Jul 11, 2007)
Switched to clocksource stick
ds-1: Registered pri service.
ds-1: Registered var-config-backup service.
NET: Registered protocol family 2
TCP established hash table entries: 524288 (order: 9, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP: reno registered
UDP hash table entries: 65536 (order: 8, 2097152 bytes)
UDP-Lite hash table entries: 65536 (order: 8, 2097152 bytes)
NET: Registered protocol family 1
pci 0000:05:00.0: calling quirk_usb_early_handoff+0x0/0x220
pci 0000:05:00.0: xHCI BIOS handoff failed (BIOS bug ?) 00010401
pci 0000:06:00.0: calling quirk_e100_interrupt+0x0/0x220
pci 0000:06:00.1: calling quirk_e100_interrupt+0x0/0x220
pci 000f:75:00.0: calling quirk_e100_interrupt+0x0/0x220
pci 000f:75:00.1: calling quirk_e100_interrupt+0x0/0x220
pci 000f:76:00.0: calling quirk_usb_early_handoff+0x0/0x220
pci 000f:76:00.0: xHCI BIOS handoff failed (BIOS bug ?) 00010401
PCI: CLS mismatch (64 != 512), using 64 bytes
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 7456K (fff8380004000000 - fff8380004748000)
futex hash table entries: 262144 (order: 11, 16777216 bytes)
Initialise system trusted keyring
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(18.252:1): initialized
HugeTLB registered 8 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
VFS: Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
SELinux:  Registering netfilter hooks
alg: No test for stdrng (krng)
Key type asymmetric registered
Asymmetric key parser 'x509' registered
bounce: pool size: 64 pages
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
io scheduler noop registered
io scheduler deadline registered (default)
io scheduler cfq registered
f0290cf4: ttyS0 at I/O 0x0 (irq = 1, base_baud = 115200) is a SUN4V HCONS
console [ttyHV0] enabled
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
brd: module loaded
loop: module loaded
zram: Created 1 device(s)
libphy: Fixed MDIO Bus: probed
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
uhci_hcd: USB Universal Host Controller Interface driver
mousedev: PS/2 mouse device common for all mice
rtc-sun4v rtc-sun4v: rtc core: registered sun4v as rtc0
hidraw: raw HID events driver (C) Jiri Kosina
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
drop_monitor: Initializing network drop monitor service
TCP: cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 17
Key type dns_resolver registered
Loading compiled-in X.509 certificates
Loaded X.509 cert 'Magrathea: Glacier signing key: 0ec1e3ae3ed5a95c3d5d67431d9bd97634dafbd8'
registered taskstats version 1
ima: No TPM chip found, activating TPM-bypass!
rtc-sun4v rtc-sun4v: setting system clock to 2015-03-28 00:31:15 UTC (1427502675)
dracut: dracut-004-336.0.2.el6_5.2
dracut: rd_NO_LUKS: removing cryptoluks activation
dm_mod: module verification failed: signature and/or required key missing - tainting kernel
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.30.0-ioctl (2014-12-22) initialised: dm-devel@redhat.com
udev: starting version 147
dracut: Starting plymouth daemon
sha256_sparc64: Using sparc64 sha256 opcode optimized SHA-256/SHA-224 implementation
aes_sparc64: Using sparc64 aes opcodes optimized AES implementation
qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 8.07.00.16-k.
qla2xxx [0002:03:00.0]-001d: : Found an ISP2532 irq 11 iobase 0x0000808100000000.
qla2xxx 0002:03:00.0: enabling Mem-Wr-Inval
scsi host0: qla2xxx
qla2xxx [0002:03:00.0]-00fb:0: QLogic QLE2562 - Sun StorageTek 8Gb FC PCIe HBA, dual port.
qla2xxx [0002:03:00.0]-00fc:0: ISP2532: PCIe (2.5GT/s x8) @ 0002:03:00.0 hdma- host#=0 fw=7.03.00 (90d5).
qla2xxx [0002:03:00.0]-500a:0: LOOP UP detected (8 Gbps).
qla2xxx [0002:03:00.1]-001d: : Found an ISP2532 irq 12 iobase 0x0000808100004000.
qla2xxx 0002:03:00.1: enabling Mem-Wr-Inval
qla2xxx [0002:03:00.0]-2064:0: SNS scan failed -- assuming zero-entry result.
scsi host1: qla2xxx
qla2xxx [0002:03:00.1]-00fb:1: QLogic QLE2562 - Sun StorageTek 8Gb FC PCIe HBA, dual port.
qla2xxx [0002:03:00.1]-00fc:1: ISP2532: PCIe (2.5GT/s x8) @ 0002:03:00.1 hdma- host#=1 fw=7.03.00 (90d5).
Emulex LightPulse Fibre Channel SCSI driver 10.4.8000.0.
Copyright(c) 2004-2014 Emulex.  All rights reserved.
lpfc 000d:03:00.0: enabling Mem-Wr-Inval
scsi host2: Emulex LPe12000-S PCIe Fibre Channel Adapter  on PCI bus 03 device 00 irq 35
lpfc 000d:03:00.1: enabling Mem-Wr-Inval
scsi host3: Emulex LPe12000-S PCIe Fibre Channel Adapter  on PCI bus 03 device 01 irq 36
mpt2sas version 20.100.00.00 loaded
mpt2sas 0000:07:00.0: enabling bus mastering
mpt2sas0: 32 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (2127134200 kB)
mpt2sas0: MSI-X vectors supported: 8, no of cores: 1024, max_msix_vectors: 8
mpt2sas0-msix0: PCI-MSI-X enabled: IRQ 973
mpt2sas0-msix1: PCI-MSI-X enabled: IRQ 974
mpt2sas0-msix2: PCI-MSI-X enabled: IRQ 975
mpt2sas0-msix3: PCI-MSI-X enabled: IRQ 976
mpt2sas0-msix4: PCI-MSI-X enabled: IRQ 977
mpt2sas0-msix5: PCI-MSI-X enabled: IRQ 978
mpt2sas0-msix6: PCI-MSI-X enabled: IRQ 979
mpt2sas0-msix7: PCI-MSI-X enabled: IRQ 980
mpt2sas0: iomem(0x0000800120000000), mapped(0x0000800120000000), size(65536)
mpt2sas0: ioport(0x0000804000001000), size(256)
mpt2sas0: Allocated physical memory: size(4603 kB)
mpt2sas0: Current Controller Queue Depth(2811), Max Controller Queue Depth(3072)
mpt2sas0: Scatter Gather Elements per IO(128)
mpt2sas0: LSISAS2308: FWVersion(14.00.00.00), ChipRevision(0x05), BiosVersion(00.00.00.00)
mpt2sas0: Protocol=(Initiator), Capabilities=(Raid,TLR,EEDP,Snapshot Buffer,Diag Trace Buffer,Task Set Full,NCQ)
scsi host4: Fusion MPT SAS Host
mpt2sas0: sending port enable !!
mpt2sas1: 32 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (2127134200 kB)
mpt2sas1: MSI-X vectors supported: 8, no of cores: 1024, max_msix_vectors: 8
mpt2sas1-msix0: PCI-MSI-X enabled: IRQ 981
mpt2sas1-msix1: PCI-MSI-X enabled: IRQ 982
mpt2sas1-msix2: PCI-MSI-X enabled: IRQ 983
mpt2sas1-msix3: PCI-MSI-X enabled: IRQ 984
mpt2sas1-msix4: PCI-MSI-X enabled: IRQ 985
mpt2sas1-msix5: PCI-MSI-X enabled: IRQ 986
mpt2sas1-msix6: PCI-MSI-X enabled: IRQ 987
mpt2sas1-msix7: PCI-MSI-X enabled: IRQ 988
mpt2sas1: iomem(0x00008394a0000000), mapped(0x00008394a0000000), size(65536)
mpt2sas1: ioport(0x000083c104001000), size(256)
mpt2sas1: Allocated physical memory: size(4603 kB)
mpt2sas1: Current Controller Queue Depth(2811), Max Controller Queue Depth(3072)
mpt2sas1: Scatter Gather Elements per IO(128)
mpt2sas0: host_add: handle(0x0001), sas_addr(0x508002000159c0d0), phys(8)
mpt2sas1: LSISAS2308: FWVersion(14.00.00.00), ChipRevision(0x05), BiosVersion(00.00.00.00)
mpt2sas1: Protocol=(Initiator), Capabilities=(Raid,TLR,EEDP,Snapshot Buffer,Diag Trace Buffer,Task Set Full,NCQ)
scsi host5: Fusion MPT SAS Host
mpt2sas1: sending port enable !!
mpt2sas1: host_add: handle(0x0001), sas_addr(0x508002000159c0d1), phys(8)
mpt2sas0: port enable: SUCCESS
scsi 4:0:0:0: Direct-Access     HITACHI  H109030SESUN300G A31A PQ: 0 ANSI: 6
scsi 4:0:0:0: SSP: handle(0x0009), sas_addr(0x5000cca0163295b1), phy(1), device_name(0x5000cca0163295b3)
scsi 4:0:0:0: SSP: enclosure_logical_id(0x508002000159c0d0), slot(1)
scsi 4:0:1:0: Direct-Access     HITACHI  H109030SESUN300G A31A PQ: 0 ANSI: 6
scsi 4:0:1:0: SSP: handle(0x000a), sas_addr(0x5000cca0162a4c1d), phy(2), device_name(0x5000cca0162a4c1f)
qla2xxx [0002:03:00.1]-8038:1: Cable is unplugged...
scsi 4:0:1:0: SSP: enclosure_logical_id(0x508002000159c0d0), slot(2)
mpt2sas1: port enable: SUCCESS
scsi 5:0:0:0: Direct-Access     HITACHI  H109030SESUN300G A31A PQ: 0 ANSI: 6
scsi 5:0:0:0: SSP: handle(0x0009), sas_addr(0x5000cca0162f2e39), phy(0), device_name(0x5000cca0162f2e3b)
scsi 5:0:0:0: SSP: enclosure_logical_id(0x508002000159c0d1), slot(0)
scsi 5:0:1:0: Direct-Access     HITACHI  H109030SESUN300G A31A PQ: 0 ANSI: 6
scsi 5:0:1:0: SSP: handle(0x000a), sas_addr(0x5000cca016322ee5), phy(1), device_name(0x5000cca016322ee7)
scsi 5:0:1:0: SSP: enclosure_logical_id(0x508002000159c0d1), slot(1)
scsi 5:0:2:0: Direct-Access     HITACHI  H109030SESUN300G A31A PQ: 0 ANSI: 6
scsi 5:0:2:0: SSP: handle(0x000b), sas_addr(0x5000cca016322f71), phy(2), device_name(0x5000cca016322f73)
scsi 5:0:2:0: SSP: enclosure_logical_id(0x508002000159c0d1), slot(2)
sd 4:0:0:0: [sda] Enabling DIF Type 1 protection
sd 4:0:1:0: [sdb] Enabling DIF Type 1 protection
sd 4:0:1:0: [sdb] 585937500 512-byte logical blocks: (300 GB/279 GiB)
sd 5:0:0:0: [sdc] Enabling DIF Type 1 protection
sd 5:0:0:0: [sdc] 585937500 512-byte logical blocks: (300 GB/279 GiB)
sd 5:0:1:0: [sdd] Enabling DIF Type 1 protection
sd 5:0:1:0: [sdd] 585937500 512-byte logical blocks: (300 GB/279 GiB)
sd 5:0:2:0: [sde] Enabling DIF Type 1 protection
sd 5:0:2:0: [sde] 585937500 512-byte logical blocks: (300 GB/279 GiB)
sd 4:0:1:0: [sdb] Write Protect is off
sd 4:0:1:0: [sdb] Mode Sense: e7 00 10 08
sd 5:0:0:0: [sdc] Write Protect is off
sd 5:0:0:0: [sdc] Mode Sense: e7 00 10 08
sd 5:0:1:0: [sdd] Write Protect is off
sd 5:0:1:0: [sdd] Mode Sense: e7 00 10 08
sd 5:0:2:0: [sde] Write Protect is off
sd 5:0:2:0: [sde] Mode Sense: e7 00 10 08
sd 4:0:1:0: [sdb] Write cache: disabled, read cache: enabled, supports DPO and FUA
sd 5:0:0:0: [sdc] Write cache: disabled, read cache: enabled, supports DPO and FUA
sd 5:0:1:0: [sdd] Write cache: disabled, read cache: enabled, supports DPO and FUA
sd 5:0:2:0: [sde] Write cache: disabled, read cache: enabled, supports DPO and FUA
 sde: sde1 sde2 sde3
 sdd: sdd1 sdd2 sdd3 sdd7
random: nonblocking pool is initialized
 sdb: sdb1 sdb2 sdb3 sdb7
 sdc: sdc1 sdc2 sdc3 sdc7
sd 4:0:1:0: [sdb] Attached SCSI disk
sd 5:0:1:0: [sdd] Attached SCSI disk
sd 5:0:2:0: [sde] Attached SCSI disk
sd 5:0:0:0: [sdc] Attached SCSI disk
sd 4:0:0:0: [sda] 585937500 512-byte logical blocks: (300 GB/279 GiB)
sd 4:0:0:0: [sda] Write Protect is off
sd 4:0:0:0: [sda] Mode Sense: e7 00 10 08
sd 4:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
 sda: sda1 sda2 sda3
sd 4:0:0:0: [sda] Attached SCSI disk
dracut: Scanning devices sda2 sde2  for LVM logical volumes VolGroup/lv_swap VolGroup/lv_root 
dracut: inactive '/dev/VolGroup/lv_root' [274.38 GiB] inherit
dracut: inactive '/dev/VolGroup/lv_swap' [4.00 GiB] inherit
dracut: inactive '/dev/vg/root' [10.00 GiB] inherit
dracut: inactive '/dev/vg/swap' [2.00 GiB] inherit
dracut: inactive '/dev/vg/tmpdir' [10.00 GiB] inherit
dracut: inactive '/dev/vg/mountpoint' [5.00 GiB] inherit
EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null)
dracut: Mounted root filesystem /dev/mapper/VolGroup-lv_root
dracut: Loading SELinux policy
audit: type=1404 audit(1427502714.060:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
SELinux: 2048 avtab hash slots, 277818 rules.
SELinux: 2048 avtab hash slots, 277818 rules.
SELinux:  9 users, 12 roles, 3918 types, 217 bools, 1 sens, 1024 cats
SELinux:  81 classes, 277818 rules
SELinux:  Permission audit_access in class file not defined in policy.
SELinux:  Permission audit_access in class dir not defined in policy.
SELinux:  Permission execmod in class dir not defined in policy.
SELinux:  Permission audit_access in class lnk_file not defined in policy.
SELinux:  Permission open in class lnk_file not defined in policy.
SELinux:  Permission execmod in class lnk_file not defined in policy.
SELinux:  Permission audit_access in class chr_file not defined in policy.
SELinux:  Permission audit_access in class blk_file not defined in policy.
SELinux:  Permission execmod in class blk_file not defined in policy.
SELinux:  Permission audit_access in class sock_file not defined in policy.
SELinux:  Permission execmod in class sock_file not defined in policy.
SELinux:  Permission audit_access in class fifo_file not defined in policy.
SELinux:  Permission execmod in class fifo_file not defined in policy.
SELinux:  Permission syslog in class capability2 not defined in policy.
SELinux:  Permission wake_alarm in class capability2 not defined in policy.
SELinux:  Permission block_suspend in class capability2 not defined in policy.
SELinux:  Permission audit_read in class capability2 not defined in policy.
SELinux:  Permission attach_queue in class tun_socket not defined in policy.
SELinux:  Class binder not defined in policy.
SELinux: the above unknown classes and permissions will be allowed
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
audit: type=1403 audit(1427502716.972:3): policy loaded auid=4294967295 ses=4294967295
dracut: 
dracut: Switching root
udev: starting version 147
sha1_sparc64: Using sparc64 sha1 opcode optimized SHA-1 implementation
sha512_sparc64: Using sparc64 sha512 opcode optimized SHA-512/SHA-384 implementation
md5_sparc64: Using sparc64 md5 opcode optimized MD5 implementation
des_sparc64: Using sparc64 des opcodes optimized DES implementation
camellia_sparc64: Using sparc64 camellia opcodes optimized CAMELLIA implementation
crc32c_sparc64: Using sparc64 crc32c opcode optimized CRC32C implementation
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 4.0.1-k
ixgbe: Copyright (c) 1999-2014 Intel Corporation.
PCI: Enabling device: (0000:06:00.0), cmd 2
ixgbe 0000:06:00.0: enabling bus mastering
ixgbe 0000:06:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63
ixgbe 0000:06:00.0: PCI Express bandwidth of 32GT/s available
ixgbe 0000:06:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
ixgbe 0000:06:00.0: MAC: 3, PHY: 0, PBA No: 000000-000
ixgbe 0000:06:00.0: 00:10:e0:35:15:f6
ixgbe 0000:06:00.0: Intel(R) 10 Gigabit Network Connection
PCI: Enabling device: (0000:06:00.1), cmd 2
ixgbe 0000:06:00.1: enabling bus mastering
ixgbe 0000:06:00.1: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63
ixgbe 0000:06:00.1: PCI Express bandwidth of 32GT/s available
ixgbe 0000:06:00.1: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
ixgbe 0000:06:00.1: MAC: 3, PHY: 0, PBA No: 000000-000
ixgbe 0000:06:00.1: 00:10:e0:35:15:f7
ixgbe 0000:06:00.1: Intel(R) 10 Gigabit Network Connection
PCI: Enabling device: (000f:75:00.0), cmd 2
ixgbe 000f:75:00.0: enabling bus mastering
ixgbe 000f:75:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63
ixgbe 000f:75:00.0: PCI Express bandwidth of 32GT/s available
ixgbe 000f:75:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
ixgbe 000f:75:00.0: MAC: 3, PHY: 0, PBA No: 000000-000
ixgbe 000f:75:00.0: 00:10:e0:35:15:f8
ixgbe 000f:75:00.0: Intel(R) 10 Gigabit Network Connection
PCI: Enabling device: (000f:75:00.1), cmd 2
ixgbe 000f:75:00.1: enabling bus mastering
ixgbe 000f:75:00.1: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63
ixgbe 000f:75:00.1: PCI Express bandwidth of 32GT/s available
ixgbe 000f:75:00.1: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
ixgbe 000f:75:00.1: MAC: 3, PHY: 0, PBA No: 000000-000
ixgbe 000f:75:00.1: 00:10:e0:35:15:f9
ixgbe 000f:75:00.1: Intel(R) 10 Gigabit Network Connection
xhci_hcd 0000:05:00.0: enabling bus mastering
xhci_hcd 0000:05:00.0: xHCI Host Controller
xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus number 1
xhci_hcd 0000:05:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x00000010
xhci_hcd 0000:05:00.0: enabling Mem-Wr-Inval
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: xHCI Host Controller
usb usb1: Manufacturer: Linux 4.0.0-rc5+ xhci-hcd
usb usb1: SerialNumber: 0000:05:00.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
xhci_hcd 0000:05:00.0: xHCI Host Controller
xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus number 2
usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: xHCI Host Controller
usb usb2: Manufacturer: Linux 4.0.0-rc5+ xhci-hcd
usb usb2: SerialNumber: 0000:05:00.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
xhci_hcd 000f:76:00.0: enabling bus mastering
usb 1-3: new high-speed USB device number 2 using xhci_hcd
xhci_hcd 000f:76:00.0: xHCI Host Controller
xhci_hcd 000f:76:00.0: new USB bus registered, assigned bus number 3
xhci_hcd 000f:76:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x00000010
xhci_hcd 000f:76:00.0: enabling Mem-Wr-Inval
usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: xHCI Host Controller
usb usb3: Manufacturer: Linux 4.0.0-rc5+ xhci-hcd
usb 1-3: New USB device found, idVendor=090c, idProduct=1000
usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-3: Product: USB DISK
usb 1-3: Manufacturer: SMI Corporation
usb 1-3: SerialNumber: 2011081500000723
usb 1-3: ep 0x81 - rounding interval to 128 microframes, ep desc says 255 microframes
usb 1-3: ep 0x2 - rounding interval to 128 microframes, ep desc says 255 microframes
usb usb3: SerialNumber: 000f:76:00.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
xhci_hcd 000f:76:00.0: xHCI Host Controller
xhci_hcd 000f:76:00.0: new USB bus registered, assigned bus number 4
usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: xHCI Host Controller
usb usb4: Manufacturer: Linux 4.0.0-rc5+ xhci-hcd
usb usb4: SerialNumber: 000f:76:00.0
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 4 ports detected
sd 4:0:0:0: Attached scsi generic sg0 type 0
sd 4:0:1:0: Attached scsi generic sg1 type 0
sd 5:0:0:0: Attached scsi generic sg2 type 0
sd 5:0:1:0: Attached scsi generic sg3 type 0
sd 5:0:2:0: Attached scsi generic sg4 type 0
usb-storage 1-3:1.0: USB Mass Storage device detected
scsi host6: usb-storage 1-3:1.0
usbcore: registered new interface driver usb-storage
scsi 6:0:0:0: Direct-Access     SMI      USB DISK         3000 PQ: 0 ANSI: 0 CCS
sd 6:0:0:0: [sdf] 62652416 512-byte logical blocks: (32.0 GB/29.8 GiB)
sd 6:0:0:0: Attached scsi generic sg5 type 0
sd 6:0:0:0: [sdf] Write Protect is off
sd 6:0:0:0: [sdf] Mode Sense: 43 00 00 00
sd 6:0:0:0: [sdf] No Caching mode page found
sd 6:0:0:0: [sdf] Assuming drive cache: write through
 sdf: sdf1 sdf2 sdf3
sd 6:0:0:0: [sdf] Attached SCSI removable disk
EXT4-fs (dm-0): re-mounted. Opts: (null)
kjournald starting.  Commit interval 5 seconds
EXT3-fs (sde1): using internal journal
EXT3-fs (sde1): mounted filesystem with ordered data mode
Adding 4194296k swap on /dev/mapper/VolGroup-lv_swap.  Priority:-1 extents:1 across:4194296k FS
NET: Registered protocol family 10
pps pps0: new PPS source ptp0
ixgbe 0000:06:00.0: registered PHC device on eth0
IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
audit: type=1305 audit(1427502750.796:4): audit_pid=11679 old=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:auditd_t:s0 res=1
ixgbe 0000:06:00.0 eth0: NIC Link is Up 1 Gbps, Flow Control: RX/TX
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

--------------030006090303010302040702--
