From: ipif <ipif@ymail.com>
Date: Tue, 14 Apr 2009 12:00:41 +0000
Subject: alloc_io_res: cannot occupy / paging request fails
Message-Id: <23038125.post@talk.nabble.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hi,

I'm trying to get MTD support working on my embedded sparc (leon3, V8).
There are 32MB of flash on the board I want to utilize starting at 0x0. The
corresponding kernel options are:
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_START=0x00000000
CONFIG_MTD_PHYSMAP_LEN=0x02000000
With these options the kernel stops booting with
"alloc_io_res(phys_00000000): cannot occupy".
So I changed IOBASE_END and VMALLOC_START from 0xfe600000 to 0xff400000 in
include/asm-sparc/vaddrs.h. And voila, the kernel boots fine. But when I Try
to access the flash with dd the following happens:

Unable to handle kernel paging request at virtual address fe640000
tsk->{mm,active_mm}->context = 000000ae
tsk->{mm,active_mm}->pgd = fc01f400
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
dd(2616): Oops [#1]
PSR: f30000c2 PC: f01b543c NPC: f01b5440 Y: 00000000    Not tainted
PC: <cfi_intelext_read+0x158/0x1b4>
%G: fbd77d70 00000000  00000000 fe640000  00000000 00000000  fbd76000
00000000
%O: 00000000 00000000  01640000 00000000  00032000 01640000  fbd77d78
f01b53dc
RPC: <cfi_intelext_read+0xf8/0x1b4>
%L: 00000200 00000000  f0034ce4 01640000  f0ae39e0 f0b0c3e4  fbd76000
0005d000
%I: 00000000 01640000  f0ae3a18 00000200  fbd77e64 fbd16200  fbd77de0
f01ad1c0
Caller[f01ad1c0]: mtd_read+0xf8/0x23c
Caller[f007607c]: vfs_read+0x9c/0x140
Caller[f0076598]: sys_read+0x38/0x64
Caller[f0011310]: syscall_is_too_hard+0x3c/0x40
Caller[00011b20]: 0x11b28
Instruction DUMP: c405600c  86008013  84102000 <c208c002> c228801d  8400a001 
80a08010  12bffffc  94100019

Thanks,
-jan

-- 
View this message in context: http://www.nabble.com/alloc_io_res%3A-cannot-occupy---paging-request-fails-tp23038125p23038125.html
Sent from the sparclinux mailing list archive at Nabble.com.

