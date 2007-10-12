From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Fri, 12 Oct 2007 07:04:16 +0000
Subject: Re: sun4v_data_access_exception on new 2.6.23
Message-Id: <470F1C70.5090700@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <470E6F28.2010709@systella.fr>
In-Reply-To: <470E6F28.2010709@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

BERTRAND Jo=EBl wrote:
> David Miller wrote:
>> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
>> Date: Thu, 11 Oct 2007 20:44:56 +0200
>>
>>>     Hello,
>>>
>>>     I have built a 2.6.23 kernel on a T1000 server. I have seen this
>>> message on system console :
>=20
>     David,
>=20
>> Looking at the trace some more, I'm %99.99999 sure you're using
>> gcc-4.2.x to build this and that compiler is known to miscompile SMP
>> sparc64 kernels.
>=20
>     I a first time, I though that is was this trouble, but I can see the =

> same bug with debian kernel provided by debian/testing (a 2.6.22=20
> kernel). I don't know what compiler was used to build debian kernel.
>=20
>> gcc-4.1.x would never inline __flush_tsb_one() into flush_tsb_user(),
>> yet as is evident in your backtraces this is exactly what has
>> happened, therefore you must be using gcc-4.2.x or another non-4.1.x
>> compiler to build this.
>=20
>     OK, I will try to rebuild a kernel with gcc-4.1. Thanks for your help.

	David,

	I have rebuild a 2.6.23 kernel with gcc-4.1. When I try to format=20
(ext3fs) a raid5 volume, I _allways_ obtain (I have tested four times):

Root gershwin:[~] > mkfs.ext3 /dev/md8
mke2fs 1.40.2 (12-Jul-2007)
Filesystem labelOS type: Linux
Block size@96 (log=3D2)
Fragment size@96 (log=3D2)
183091200 inodes, 366181424 blocks
18309071 blocks (5.00%) reserved for the super user
First data block=3D0
Maximum filesystem blocks=3D0
11175 block groups
32768 blocks per group, 32768 fragments per group
16384 inodes per group
Superblock backups stored on blocks:
         32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632,=20
2654208,
         4096000, 7962624, 11239424, 20480000, 23887872, 71663616,=20
78675968,
         102400000, 214990848

Writing inode tables: Kernel unaligned access at TPC[56004c]=20
xor_niagara_4+0x5c/0x128
sun4v_data_access_exception: ADDR[000000000053d354] CTX[0000]=20
TYPE[000a], going.
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
md7_raid5(2676): Dax [#1]
TSTATE: 00000000e2001602 TPC: 000000000042bc60 TNPC: 000000000042bc64 Y:=20
00000000    Not tainted
TPC: <do_int_load+0x78/0xf0>
g0: fffff800fb84c000 g1: fffff800fb84f570 g2: 0000000000000400 g3:=20
000000000000001c
g4: fffff800fc4d3600 g5: fffff800020a8000 g6: fffff800fb84c000 g7:=20
fffff800fb84f4d0
o0: fffff800fb84f5d0 o1: 0000000000000010 o2: 000000000053d354 o3:=20
0000000000000000
o4: 00000000000000e2 o5: 0000000000000080 sp: fffff800fb84ea01 ret_pc:=20
0000000000435e6c
RPC: <kernel_unaligned_trap+0x194/0x520>
l0: 00000000000000e2 l1: fffff800fb84f5d0 l2: 000000000000001c l3:=20
0000000000000000
l4: 0000000000000010 l5: 00000000000000e2 l6: 000000000053d354 l7:=20
0000000080009000
i0: fffff800fb84f4d0 i1: 00000000f89fe010 i2: fffff800fc4d3600 i3:=20
0000000000000000
i4: 0000000000000034 i5: 000000000000000b i6: fffff800fb84ead1 i7:=20
00000000004290c0
I7: <sun4v_do_mna+0x88/0xa0>
Caller[00000000004290c0]: sun4v_do_mna+0x88/0xa0
Caller[0000000000406b78]: sun4v_mna+0x64/0x68
Caller[000000000053e674]: async_xor+0x4bc/0x5a0
Caller[000000000053d344]: xor_blocks+0x8c/0xe0
Caller[000000000053e674]: async_xor+0x4bc/0x5a0
Caller[00000000005ef328]: ops_run_prexor+0xd0/0xe0
Caller[00000000005efce4]: raid5_run_ops+0x52c/0x5c0
Caller[00000000005f01b8]: handle_stripe5+0x440/0x1340
Caller[00000000005f211c]: handle_stripe+0x24/0x13e0
Caller[00000000005f37c4]: raid5d+0x2ec/0x3c0
Caller[00000000005ff8f0]: md_thread+0x38/0x140
Caller[0000000000478b40]: kthread+0x48/0x80
Caller[00000000004273d0]: kernel_thread+0x38/0x60
Caller[0000000000478de0]: kthreadd+0x148/0x1c0
Instruction DUMP: 8538a000  1068001f  c4720000 <c48aa000> c68aa001=20
8528b038  ce8aa002  8728f030  c28aa003
   313/11175

	To build this new kernel, I have modified main Makefile to use gcc-4.1=20
(variable CC) dans dmesg returns:

PROMLIB: Sun IEEE Boot Prom 'OBP 4.23.4 2006/08/04 20:45'
PROMLIB: Root node compatible: sun4v
Linux version 2.6.23 (root@gershwin) (gcc version 4.1.3 20070831=20
(prerelease) (Debian 4.1.2-16)) #2 SMP Fri Oct 12 08:34:39 CEST 2007
ARCH: SUN4V
Ethernet address: 00:14:4f:6f:59:fe
OF stdout device is: /virtual-devices@100/console@1
PROM: Built device tree with 74930 bytes of memory.

	For information:
Root gershwin:[~] > cat /proc/mdstat
Personalities : [raid1] [raid6] [raid5] [raid4]
md8 : active raid1 md7[0]
       1464725696 blocks [2/1] [U_]

md7 : active raid5 sdc1[0] sdg1[5] sdh1[4] sdf1[3] sde1[2] sdd1[1]
       1464725760 blocks level 5, 64k chunk, algorithm 2 [6/6] [UUUUUU]
       [>....................]  resync =3D  1.1% (3471096/292945152)=20
finish!1.0mi
n speed"856K/sec

md6 : active raid1 sda1[0] sdb1[1]
       7815552 blocks [2/2] [UU]

md5 : active raid1 sda8[0] sdb8[1]
       14538752 blocks [2/2] [UU]

md4 : active raid1 sda7[0] sdb7[1]
       4883648 blocks [2/2] [UU]

md3 : active raid1 sda6[0] sdb6[1]
       9767424 blocks [2/2] [UU]

md2 : active raid1 sda5[0] sdb5[1]
       29294400 blocks [2/2] [UU]

md1 : active raid1 sda2[0] sdb2[1]
       489856 blocks [2/2] [UU]

md0 : active raid1 sdb4[1] sda4[0]
       4883648 blocks [2/2] [UU]

unused devices: <none>
Root gershwin:[~] >

and /dev/md8 is a raid1 volume shared on network (by iscsi [seems to not=20
work] or nbd).

	Regards,

	JKB
