From: BERTRAND Joel <joel.bertrand@systella.fr>
Date: Sat, 04 Sep 2010 15:14:53 +0000
Subject: [2.6.34.5] Parport panics
Message-Id: <4C82626D.2050108@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	One of my UltraSparc Blade 2000 has crashed during an apt-get 
dist-upgrade. Panic is reproductible. Kernel is 2.6.34.5 from 
kernel.org. I never see any panic with 2.6.34.1.

	I have check difference between 2.6.34.1 and 2.6.34.5 without success.

	Here is panic message :

Sep  4 12:09:37 rayleigh kernel: ERROR(1): Cheetah error trap taken 
afsr[0010100000000000] afar[0000000000000020] TL1(0)
Sep  4 12:09:37 rayleigh kernel: ERROR(1): TPC[1057c3dc] TNPC[1057c3e0] 
O7[1057c3cc] TSTATE[9911001607]
Sep  4 12:09:37 rayleigh kernel: ERROR(1): 
TPC<parport_pc_init+0x308/0x60c [parport_pc]>
Sep  4 12:09:37 rayleigh kernel: ERROR(1): M_SYND(0),  E_SYND(0), Privileged
Sep  4 12:09:37 rayleigh kernel: ERROR(1): Highest priority error 
(0000100000000000) "Unmapped error from system bus"
Sep  4 12:09:37 rayleigh kernel: ERROR(1): D-cache idx[0] 
tag[0000000000000000] utag[0000000000000000] stag[0000000000000000]
Sep  4 12:09:37 rayleigh kernel: ERROR(1): D-cache 
data0[0000000000000000] data1[0000000000000000] data2[0000000000000000] 
data3[0000000000000000]
Sep  4 12:09:37 rayleigh kernel: ERROR(1): I-cache idx[0] 
tag[0000000000000000] utag[0000000000000000] stag[0000000000000000] 
u[0000000000000000] l[0000000000000000]
Sep  4 12:09:37 rayleigh kernel: ERROR(1): I-cache 
INSN0[0000000000000000] INSN1[0000000000000000] INSN2[0000000000000000] 
INSN3[0000000000000000]
Sep  4 12:09:37 rayleigh kernel: ERROR(1): I-cache 
INSN4[0000000000000000] INSN5[0000000000000000] INSN6[0000000000000000] 
INSN7[0000000000000000]
Sep  4 12:09:37 rayleigh kernel: ERROR(1): E-cache idx[20] 
tag[0000000000000001]
Sep  4 12:09:37 rayleigh kernel: ERROR(1): E-cache 
data0[0000000000000000] data1[0000000000000000] data2[0000000000000000] 
data3[0000000000000000]
Sep  4 12:09:37 rayleigh kernel: Kernel panic - not syncing: 
Irrecoverable deferred error trap.
Sep  4 12:09:37 rayleigh kernel:
Sep  4 12:09:37 rayleigh kernel: Call Trace:
Sep  4 12:09:37 rayleigh kernel: [000000000042958c] 
cheetah_deferred_handler+0x26c/0x540
Sep  4 12:09:37 rayleigh kernel: [0000000000405e70] c_deferred+0x18/0x24
Sep  4 12:09:37 rayleigh kernel: [000000001057c3dc] 
parport_pc_init+0x308/0x60c [parport_pc]
Sep  4 12:09:37 rayleigh kernel: [0000000000426ab8] 
do_one_initcall+0x18/0x180
Sep  4 12:09:37 rayleigh kernel: [0000000000491e68] 
SyS_init_module+0xc8/0x220
Sep  4 12:09:37 rayleigh kernel: [0000000000406154] 
linux_sparc_syscall32+0x34/0x40
Sep  4 12:09:37 rayleigh kernel: Press Stop-A (L1-A) to return to the 
boot prom

	Regards,

	JKB
