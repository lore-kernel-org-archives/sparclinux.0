From: "Small, Jim" <jim.small@eds.com>
Date: Mon, 02 Feb 2004 20:18:04 +0000
Subject: Problems with bridging on Sparc64
Message-Id: <8AA870658244D4119AF600508BDF0A361D4BF107@usahm014.exmi01.exch.eds.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

I understand that David S Miller and other Sparc64 Linux networking gurus
hang out in this forum.  I'm hoping you can help me with a bridging problem.

I am running kernel 2.4.24/Sparc64 on my Ultra 60.  I also have the latest
version of the bridge utils - 0.9.6.

When I try to do bridging, I get:=20
# brctl addbr bridge0=20
# brctl addif bridge0 hme0=20
bridge bridge0 doesn't exist!=20
# brctl show=20
bridge name bridge id STP enabled interfaces=20
(No bridges shown)=20
# brctl addbr bridge0=20
device bridge0 already exists; can't create bridge with the same name=20

I have 5 hme ports (builtin + qfe) on my Ultra 60 and I need bridging. I
also need traffic shaping. FreeBSD panics when you turn on bridging, OpenBSD
is pokey when you bridge through more than 2 ports and doesn't have
sufficiently advanced traffic shaping. Linux is my last hope! Please help. =



Reproducible: Always
Steps to Reproduce:
1.  Make sure briding is enabled in the kernel.
2.  brctl addbr bridge0
3.  brctl show  (bridge0 does not show up)

Actual Results: =20
Can't seem to add a bridge virtual interface.

Expected Results: =20
Should have created a virtual bridge interface which you could then
associate=20
interfaces with.

The bridge module loads (can see it with lsmod).
Not sure why brctl can't create virtual bridge interface.

Hardware:  Ultra 60, 360MHz UltraSPARC II, 2GB RAM, 9 and 18GB SCSI HDDs,=20
builtin hme port, qfe card with 4 "hme" ports, SCSI-CDROM

Note that briding works in OpenBSD (with same machine described above)
albeit slowly so it is not a hardware problem or limitation.

I would be happy to try things, just let me know what to do.

Here are some straces if they are helpful:

Add new bridge:
test60{root}:/root<504>strace brctl addbr br10
execve("/sbin/brctl", ["brctl", "addbr", "br10"], [/* 28 vars */]) =3D 0
uname({sys=3D"Linux", node=3D"test60", ...}) =3D 0
brk(0)                                  =3D 0x25040
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 0x=
7001a000
open("/etc/ld.so.preload", O_RDONLY)    =3D -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=9986, ...}) =3D 0
mmap(NULL, 9986, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7001c000
close(3)                                =3D 0
open("/lib/libc.so.6", O_RDONLY)        =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\1\313"..., 1024)
=3D 1024
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=1583553, ...}) =3D 0
mmap(NULL, 1414760, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x7002c000
mprotect(0x70170000, 87656, PROT_NONE)  =3D 0
mmap(0x7017c000, 32768, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED, 3, 0x140000) =3D 0x7017c000
mmap(0x70184000, 5736, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x70184000
close(3)                                =3D 0
munmap(0x7001c000, 9986)                =3D 0
open("/dev/urandom", O_RDONLY)          =3D 3
read(3, "\307-\221\367\331\324\310{J\222F\3\330r\347\247\321<\274"..., 32) =
32
close(3)                                =3D 0
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) =3D 3
uname({sys=3D"Linux", node=3D"test60", ...}) =3D 0
ioctl(3, 0x8940, 0xeffff900)            =3D 1
ioctl(3, 0x8940, 0xeffff868)            =3D 1
brk(0)                                  =3D 0x25040
brk(0x27040)                            =3D 0x27040
brk(0)                                  =3D 0x27040
brk(0x28000)                            =3D 0x28000
socket(PF_INET6, SOCK_DGRAM, 0)         =3D -1 EAFNOSUPPORT (Address family
not supported by protocol)
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) =3D 4
ioctl(4, 0x8910, 0xeffff810)            =3D 0
close(4)                                =3D 0
ioctl(3, 0x89f3, 0xeffff790)            =3D -1 EOPNOTSUPP (Operation not
supported)
ioctl(3, 0x8940, 0xeffff8f0)            =3D 0
exit(0)                                 =3D ?

