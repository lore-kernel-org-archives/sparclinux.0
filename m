From: Josip Rodin <joy@entuzijast.net>
Date: Tue, 17 Mar 2009 13:30:42 +0000
Subject: Irrecoverable deferred error trap
Message-Id: <20090317133042.GA16751@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Within half a day of upgrading from 2.6.27-rc4 to 2.6.28.7, one of our
buildds did this:

Mar 17 00:31:56 schroeder kernel: ERROR(1): Cheetah error trap taken afsr[0010100001000000] afar[0000001040000000] TL1(0)
Mar 17 00:31:56 schroeder kernel: ERROR(1): TPC[407b30] TNPC[407b34] O7[44136c] TSTATE[480f09607]
Mar 17 00:31:56 schroeder kernel: ERROR(1): TPC<copy_tsb+0x30/0x80>
Mar 17 00:31:56 schroeder kernel: ERROR(1): M_SYND(0),  E_SYND(0), Privileged
Mar 17 00:31:56 schroeder kernel: ERROR(1): Highest priority error (0000100000000000) "Unmapped error from system bus"
Mar 17 00:31:56 schroeder kernel: ERROR(1): D-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000]
Mar 17 00:31:56 schroeder kernel: ERROR(1): D-cache data0[0000000000000000] data1[0000000000000000] data2[0000000000000000] data3[0000000000000000]
Mar 17 00:31:56 schroeder kernel: ERROR(1): I-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000] u[0000000000000000] l[0000000000000000]
Mar 17 00:31:56 schroeder kernel: ERROR(1): I-cache INSN0[0000000000000000] INSN1[0000000000000000] INSN2[0000000000000000] INSN3[0000000000000000]
Mar 17 00:31:56 schroeder kernel: ERROR(1): I-cache INSN4[0000000000000000] INSN5[0000000000000000] INSN6[0000000000000000] INSN7[0000000000000000]
Mar 17 00:31:56 schroeder kernel: ERROR(1): E-cache idx[40000000] tag[000000001e040fca]
Mar 17 00:31:56 schroeder kernel: ERROR(1): E-cache data0[0000400000000000] data1[0410071101000080] data2[0000400000000000] data3[fffff8103f283331]
Mar 17 00:31:56 schroeder kernel: Kernel panic - not syncing: Irrecoverable deferred error trap.
Mar 17 00:31:56 schroeder kernel: 
Mar 17 00:31:56 schroeder kernel: Press Stop-A (L1-A) to return to the boot prom

The copy_tsb reference generally renders me fairly clueless :) but
from what my feeble little vgrep can infer, it looks like a program's RSS
tried to grow and experienced a page fault, kernel's fault handler tried to
grow/relocate it into a better TSB (physical memory block?) but then ran
into some sort of a showstopper.

Could this indicate a physical problem with the memory, given that I added
some RAM chips into the same machine relatively recently (Feb 26th)?

-- 
     2. That which causes joy or happiness.
