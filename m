From: Meelis Roos <mroos@linux.ee>
Date: Fri, 01 Jun 2012 12:55:40 +0000
Subject: dme1737 crash at dme1737_isa_detect+0x10/0xe0
Message-Id: <alpine.SOC.1.00.1206011548150.10517@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

dme1737 module load on sparc64 (V210) causes this kind of trap causing 
reboot. I will leave this module out in the future anyway but is there 
something we want to fix to help curious people like me shhoting 
themselves in the leg? Like disabling the ISA part on anything but x86 & 
amd64 beacuse it assumes PC IO ports, or fixing the IO ports to be any 
32-bit or 64-bit address, or ...?

[  407.293598] ERROR(0): Cheetah error trap taken afsr[0000400000000000] afar[0000000000000020] TL1(0)
[  407.412619] ERROR(0): TPC[102e0010] TNPC[102e0014] O7[100649f8] TSTATE[4411001600]
[  407.512264] ERROR(0): TPC<dme1737_isa_detect+0x10/0xe0 [dme1737]>
[  407.592384] ERROR(0): M_SYND(0),  E_SYND(0)
[  407.647284] ERROR(0): Highest priority error (0000400000000000) "Error due to unsupported store"
[  407.762825] ERROR(0): AFAR E-syndrome [???]
[  407.817810] ERROR(0): D-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000]
[  407.942501] ERROR(0): D-cache data0[0000000000000000] data1[0000000000000000] data2[0000000000000000] data3[0000000000000000]
[  408.091301] ERROR(0): I-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000] u[0000000000000000] l[0000000000000000]
[  408.261830] ERROR(0): I-cache INSN0[0000000000000000] INSN1[0000000000000000] INSN2[0000000000000000] INSN3[0000000000000000]
[  408.410622] ERROR(0): I-cache INSN4[0000000000000000] INSN5[0000000000000000] INSN6[0000000000000000] INSN7[0000000000000000]
[  408.559413] ERROR(0): E-cache idx[20] tag[00000000000406c5]
[  408.632703] ERROR(0): E-cache data0[00000000ffb9e1a5] data1[fffff8101b143f60] data2[0000000000913a88] data3[0000000100000001]
[  408.781471] /pci@1f,700000: Safari/JBUS interrupt, UNMAPPED error, interrogating IOMMUs.
[  408.887891] /pci@1c,600000: Safari/JBUS interrupt, UNMAPPED error, interrogating IOMMU


-- 
Meelis Roos (mroos@linux.ee)
