From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 19 Dec 2006 23:41:48 +0000
Subject: nfs and sparc64
Message-Id: <458878BC.3040106@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I'm working on an UltraSPARC 60 workstation with 1 GB, two 
UltraSPARC-II@450 and several SCSI disks (raid1 and raid6). This file 
server is stable if (and only if) nobody tries to access to files by 
nfs. If nfs is used (only nfsv3), kernel makes oops. I use a official 
2.6.19.1 kernel (I have tested 2.6.18.5 and 2.6.20-rc1) but at work, I 
have tested a 2.6.15.1 (with netfilter-route-patch) without any trouble 
on a UltraSPARC 80 (4 procs and sames raid volumes).

	I have tested all material with diag-switch? true and diag-level max. 
The oops is reproductible and only occurs at the same instruction :

Root rayleigh:[~] > ksymoops -v /boot/vmlinux-2.6.19.1 oops
ksymoops 2.4.11 on sparc64 2.6.19.1.  Options used
      -v /boot/vmlinux-2.6.19.1 (specified)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.6.19.1/ (default)
      -m /boot/System.map-2.6.19.1 (default)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Error (regular_file): read_system_map stat /boot/System.map-2.6.19.1 failed
ksymoops: No such file or directory
Dec 20 00:06:12 rayleigh kernel: Unable to handle kernel NULL pointer 
dereferenc
e
Dec 20 00:06:12 rayleigh kernel: tsk->{mm,active_mm}->context = 
000000000000133b
Dec 20 00:06:12 rayleigh kernel: tsk->{mm,active_mm}->pgd = fffff8008790c000
Dec 20 00:06:12 rayleigh kernel:               \|/ ____ \|/
Dec 20 00:06:12 rayleigh kernel:               "@'/ .. \`@"
Dec 20 00:06:12 rayleigh kernel:               /_| \__/ |_\
Dec 20 00:06:12 rayleigh kernel:                  \__U_/
Dec 20 00:06:12 rayleigh kernel: nfsd(3561): Oops [#4]
Dec 20 00:06:12 rayleigh kernel: TSTATE: 0000004480009602 TPC: 
000000000048c504
TNPC: 000000000048c508 Y: 00000000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
Dec 20 00:06:12 rayleigh kernel: g0: ffffffff80000000 g1: 
0000000000000006 g2: 0
000000000004000 g3: 000000000000f000
Dec 20 00:06:12 rayleigh kernel: g4: fffff800807175a0 g5: 
fffff8007fc1dbc0 g6: f
ffff800a25bc000 g7: 0000000000000006
Dec 20 00:06:12 rayleigh kernel: o0: 0000000000000000 o1: 
fffff800800dc0c8 o2: 0
000000000000003 o3: 0000000000000010
Dec 20 00:06:12 rayleigh kernel: o4: 000000000070f3d0 o5: 
fffff800800dc0e8 sp: f
ffff800a25bee51 ret_pc: 000000000048c544
Dec 20 00:06:12 rayleigh kernel: l0: fffff800800dc0c0 l1: 
000000000070f280 l2: 0
00000000070f3c0 l3: 00000000101e7678
Dec 20 00:06:12 rayleigh kernel: l4: 00000000007c7800 l5: 
0000000000000000 l6: f
ffff80087cc6000 l7: 0000000000000150
Dec 20 00:06:12 rayleigh kernel: i0: 0000000000000000 i1: 
fffff800800e2300 i2: 0
000000000000003 i3: 0000000000000010
Dec 20 00:06:12 rayleigh kernel: i4: fffff800a25bf8a0 i5: 
fffff800a2561a98 i6: f
ffff800a25bef11 i7: 00000000101d2c2c


 >>PC;  0048c504 <put_page+4/100>   <== >>o4; 0070f3d0 <contig_page_data+150/9c0>
 >>ret_pc; 0048c544 <put_page+44/100>
 >>l1; 0070f280 <contig_page_data+0/9c0>
 >>l2; 0070f3c0 <contig_page_data+140/9c0>
 >>l3; 101e7678 <__crc_tcf_register_action+d04ea/377729>
 >>l4; 007c7800 <__log_buf+7e90/8000>
 >>i7; 101d2c2c <__crc_tcf_register_action+bba9e/377729>

Dec 20 00:06:12 rayleigh kernel: Caller[00000000101d2c2c]: 
nfsd_read_actor+0x74/
0x140 [nfsd]
Dec 20 00:06:12 rayleigh kernel: Caller[0000000000484700]: 
do_generic_mapping_re
ad+0x108/0x4c0
Dec 20 00:06:12 rayleigh kernel: Caller[0000000000484afc]: 
generic_file_sendfile
+0x44/0x60
Dec 20 00:06:12 rayleigh kernel: Caller[00000000101d08bc]: 
nfsd_vfs_read+0x3a4/0
x3e0 [nfsd]
Dec 20 00:06:12 rayleigh kernel: Caller[00000000101d0e40]: 
nfsd_read+0xa8/0xc0 [
nfsd]
Dec 20 00:06:12 rayleigh kernel: Caller[00000000101d8fa0]: 
nfsd3_proc_read+0xa8/
0x140 [nfsd]
Dec 20 00:06:12 rayleigh kernel: Caller[00000000101cc2c8]: 
nfsd_dispatch+0x90/0x
220 [nfsd]
Dec 20 00:06:12 rayleigh kernel: Caller[000000001018a56c]: 
svc_process+0x454/0x7
e0 [sunrpc]
Dec 20 00:06:12 rayleigh kernel: Caller[00000000101ccabc]: 
nfsd+0x184/0x300 [nfs
d]
Dec 20 00:06:12 rayleigh kernel: Caller[0000000000417b50]: 
kernel_thread+0x38/0x
60
Dec 20 00:06:12 rayleigh kernel: Caller[0000000010189a20]: 
__svc_create_thread+0
x148/0x220 [sunrpc]
Dec 20 00:06:12 rayleigh kernel: Instruction DUMP: 01000000  01000000 
9de3bf40
<c45e0000> 03000010  a0100018  92062008  84088001  0ac08037


Trace; 101d2c2c <__crc_tcf_register_action+bba9e/377729>
Trace; 00484700 <do_generic_mapping_read+100/4c0>
Trace; 00484afc <generic_file_sendfile+3c/60>
Trace; 101d08bc <__crc_tcf_register_action+b972e/377729>
Trace; 101d0e40 <__crc_tcf_register_action+b9cb2/377729>
Trace; 101d8fa0 <__crc_tcf_register_action+c1e12/377729>
Trace; 101cc2c8 <__crc_tcf_register_action+b513a/377729>
Trace; 1018a56c <__crc_tcf_register_action+733de/377729>
Trace; 101ccabc <__crc_tcf_register_action+b592e/377729>
Trace; 00417b50 <kernel_thread+30/60>
Trace; 10189a20 <__crc_tcf_register_action+72892/377729>

Code;  0048c4f8 <lru_add_drain_all+18/20>
00000000 <_PC>:
Code;  0048c4f8 <lru_add_drain_all+18/20>
    0:   01 00 00 00       nop
Code;  0048c4fc <lru_add_drain_all+1c/20>
    4:   01 00 00 00       nop
Code;  0048c500 <put_page+0/100>
    8:   9d e3 bf 40       save  %sp, -192, %sp
Code;  0048c504 <put_page+4/100>
    c:   c4 5e 00 00       inconnu
Code;  0048c508 <put_page+8/100>
   10:   03 00 00 10       sethi  %hi(0x4000), %g1
Code;  0048c50c <put_page+c/100>
   14:   a0 10 00 18       mov  %i0, %l0
Code;  0048c510 <put_page+10/100>
   18:   92 06 20 08       add  %i0, 8, %o1
Code;  0048c514 <put_page+14/100>
   1c:   84 08 80 01       and  %g2, %g1, %g2
Code;  0048c518 <put_page+18/100>
   20:   0a c0 80 37       inconnu


2 errors issued.  Results may not be reliable.
Root rayleigh:[~] > gcc -v
Using built-in specs.
Target: sparc-linux-gnu
Configured with: ../src/configure -v 
--enable-languages=c,c++,fortran,objc,obj-c++,treelang --prefix=/usr 
--enable-shared --with-system-zlib --libexecdir=/usr/lib 
--without-included-gettext --enable-threads=posix --enable-nls 
--program-suffix=-4.1 --enable-__cxa_atexit --enable-clocale=gnu 
--enable-libstdcxx-debug --enable-mpfr --with-cpu=v8 
--enable-checking=release sparc-linux-gnu
Thread model: posix
gcc version 4.1.2 20061028 (prerelease) (Debian 4.1.1-19)
Root rayleigh:[~] > cat /etc/exports
/export/home 
192.168.0.0/255.255.255.0(rw,root_squash,secure,async,map_identity,subtree_check)
Root rayleigh:[~] >

	U60 runs debian/etch, nfs-kernel-server, and client I use for tests is 
a i386 (K6-3/400) that runs debian/etch too. I have tested different 
memory configuration and the oops always occurs at the same instruction.

	Any idea ?

	Regards,

	JKB
