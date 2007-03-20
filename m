From: BERTRAND =?utf-8?Q?Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 20 Mar 2007 18:52:47 +0000
Subject: [2.6.20.3] Oops with syscall_is_too_hard...
Message-Id: <20070320185247.GC27466@rayleigh.systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I have tried to untar the sources of 2.6.21-rc4 kernel. My SS20 runs with
	2.6.20.3/SMP.

[/usr/src] > tar xvfj linux-2.6.21-rc4.tar.bz2

	ends with:

ble to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 00000c70
tsk->{mm,active_mm}->pgd = fc10c800
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
bzip2(3097): Oops [#1]
PSR: 400000c4 PC: f00862a4 NPC: f00862a8 Y: 00000000    Not tainted
PC: <pipe_write+0x2d8/0x520>
%G: fb04dd08 000000d8  00001000 00000001  fb04de14 00000000  fb04c000 50027b80
%O: fa67ced8 5001d000  00000400 00000000  00002fe4 00000000  fb04dd08 f008601c
RPC: <pipe_write+0x50/0x520>
%L: fa67ce64 00000400  fbdb5ad8 00000000  0000000c 00000000  fb04c000 00000400
%I: 00000000 fb04de60  fbdb5a00 00000000  fa67ced8 fb6e37a0  fb04dd70 f007f618
Caller[f007f618]: do_sync_write+0xa4/0xdc
Caller[f007fed8]: vfs_write+0xa0/0x16c
Caller[f0080730]: sys_write+0x38/0x64
Caller[f00158e0]: syscall_is_too_hard+0x3c/0x40
Caller[500a387c]: 0x500a3884
Instruction DUMP: a4068001  e604a00c  c404a004 <c204c000> 80a06000  02bfff68
d004a008  aa008008  03000004 
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 00000c6e
tsk->{mm,active_mm}->pgd = fc0e4c00
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
tar(3096): Oops [#2]
PSR: 400000c2 PC: f0086654 NPC: f0086658 Y: 00000000    Not tainted
PC: <pipe_read+0x110/0x4d4>
%G: fa43e000 000000d8  00000080 f08a1a00  fbdb5a00 70726f63  fa43e000 00000000
%O: fbdb5a00 f08a1a00  f10d0000 3634342c  0a09092e 70726f63  fa43fcf8 f00869a8
RPC: <pipe_read+0x464/0x4d4>
%L: 00000000 00000000  f10d0400 00000001  fbdb5a00 00000c00  fbdb5ad8 00001c00
%I: efffefff 00000001  fa43fe60 00000008  00000000 f10d0000  fa43fd70 f007f6f4
Caller[f007f6f4]: do_sync_read+0xa4/0xdc
Caller[f0080044]: vfs_read+0xa0/0x16c
Caller[f00806cc]: sys_read+0x38/0x64
Caller[f00158e0]: syscall_is_too_hard+0x3c/0x40
Caller[0003dfcc]: 0x3dfd4
Instruction DUMP: ac050001  f805a00c  e005a008 <c207200c> 9fc04000  92100016
80a22000  128000b2  c407a048 

	Configuration is available at
	http://rayleigh.systella.fr/~bertrand/sparc32.config

	Regards,

	JKB
