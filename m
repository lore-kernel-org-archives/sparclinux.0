From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Mon, 18 Feb 2008 13:56:09 +0000
Subject: Re: [Ann] SparcV8 depot
Message-Id: <47B98E79.4080007@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <47B6AE0B.1090906@systella.fr>
In-Reply-To: <47B6AE0B.1090906@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Good news,

	With kernel (2.6.24.2) and libc6 I have uploaded, SS20 boots fine with 
dual RT626 (double CPU module). At this time, I don't see any strange 
memory error I have seen with older kernel. I shall try with four RT626 
this evening, but it sounds good :

hilbert:[~] > cat /proc/cpuinfo
cpu             : ROSS HyperSparc RT625 or RT626
fpu             : ROSS HyperSparc combined IU/FPU
promlib         : Version 3 Revision 2
prom            : 2.25
type            : sun4m
ncpus probed    : 2
ncpus active    : 2
Cpu0Bogo        : 199.88
Cpu1Bogo        : 199.88
MMU type        : ROSS HyperSparc
contexts        : 4096
nocache total   : 5242880
nocache used    : 904704
State:
CPU0            : online
CPU1            : online

	I only receive in dmesg :

WARNING: at mm/vmalloc.c:105 vmap_pte_range()
[f005a93c : sys_init_module+0x70/0x1b64 ] [f00155c8 : 
syscall_is_too_hard+0x3c/0x40 ] [000133b8 : 0x133c0 ]
WARNING: at mm/vmalloc.c:105 vmap_pte_range()
[f005a93c : sys_init_module+0x70/0x1b64 ] [f00155c8 : 
syscall_is_too_hard+0x3c/0x40 ] [000133b8 : 0x133c0 ]
WARNING: at mm/vmalloc.c:105 vmap_pte_range()
[f005a93c : sys_init_module+0x70/0x1b64 ] [f00155c8 : 
syscall_is_too_hard+0x3c/0x40 ] [000133b8 : 0x133c0 ]
WARNING: at mm/vmalloc.c:105 vmap_pte_range()
[f005a93c : sys_init_module+0x70/0x1b64 ] [f00155c8 : 
syscall_is_too_hard+0x3c/0x40 ] [000133b8 : 0x133c0 ]

but I can obtain the same message with SuperSPARC-II.

	Regards,

	JKB