Add same bridge:
test60{root}:/root<505>strace brctl addbr br10
execve("/sbin/brctl", ["brctl", "addbr", "br10"], [/* 28 vars */]) =3D 0
uname({sys=3D"Linux", node=3D"test60", ...}) =3D 0
brk(0)                                  =3D 0x25040
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 0x=
7001a000
open("/etc/ld.so.preload", O_RDONLY)    =3D -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=9986, ...}) =3D 0
mmap(NULL, 9986, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7001c000
close(3)                                =3D 0
open("/lib/libc.so.6", O_RDONLY)        =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\1\313"..., 1024)
=3D 1024
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=1583553, ...}) =3D 0
mmap(NULL, 1414760, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x7002c000
mprotect(0x70170000, 87656, PROT_NONE)  =3D 0
mmap(0x7017c000, 32768, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED, 3, 0x140000) =3D 0x7017c000
mmap(0x70184000, 5736, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x70184000
close(3)                                =3D 0
munmap(0x7001c000, 9986)                =3D 0
open("/dev/urandom", O_RDONLY)          =3D 3
read(3, "\333\325\275\344\v\264\\\210i\31\243\6\30R\243\311\256"..., 32) 32
close(3)                                =3D 0
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) =3D 3
uname({sys=3D"Linux", node=3D"test60", ...}) =3D 0
ioctl(3, 0x8940, 0xeffff900)            =3D 1
ioctl(3, 0x8940, 0xeffff868)            =3D 2
brk(0)                                  =3D 0x25040
brk(0x27040)                            =3D 0x27040
brk(0)                                  =3D 0x27040
brk(0x28000)                            =3D 0x28000
socket(PF_INET6, SOCK_DGRAM, 0)         =3D -1 EAFNOSUPPORT (Address family
not supported by protocol)
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) =3D 4
ioctl(4, 0x8910, 0xeffff810)            =3D 0
close(4)                                =3D 0
ioctl(3, 0x89f3, 0xeffff790)            =3D -1 EOPNOTSUPP (Operation not
supported)
ioctl(3, 0x8940, 0xeffff8f0)            =3D -1 EEXIST (File exists)
write(2, "device br10 already exists; can\'"..., 67device br10 already
exists; can't create bridge with the same name
) =3D 67
exit(0)                                 =3D ?

Bridge status:
test60{root}:/root<506>strace brctl show
execve("/sbin/brctl", ["brctl", "show"], [/* 28 vars */]) =3D 0
uname({sys=3D"Linux", node=3D"test60", ...}) =3D 0
brk(0)                                  =3D 0x25040
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 0x=
7001a000
open("/etc/ld.so.preload", O_RDONLY)    =3D -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=9986, ...}) =3D 0
mmap(NULL, 9986, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7001c000
close(3)                                =3D 0
open("/lib/libc.so.6", O_RDONLY)        =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\1\313"..., 1024)
=3D 1024
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=1583553, ...}) =3D 0
mmap(NULL, 1414760, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x7002c000
mprotect(0x70170000, 87656, PROT_NONE)  =3D 0
mmap(0x7017c000, 32768, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED, 3, 0x140000) =3D 0x7017c000
mmap(0x70184000, 5736, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x70184000
close(3)                                =3D 0
munmap(0x7001c000, 9986)                =3D 0
open("/dev/urandom", O_RDONLY)          =3D 3
read(3, "C\374\303\246\324\364}\352\1779\335\266\24&\253\310\247"..., 32) 32
close(3)                                =3D 0
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) =3D 3
uname({sys=3D"Linux", node=3D"test60", ...}) =3D 0
ioctl(3, 0x8940, 0xeffff910)            =3D 1
ioctl(3, 0x8940, 0xeffff878)            =3D 2
brk(0)                                  =3D 0x25040
brk(0x27040)                            =3D 0x27040
brk(0)                                  =3D 0x27040
brk(0x28000)                            =3D 0x28000
socket(PF_INET6, SOCK_DGRAM, 0)         =3D -1 EAFNOSUPPORT (Address family
not supported by protocol)
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) =3D 4
ioctl(4, 0x8910, 0xeffff820)            =3D 0
close(4)                                =3D 0
ioctl(3, 0x89f3, 0xeffff7a0)            =3D -1 EOPNOTSUPP (Operation not
supported)
fstat64(1, {st_mode=3DS_IFCHR|0620, st_rdev=3Dmakedev(3, 0), ...}) =3D 0
ioctl(1, SNDCTL_TMR_SELECT, {B38400 opost isig icanon echo ...}) =3D 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 0x=
7001c000
write(1, "bridge name\tbridge id\t\tSTP enabl"..., 46bridge name
bridge id               STP enabled     interfaces
) =3D 46
munmap(0x7001c000, 8192)                =3D 0
exit(0)                                 =3D ?

For the moment I am not part of the list, so please cc me on replies.

Thanks,
   <> Jim

