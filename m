From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Tue, 22 Nov 2005 15:33:48 +0000
Subject: sun4c problems in radix_tree_gang_lookup_tag
Message-Id: <Pine.LNX.4.10.10511221518580.30262-100000@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Is any one working on sun4c issues at the moment ?

I am getting a somewhat random occourance of a 'kernel BUG'.

I am using a cross compiled linux based on Linux 2.6.14.2. The cross
compiler is gcc-4.0.2 with cross binutils-2.16.1. I am using an nfs
mounted root. The sparc host is an OPUS sparcstation clone.

I also had the same issues with the 2.6.13 kernel.

Advice on debugging this to identify the real problem would be usefull. My
efforts with gcc-3.4.x only highlight that gcc-3.4.x is not good at
compiling sparc (32) code.

Regards
	Mark Fortescue.

kernel BUG at /L64/src/linux-2.6/linux-2.6.14.2-p02/lib/radix-tree.c:581!
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
as(945): Kernel bad trap [#1]
PSR: 004000c0 PC: f00e1cdc NPC: f00e1ce0 Y: 00000000    Not tainted
PC: <radix_tree_gang_lookup_tag+0x144/0x1ac>
%G: 00000001 f0234400  f02347ec 00400fe5  f002fc14 f0234800  ff032000 00000000
%O: 0000004d f02010b0  00000245 00000000  00000001 00000000  ff033a48 f00e1cd4
RPC: <radix_tree_gang_lookup_tag+0x13c/0x1ac>
%L: 00000001 ff033b14  0000003f 00000008  00000010 00000000  ff032000 f006f690
%I: 00000000 ff033b14  00000001 00000001  00000008 ff033b10  ff033ab0 f00b1fb4
Caller[f00b1fb4]: nfs_wait_on_requests+0x98/0xb8
Caller[f00b3950]: nfs_sync_inode+0x20/0x74
Caller[f00b151c]: nfs_readpage+0x44/0x44c
Caller[f004fb8c]: do_generic_mapping_read+0x290/0x564
Caller[f005074c]: __generic_file_aio_read+0x168/0x1cc
Caller[f005092c]: generic_file_aio_read+0x44/0x54
Caller[f006e6f4]: do_sync_read+0x94/0xc8
Caller[f006ea88]: vfs_read+0xa0/0x15c
Caller[f006f65c]: sys_read+0x30/0x64
Caller[f001149c]: syscall_is_too_hard+0x34/0x40
Caller[e009ac14]: 0xe009ac14
Instruction DUMP: 901220b0  7ffcc1ee  01000000 <91d02005> 9402a001  80a28010  0280000f  c4244001  8600e001 
kernel BUG at /L64/src/linux-2.6/linux-2.6.14.2-p02/lib/radix-tree.c:581!
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
as(945): Kernel bad trap [#2]
PSR: 004000c4 PC: f00e1cdc NPC: f00e1ce0 Y: 00000000    Not tainted
PC: <radix_tree_gang_lookup_tag+0x144/0x1ac>
%G: 00000001 f0234400  f02347ec 00400fe2  f002fc14 f0234800  ff032000 00000000
%O: 0000004d f02010b0  00000245 00000000  00000001 00000000  ff033560 f00e1cd4
RPC: <radix_tree_gang_lookup_tag+0x13c/0x1ac>
%L: 00000001 ff03362c  0000003f 00000001  00000002 00000000  ff032000 00000000
%I: 00000000 ff03362c  00000001 00000001  00000008 f02c4be8  ff0335c8 f00b1fb4
Caller[f00b1fb4]: nfs_wait_on_requests+0x98/0xb8
Caller[f00b3950]: nfs_sync_inode+0x20/0x74
Caller[f00aa650]: nfs_file_flush+0x54/0xb0
Caller[f006c7f8]: filp_close+0x48/0x80
Caller[f003103c]: put_files_struct+0x8c/0xe8
Caller[f0031f44]: do_exit+0x1b4/0xbb4
Caller[f0012734]: die_if_kernel+0x110/0x11c
Caller[f0012788]: do_hw_interrupt+0x48/0x8c
Caller[f0010940]: bad_trap_handler+0x20/0x30
Caller[f00e1cd4]: radix_tree_gang_lookup_tag+0x13c/0x1ac
Caller[f00b1fb4]: nfs_wait_on_requests+0x98/0xb8
Caller[f00b3950]: nfs_sync_inode+0x20/0x74
Caller[f00b151c]: nfs_readpage+0x44/0x44c
Caller[f004fb8c]: do_generic_mapping_read+0x290/0x564
Caller[f005074c]: __generic_file_aio_read+0x168/0x1cc
Caller[f005092c]: generic_file_aio_read+0x44/0x54
Caller[f006e6f4]: do_sync_read+0x94/0xc8
Caller[f006ea88]: vfs_read+0xa0/0x15c
Caller[f006f65c]: sys_read+0x30/0x64
Caller[f001149c]: syscall_is_too_hard+0x34/0x40
Caller[e009ac14]: 0xe009ac14
Instruction DUMP: 901220b0  7ffcc1ee  01000000 <91d02005> 9402a001  80a28010  0280000f  c4244001  8600e001 
Fixing recursive fault but reboot is needed!

