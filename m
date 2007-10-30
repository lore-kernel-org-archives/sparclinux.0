From: Josip Rodin <joy@entuzijast.net>
Date: Tue, 30 Oct 2007 00:30:41 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071030003041.GA16455@keid.carnet.hr>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
To: sparclinux@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 29, 2007 at 04:45:39PM -0700, David Miller wrote:
> BTW, in your buildroot, can you do something like:
> 
> 	strace -o x.log dpkg-query -S libc.so.6
> 
> and send me that "x.log" file?
> 
> That might give some important clues.

Here you go.

(Mind, this is capturing the current status of the chroot, which is fairly
unclean, because right now it happens to be building python-qt4-4.3.1.)

-- 
     2. That which causes joy or happiness.

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="strace.lebrun.log"

execve("/usr/bin/dpkg-query", ["dpkg-query", "-S", "libc.so.6"], [/* 16 vars */]) = 0
brk(0)                                  = 0xbe000
uname({sys="Linux", node="lebrun", ...}) = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7fc2000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=64920, ...}) = 0
mmap(NULL, 64920, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7fb0000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\1\364"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1419756, ...}) = 0
mmap(NULL, 1489032, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7e44000
mprotect(0xf7f98000, 65536, PROT_NONE)  = 0
mmap(0xf7fa8000, 24576, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x154000) = 0xf7fa8000
mmap(0xf7fae000, 6280, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf7fae000
close(3)                                = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7fc0000
munmap(0xf7fb0000, 64920)               = 0
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
brk(0)                                  = 0xbe000
brk(0xe0000)                            = 0xe0000
open("/usr/share/locale/locale.alias", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2584, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7fbe000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2584
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xf7fbe000, 8192)                = 0
open("/usr/lib/locale/hr_HR/LC_IDENTIFICATION", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/locale/hr/LC_IDENTIFICATION", O_RDONLY) = -1 ENOENT (No such file or directory)
umask(022)                              = 022
open("/var/lib/dpkg/status", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2360567, ...}) = 0
mmap2(NULL, 2360567, PROT_READ, MAP_SHARED, 3, 0) = 0xf7c00000
brk(0x102000)                           = 0x102000
brk(0x124000)                           = 0x124000
brk(0x146000)                           = 0x146000
brk(0x168000)                           = 0x168000
brk(0x18a000)                           = 0x18a000
brk(0x1ac000)                           = 0x1ac000
brk(0x1ce000)                           = 0x1ce000
brk(0x1f0000)                           = 0x1f0000
brk(0x212000)                           = 0x212000
brk(0x234000)                           = 0x234000
brk(0x256000)                           = 0x256000
brk(0x278000)                           = 0x278000
brk(0x29a000)                           = 0x29a000
brk(0x2bc000)                           = 0x2bc000
brk(0x2de000)                           = 0x2de000
brk(0x300000)                           = 0x300000
brk(0x322000)                           = 0x322000
brk(0x344000)                           = 0x344000
brk(0x366000)                           = 0x366000
brk(0x388000)                           = 0x388000
brk(0x3aa000)                           = 0x3aa000
brk(0x3cc000)                           = 0x3cc000
brk(0x3ee000)                           = 0x3ee000
brk(0x410000)                           = 0x410000
brk(0x432000)                           = 0x432000
brk(0x454000)                           = 0x454000
brk(0x476000)                           = 0x476000
brk(0x498000)                           = 0x498000
brk(0x4ba000)                           = 0x4ba000
brk(0x4dc000)                           = 0x4dc000
brk(0x4fe000)                           = 0x4fe000
brk(0x520000)                           = 0x520000
brk(0x542000)                           = 0x542000
brk(0x564000)                           = 0x564000
brk(0x586000)                           = 0x586000
brk(0x5a8000)                           = 0x5a8000
brk(0x5ca000)                           = 0x5ca000
munmap(0xf7c00000, 2360567)             = 0
close(3)                                = 0
open("/var/lib/dpkg/updates/", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|0x4) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
getdents64(3, /* 2 entries */, 4096)    = 48
getdents64(3, /* 0 entries */, 4096)    = 0
close(3)                                = 0
open("/var/lib/dpkg/info/libvolume-id-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=195, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 195) = 195
close(3)                                = 0
open("/var/lib/dpkg/info/libgtkspell0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2270, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libgtk"..., 2270) = 2270
close(3)                                = 0
open("/var/lib/dpkg/info/libsepol1-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1865, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1865) = 1865
close(3)                                = 0
brk(0x5ec000)                           = 0x5ec000
open("/var/lib/dpkg/info/libbonoboui2-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=416, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 416) = 416
close(3)                                = 0
open("/var/lib/dpkg/info/java-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2484, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/ja"..., 2484) = 2484
close(3)                                = 0
open("/var/lib/dpkg/info/libgmpxx4ldbl.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=252, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libgmp"..., 252) = 252
close(3)                                = 0
open("/var/lib/dpkg/info/debconf.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=7538, ...}) = 0
read(3, "/.\n/etc\n/etc/debconf.conf\n/etc/a"..., 7538) = 7538
close(3)                                = 0
open("/var/lib/dpkg/info/librecode0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=242, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 242) = 242
close(3)                                = 0
open("/var/lib/dpkg/info/libmng-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=690, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 690) = 690
close(3)                                = 0
open("/var/lib/dpkg/info/dpatch.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2033, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/dpatch"..., 2033) = 2033
close(3)                                = 0
open("/var/lib/dpkg/info/libart-2.0-2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=366, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 366) = 366
close(3)                                = 0
open("/var/lib/dpkg/info/mktemp.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=243, ...}) = 0
read(3, "/.\n/bin\n/bin/mktemp\n/usr\n/usr/sh"..., 243) = 243
close(3)                                = 0
open("/var/lib/dpkg/info/shared-mime-info.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4746, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/lo"..., 4746) = 4746
close(3)                                = 0
open("/var/lib/dpkg/info/libt1-5.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=427, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libt1."..., 427) = 427
close(3)                                = 0
open("/var/lib/dpkg/info/libpq5.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2036, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2036) = 2036
close(3)                                = 0
open("/var/lib/dpkg/info/libmpfr1ldbl.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=428, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 428) = 428
close(3)                                = 0
open("/var/lib/dpkg/info/libxdmcp6.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=236, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 236) = 236
close(3)                                = 0
open("/var/lib/dpkg/info/libgstreamer0.10-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=5065, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 5065) = 5065
close(3)                                = 0
open("/var/lib/dpkg/info/libtheora-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2991, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2991) = 2991
close(3)                                = 0
open("/var/lib/dpkg/info/esound-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=412, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 412) = 412
close(3)                                = 0
open("/var/lib/dpkg/info/libatk1.0-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1597, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1597) = 1597
close(3)                                = 0
open("/var/lib/dpkg/info/python-all-dbg.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=64, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 64) = 64
close(3)                                = 0
open("/var/lib/dpkg/info/coreutils.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=11167, ...}) = 0
brk(0x60e000)                           = 0x60e000
read(3, "/.\n/bin\n/bin/cat\n/bin/chgrp\n/bin"..., 11167) = 11167
brk(0x60a000)                           = 0x60a000
close(3)                                = 0
open("/var/lib/dpkg/info/gij-4.2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=727, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 727) = 727
close(3)                                = 0
open("/var/lib/dpkg/info/libopts25.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=294, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libopt"..., 294) = 294
close(3)                                = 0
open("/var/lib/dpkg/info/libxpm-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=325, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 325) = 325
close(3)                                = 0
open("/var/lib/dpkg/info/sudo.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1032, ...}) = 0
read(3, "/.\n/etc\n/etc/pam.d\n/etc/pam.d/su"..., 1032) = 1032
close(3)                                = 0
open("/var/lib/dpkg/info/libfreetype6.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=596, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libfre"..., 596) = 596
close(3)                                = 0
open("/var/lib/dpkg/info/debianutils.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1525, ...}) = 0
read(3, "/.\n/bin\n/bin/run-parts\n/bin/temp"..., 1525) = 1525
close(3)                                = 0
open("/var/lib/dpkg/info/libsysfs2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=352, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 352) = 352
close(3)                                = 0
open("/var/lib/dpkg/info/re2c.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2803, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/re2c\n/"..., 2803) = 2803
close(3)                                = 0
open("/var/lib/dpkg/info/libxml-parser-perl.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3236, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/perl5\n"..., 3236) = 3236
close(3)                                = 0
open("/var/lib/dpkg/info/libxmuu1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=230, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 230) = 230
close(3)                                = 0
open("/var/lib/dpkg/info/byacc.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=413, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/byacc\n"..., 413) = 413
close(3)                                = 0
open("/var/lib/dpkg/info/x11proto-input-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=393, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 393) = 393
close(3)                                = 0
open("/var/lib/dpkg/info/libmeanwhile-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=13196, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 13196) = 13196
close(3)                                = 0
open("/var/lib/dpkg/info/makedev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=258, ...}) = 0
read(3, "/.\n/sbin\n/sbin/MAKEDEV\n/usr\n/usr"..., 258) = 258
close(3)                                = 0
open("/var/lib/dpkg/info/libxml2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=387, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 387) = 387
close(3)                                = 0
open("/var/lib/dpkg/info/login.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=8201, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/li"..., 8201) = 8201
brk(0x62c000)                           = 0x62c000
close(3)                                = 0
open("/var/lib/dpkg/info/texlive-base.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=71950, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 32768) = 32768
read(3, "blacklj.mf\n/usr/share/texmf-texl"..., 32768) = 32768
read(3, "tafont/misc/modename.mf\n/usr/sha"..., 6414) = 6414
brk(0x64e000)                           = 0x64e000
close(3)                                = 0
open("/var/lib/dpkg/info/gstreamer-tools.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=532, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 532) = 532
close(3)                                = 0
open("/var/lib/dpkg/info/kdelibs4c2a.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=10967, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 10967) = 10967
close(3)                                = 0
open("/var/lib/dpkg/info/gpgv.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=212, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/gpgv\n/"..., 212) = 212
close(3)                                = 0
open("/var/lib/dpkg/info/sparc-utils.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1702, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/elftoa"..., 1702) = 1702
close(3)                                = 0
open("/var/lib/dpkg/info/libgmp3c2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=447, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libgmp"..., 447) = 447
close(3)                                = 0
open("/var/lib/dpkg/info/libdbus-1-3.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=353, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 353) = 353
close(3)                                = 0
open("/var/lib/dpkg/info/libvorbisfile3.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=223, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libvor"..., 223) = 223
close(3)                                = 0
open("/var/lib/dpkg/info/gettext-base.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4924, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 4924) = 4924
close(3)                                = 0
open("/var/lib/dpkg/info/libvorbis-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=7010, ...}) = 0
brk(0x670000)                           = 0x670000
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 7010) = 7010
close(3)                                = 0
open("/var/lib/dpkg/info/libflac8.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=193, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libFLA"..., 193) = 193
close(3)                                = 0
open("/var/lib/dpkg/info/libffi4.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=112, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 112) = 112
close(3)                                = 0
open("/var/lib/dpkg/info/libcairo2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=374, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libcai"..., 374) = 374
close(3)                                = 0
open("/var/lib/dpkg/info/libgdbm3.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=255, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libgdb"..., 255) = 255
close(3)                                = 0
open("/var/lib/dpkg/info/sharutils.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3594, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 3594) = 3594
close(3)                                = 0
open("/var/lib/dpkg/info/libxine-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1968, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/xine-c"..., 1968) = 1968
close(3)                                = 0
open("/var/lib/dpkg/info/libgcrypt11.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=424, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 424) = 424
close(3)                                = 0
open("/var/lib/dpkg/info/libogg-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4364, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 4364) = 4364
close(3)                                = 0
open("/var/lib/dpkg/info/python-dbus.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2017, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/pkgcon"..., 2017) = 2017
close(3)                                = 0
open("/var/lib/dpkg/info/libusb-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3021, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/libusb"..., 3021) = 3021
close(3)                                = 0
open("/var/lib/dpkg/info/libecj-java-gcj.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=297, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 297) = 297
close(3)                                = 0
open("/var/lib/dpkg/info/libxinerama1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=254, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 254) = 254
close(3)                                = 0
open("/var/lib/dpkg/info/python-ctypes.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=5498, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/python"..., 5498) = 5498
close(3)                                = 0
open("/var/lib/dpkg/info/libuuid1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=179, ...}) = 0
read(3, "/.\n/lib\n/lib/libuuid.so.1.2\n/usr"..., 179) = 179
close(3)                                = 0
open("/var/lib/dpkg/info/libavahi-client-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=545, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 545) = 545
close(3)                                = 0
open("/var/lib/dpkg/info/liblcms1-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=438, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/liblcm"..., 438) = 438
close(3)                                = 0
open("/var/lib/dpkg/info/libgd2-xpm.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=461, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 461) = 461
close(3)                                = 0
open("/var/lib/dpkg/info/tk8.4.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4910, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/tk"..., 4910) = 4910
close(3)                                = 0
open("/var/lib/dpkg/info/libtasn1-3.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=375, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 375) = 375
close(3)                                = 0
open("/var/lib/dpkg/info/lsb-base.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=234, ...}) = 0
read(3, "/.\n/lib\n/lib/lsb\n/lib/lsb/init-f"..., 234) = 234
close(3)                                = 0
open("/var/lib/dpkg/info/fontconfig.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=524, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 524) = 524
close(3)                                = 0
open("/var/lib/dpkg/info/libjpeg62.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=271, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libjpe"..., 271) = 271
close(3)                                = 0
open("/var/lib/dpkg/info/libsilc-1.1-2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=111736, ...}) = 0
brk(0x6aa000)                           = 0x6aa000
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 32768) = 32768
read(3, "lient_unref_server.html\n/usr/sha"..., 32768) = 32768
read(3, "c_mp_size.html\n/usr/share/doc/li"..., 32768) = 32768
read(3, "c/libsilc-1.1-2-dev/toolkit/silc"..., 13432) = 13432
close(3)                                = 0
brk(0x6cc000)                           = 0x6cc000
open("/var/lib/dpkg/info/mlock.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=447, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/li"..., 447) = 447
close(3)                                = 0
open("/var/lib/dpkg/info/libxinerama-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=558, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 558) = 558
close(3)                                = 0
open("/var/lib/dpkg/info/libxml-dom-perl.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2686, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/pe"..., 2686) = 2686
close(3)                                = 0
open("/var/lib/dpkg/info/libqt4-gui.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1641, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1641) = 1641
close(3)                                = 0
open("/var/lib/dpkg/info/cpp-4.1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=346, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 346) = 346
close(3)                                = 0
open("/var/lib/dpkg/info/cpp-4.2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=459, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 459) = 459
close(3)                                = 0
open("/var/lib/dpkg/info/liboil0.3-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2585, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2585) = 2585
close(3)                                = 0
open("/var/lib/dpkg/info/procps.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1494, ...}) = 0
read(3, "/.\n/etc\n/etc/sysctl.conf\n/etc/in"..., 1494) = 1494
close(3)                                = 0
open("/var/lib/dpkg/info/g++-4.2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=506, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 506) = 506
close(3)                                = 0
open("/var/lib/dpkg/info/libgnomeui-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3408, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 3408) = 3408
close(3)                                = 0
open("/var/lib/dpkg/info/libflac++6.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=203, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libFLA"..., 203) = 203
close(3)                                = 0
open("/var/lib/dpkg/info/xutils-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4643, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 4643) = 4643
close(3)                                = 0
open("/var/lib/dpkg/info/libtool.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=780, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/libtoo"..., 780) = 780
close(3)                                = 0
open("/var/lib/dpkg/info/libnspr4-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3374, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 3374) = 3374
close(3)                                = 0
open("/var/lib/dpkg/info/libspeex1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=236, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libspe"..., 236) = 236
close(3)                                = 0
open("/var/lib/dpkg/info/python-minimal.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=410, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/share\n/usr"..., 410) = 410
close(3)                                = 0
open("/var/lib/dpkg/info/libdvdread3.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=410, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/li"..., 410) = 410
close(3)                                = 0
open("/var/lib/dpkg/info/hspell.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=718, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/hspell"..., 718) = 718
close(3)                                = 0
open("/var/lib/dpkg/info/texlive-doc-base.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1217, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1217) = 1217
close(3)                                = 0
open("/var/lib/dpkg/info/tcl8.4.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=5105, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/tclsh8"..., 5105) = 5105
close(3)                                = 0
open("/var/lib/dpkg/info/ncurses-base.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2650, ...}) = 0
read(3, "/.\n/etc\n/etc/terminfo\n/etc/termi"..., 2650) = 2650
close(3)                                = 0
open("/var/lib/dpkg/info/expect.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=700, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/li"..., 700) = 700
close(3)                                = 0
brk(0x6ee000)                           = 0x6ee000
open("/var/lib/dpkg/info/libflac-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=601, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libFLA"..., 601) = 601
close(3)                                = 0
open("/var/lib/dpkg/info/libpopt0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3144, ...}) = 0
read(3, "/.\n/lib\n/lib/libpopt.so.0.0.0\n/u"..., 3144) = 3144
close(3)                                = 0
open("/var/lib/dpkg/info/libpam0g.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=586, ...}) = 0
read(3, "/.\n/lib\n/lib/libpam.so.0.81.6\n/l"..., 586) = 586
close(3)                                = 0
open("/var/lib/dpkg/info/libpci2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=236, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libpci"..., 236) = 236
close(3)                                = 0
open("/var/lib/dpkg/info/autotools-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=533, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/mi"..., 533) = 533
close(3)                                = 0
open("/var/lib/dpkg/info/cdbs.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1419, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1419) = 1419
close(3)                                = 0
open("/var/lib/dpkg/info/libxfixes-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=413, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 413) = 413
close(3)                                = 0
open("/var/lib/dpkg/info/libusb-0.1-4.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=282, ...}) = 0
read(3, "/.\n/lib\n/lib/libusb-0.1.so.4.4.4"..., 282) = 282
close(3)                                = 0
open("/var/lib/dpkg/info/libavc1394-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=446, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libavc"..., 446) = 446
close(3)                                = 0
open("/var/lib/dpkg/info/libgpg-error0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=793, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libgpg"..., 793) = 793
close(3)                                = 0
open("/var/lib/dpkg/info/psmisc.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2314, ...}) = 0
read(3, "/.\n/bin\n/bin/fuser\n/usr\n/usr/bin"..., 2314) = 2314
close(3)                                = 0
open("/var/lib/dpkg/info/libmozjs-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1646, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/pkgcon"..., 1646) = 1646
close(3)                                = 0
open("/var/lib/dpkg/info/ucf.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=611, ...}) = 0
read(3, "/.\n/var\n/var/lib\n/var/lib/ucf\n/e"..., 611) = 611
close(3)                                = 0
open("/var/lib/dpkg/info/libcurl4-openssl-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=12981, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libcur"..., 12981) = 12981
close(3)                                = 0
open("/var/lib/dpkg/info/perl-modules.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=36434, ...}) = 0
brk(0x712000)                           = 0x712000
read(3, "/.\n/usr\n/usr/share\n/usr/share/pe"..., 32768) = 32768
read(3, "erl/5.8.8/unicore/lib/jt\n/usr/sh"..., 3666) = 3666
brk(0x70a000)                           = 0x70a000
close(3)                                = 0
open("/var/lib/dpkg/info/bsdutils.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=794, ...}) = 0
read(3, "/.\n/bin\n/usr\n/usr/bin\n/usr/bin/c"..., 794) = 794
close(3)                                = 0
open("/var/lib/dpkg/info/libgl1-mesa-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=184, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 184) = 184
close(3)                                = 0
open("/var/lib/dpkg/info/xbase-clients.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4327, ...}) = 0
read(3, "/.\n/var\n/var/lib\n/var/lib/xkb\n/e"..., 4327) = 4327
close(3)                                = 0
open("/var/lib/dpkg/info/libsybdb5.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=118, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libsyb"..., 118) = 118
close(3)                                = 0
open("/var/lib/dpkg/info/hicolor-icon-theme.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=13139, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/ic"..., 13139) = 13139
brk(0x72c000)                           = 0x72c000
close(3)                                = 0
open("/var/lib/dpkg/info/texlive-base-bin.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=21429, ...}) = 0
read(3, "/.\n/etc\n/etc/texmf\n/etc/texmf/te"..., 21429) = 21429
close(3)                                = 0
open("/var/lib/dpkg/info/libexpat1-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1133, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 1133) = 1133
close(3)                                = 0
open("/var/lib/dpkg/info/xmlto.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1015, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/xmlif\n"..., 1015) = 1015
close(3)                                = 0
open("/var/lib/dpkg/info/python-sip4-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=927, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/python"..., 927) = 927
close(3)                                = 0
open("/var/lib/dpkg/info/libxss1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=224, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 224) = 224
close(3)                                = 0
open("/var/lib/dpkg/info/libxext-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2904, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2904) = 2904
close(3)                                = 0
open("/var/lib/dpkg/info/libxkbfile1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=248, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 248) = 248
close(3)                                = 0
open("/var/lib/dpkg/info/lsb-release.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=288, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/lsb_re"..., 288) = 288
close(3)                                = 0
open("/var/lib/dpkg/info/python2.5-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=7669, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/python"..., 7669) = 7669
close(3)                                = 0
brk(0x74e000)                           = 0x74e000
open("/var/lib/dpkg/info/debhelper.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=10534, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/dh_bui"..., 10534) = 10534
close(3)                                = 0
open("/var/lib/dpkg/info/liborbit2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4500, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 4500) = 4500
close(3)                                = 0
open("/var/lib/dpkg/info/sp.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1678, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/nsgmls"..., 1678) = 1678
close(3)                                = 0
open("/var/lib/dpkg/info/libqt3-mt.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1028, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libqt-"..., 1028) = 1028
close(3)                                = 0
open("/var/lib/dpkg/info/dpkg-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3727, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/dpkg-g"..., 3727) = 3727
close(3)                                = 0
open("/var/lib/dpkg/info/libxslt1-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=6110, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 6110) = 6110
close(3)                                = 0
open("/var/lib/dpkg/info/libsamplerate0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=266, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libsam"..., 266) = 266
close(3)                                = 0
open("/var/lib/dpkg/info/libc6-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=11747, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/gencat"..., 11747) = 11747
brk(0x770000)                           = 0x770000
close(3)                                = 0
open("/var/lib/dpkg/info/libssl0.9.8.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=722, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libcry"..., 722) = 722
close(3)                                = 0
open("/var/lib/dpkg/info/libjack-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3312, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 3312) = 3312
close(3)                                = 0
open("/var/lib/dpkg/info/sip4.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=483, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/sip\n/u"..., 483) = 483
close(3)                                = 0
open("/var/lib/dpkg/info/bzip2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=934, ...}) = 0
read(3, "/.\n/bin\n/bin/bzip2\n/bin/bunzip2\n"..., 934) = 934
close(3)                                = 0
open("/var/lib/dpkg/info/libltdl3-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=856, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 856) = 856
close(3)                                = 0
open("/var/lib/dpkg/info/libaprutil1-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1356, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 1356) = 1356
close(3)                                = 0
open("/var/lib/dpkg/info/libqt4-sql.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=409, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 409) = 409
close(3)                                = 0
open("/var/lib/dpkg/info/libcppunit-1.12-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=236, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libcpp"..., 236) = 236
close(3)                                = 0
open("/var/lib/dpkg/info/x11proto-scrnsaver-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=418, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/pkgcon"..., 418) = 418
close(3)                                = 0
open("/var/lib/dpkg/info/libmcrypt-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=544, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/include\n/u"..., 544) = 544
close(3)                                = 0
open("/var/lib/dpkg/info/openssl.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=17892, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 17892) = 17892
close(3)                                = 0
open("/var/lib/dpkg/info/libc6-dev-sparc64.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1308, ...}) = 0
read(3, "/.\n/usr\n/usr/lib64\n/usr/lib64/li"..., 1308) = 1308
close(3)                                = 0
open("/var/lib/dpkg/info/libgcrypt11-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=698, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 698) = 698
close(3)                                = 0
open("/var/lib/dpkg/info/python2.5-minimal.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=6216, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/python"..., 6216) = 6216
brk(0x792000)                           = 0x792000
close(3)                                = 0
open("/var/lib/dpkg/info/ncurses-bin.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=712, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/ncurse"..., 712) = 712
close(3)                                = 0
open("/var/lib/dpkg/info/perl-base.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4189, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/perl\n/"..., 4189) = 4189
close(3)                                = 0
open("/var/lib/dpkg/info/sysv-rc.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1195, ...}) = 0
read(3, "/.\n/etc\n/etc/rc2.d\n/etc/rc2.d/RE"..., 1195) = 1195
close(3)                                = 0
open("/var/lib/dpkg/info/libsamplerate0-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1399, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1399) = 1399
close(3)                                = 0
open("/var/lib/dpkg/info/libjack0.100.0-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=288, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 288) = 288
close(3)                                = 0
open("/var/lib/dpkg/info/tcl8.4-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2100, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/tcl8.4"..., 2100) = 2100
close(3)                                = 0
open("/var/lib/dpkg/info/apt.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=10142, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/apt-ca"..., 10142) = 10142
close(3)                                = 0
open("/var/lib/dpkg/info/libaudiofile-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1568, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/audiof"..., 1568) = 1568
close(3)                                = 0
open("/var/lib/dpkg/info/libxrender-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=396, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 396) = 396
close(3)                                = 0
open("/var/lib/dpkg/info/libmysqlclient15off.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=465, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libmys"..., 465) = 465
close(3)                                = 0
open("/var/lib/dpkg/info/libcairo2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1023, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 1023) = 1023
close(3)                                = 0
open("/var/lib/dpkg/info/python2.4-dbg.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=9942, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/python"..., 9942) = 9942
close(3)                                = 0
open("/var/lib/dpkg/info/libarts1c2a.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2537, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2537) = 2537
brk(0x7b4000)                           = 0x7b4000
close(3)                                = 0
open("/var/lib/dpkg/info/sgml-base.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=816, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/sg"..., 816) = 816
close(3)                                = 0
open("/var/lib/dpkg/info/libboost-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=156172, ...}) = 0
mmap(NULL, 163840, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7e1c000
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 32768) = 32768
read(3, "d/mwcw/times.hpp\n/usr/include/bo"..., 32768) = 32768
read(3, "t/pending/mutable_heap.hpp\n/usr/"..., 32768) = 32768
read(3, "/usr/include/boost/spirit/fusion"..., 32768) = 32768
read(3, "tring/detail/find_format_all.hpp"..., 25100) = 25100
brk(0x7d6000)                           = 0x7d6000
close(3)                                = 0
brk(0x7f8000)                           = 0x7f8000
open("/var/lib/dpkg/info/libxslt1.1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=538, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libexs"..., 538) = 538
close(3)                                = 0
open("/var/lib/dpkg/info/gperf.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=618, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/gperf\n"..., 618) = 618
close(3)                                = 0
open("/var/lib/dpkg/info/libxdmcp-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=341, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 341) = 341
close(3)                                = 0
open("/var/lib/dpkg/info/libungif4g.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=565, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/li"..., 565) = 565
close(3)                                = 0
open("/var/lib/dpkg/info/libtiffxx0c2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=213, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 213) = 213
close(3)                                = 0
open("/var/lib/dpkg/info/libasound2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1590, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/li"..., 1590) = 1590
close(3)                                = 0
open("/var/lib/dpkg/info/pciutils.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=643, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/mi"..., 643) = 643
close(3)                                = 0
open("/var/lib/dpkg/info/texinfo.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3594, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 3594) = 3594
close(3)                                = 0
open("/var/lib/dpkg/info/libdbus-glib-1-2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=395, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 395) = 395
close(3)                                = 0
open("/var/lib/dpkg/info/libpango1.0-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2367, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/dh_pan"..., 2367) = 2367
close(3)                                = 0
open("/var/lib/dpkg/info/freetds-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=718, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 718) = 718
close(3)                                = 0
open("/var/lib/dpkg/info/libgc1c2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=322, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 322) = 322
close(3)                                = 0
open("/var/lib/dpkg/info/python-dbus-dbg.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1083, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/debug\n"..., 1083) = 1083
close(3)                                = 0
open("/var/lib/dpkg/info/libgnomeui-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=569, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 569) = 569
close(3)                                = 0
open("/var/lib/dpkg/info/libldap2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=442, ...}) = 0
read(3, "/.\n/etc\n/etc/ldap\n/etc/ldap/ldap"..., 442) = 442
close(3)                                = 0
open("/var/lib/dpkg/info/libc-client2006j2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1024, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1024) = 1024
close(3)                                = 0
open("/var/lib/dpkg/info/libct3.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=711, ...}) = 0
read(3, "/.\n/etc\n/etc/freetds\n/usr\n/usr/s"..., 711) = 711
close(3)                                = 0
open("/var/lib/dpkg/info/libpopt-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=392, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libpop"..., 392) = 392
close(3)                                = 0
open("/var/lib/dpkg/info/libgail-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=788, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 788) = 788
close(3)                                = 0
open("/var/lib/dpkg/info/libmagic1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=530, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/bu"..., 530) = 530
close(3)                                = 0
open("/var/lib/dpkg/info/libdrm2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=226, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libdrm"..., 226) = 226
close(3)                                = 0
open("/var/lib/dpkg/info/libqt4-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=90474, ...}) = 0
brk(0x822000)                           = 0x822000
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 32768) = 32768
read(3, "rt/q3strvec.h\n/usr/include/qt4/Q"..., 32768) = 32768
read(3, "ude/qt4/QtGui/qtabbar.h\n/usr/inc"..., 24938) = 24938
close(3)                                = 0
brk(0x844000)                           = 0x844000
open("/var/lib/dpkg/info/libidl-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=651, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 651) = 651
close(3)                                = 0
open("/var/lib/dpkg/info/gnome-mime-data.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=8385, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/lo"..., 8385) = 8385
close(3)                                = 0
open("/var/lib/dpkg/info/libecj-java.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=217, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 217) = 217
close(3)                                = 0
open("/var/lib/dpkg/info/whiptail.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=309, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/whipta"..., 309) = 309
close(3)                                = 0
open("/var/lib/dpkg/info/libdvdread-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=571, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 571) = 571
close(3)                                = 0
open("/var/lib/dpkg/info/libsepol1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=249, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 249) = 249
close(3)                                = 0
open("/var/lib/dpkg/info/libxml-regexp-perl.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=356, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/pe"..., 356) = 356
close(3)                                = 0
open("/var/lib/dpkg/info/libaspell15.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3237, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 3237) = 3237
close(3)                                = 0
open("/var/lib/dpkg/info/libsp1c2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=449, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libsp."..., 449) = 449
close(3)                                = 0
open("/var/lib/dpkg/info/libpam-modules.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3551, ...}) = 0
read(3, "/.\n/etc\n/etc/security\n/etc/secur"..., 3551) = 3551
close(3)                                = 0
brk(0x866000)                           = 0x866000
open("/var/lib/dpkg/info/tzdata.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=69339, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/zo"..., 32768) = 32768
read(3, "usr/share/zoneinfo/right/Pacific"..., 32768) = 32768
read(3, "ce_Bay\n/usr/share/zoneinfo/Ameri"..., 3803) = 3803
brk(0x888000)                           = 0x888000
close(3)                                = 0
open("/var/lib/dpkg/info/libgnomecanvas2-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=484, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 484) = 484
close(3)                                = 0
open("/var/lib/dpkg/info/libavahi-glib1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=298, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 298) = 298
close(3)                                = 0
open("/var/lib/dpkg/info/python.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1794, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1794) = 1794
close(3)                                = 0
open("/var/lib/dpkg/info/libxrandr-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1147, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1147) = 1147
close(3)                                = 0
open("/var/lib/dpkg/info/libbz2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=140, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libbz2"..., 140) = 140
close(3)                                = 0
open("/var/lib/dpkg/info/gettext.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=10222, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 10222) = 10222
close(3)                                = 0
brk(0x8aa000)                           = 0x8aa000
open("/var/lib/dpkg/info/libfontconfig1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=344, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 344) = 344
close(3)                                = 0
open("/var/lib/dpkg/info/libxv-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1184, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1184) = 1184
close(3)                                = 0
open("/var/lib/dpkg/info/debconf-english.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=65, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 65) = 65
close(3)                                = 0
open("/var/lib/dpkg/info/libxxf86dga1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=254, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 254) = 254
close(3)                                = 0
open("/var/lib/dpkg/info/libglade2-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=433, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 433) = 433
close(3)                                = 0
open("/var/lib/dpkg/info/libxext6.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=230, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 230) = 230
close(3)                                = 0
open("/var/lib/dpkg/info/libgconf2-4.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=645, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 645) = 645
close(3)                                = 0
open("/var/lib/dpkg/info/liblua50.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=232, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/liblua"..., 232) = 232
close(3)                                = 0
open("/var/lib/dpkg/info/libogg0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=224, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libogg"..., 224) = 224
close(3)                                = 0
open("/var/lib/dpkg/info/libcamel1.2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=8308, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 8308) = 8308
close(3)                                = 0
open("/var/lib/dpkg/info/x11-session-utils.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1057, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1057) = 1057
close(3)                                = 0
open("/var/lib/dpkg/info/libakode2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=541, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 541) = 541
close(3)                                = 0
open("/var/lib/dpkg/info/gcc-4.1-multilib.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1269, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1269) = 1269
close(3)                                = 0
open("/var/lib/dpkg/info/libbonobo2-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=15985, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 15985) = 15985
close(3)                                = 0
open("/var/lib/dpkg/info/liblzo2-2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=335, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 335) = 335
close(3)                                = 0
open("/var/lib/dpkg/info/libxrender1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=248, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 248) = 248
close(3)                                = 0
open("/var/lib/dpkg/info/libkpathsea4.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=589, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/li"..., 589) = 589
close(3)                                = 0
open("/var/lib/dpkg/info/dbus.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=880, ...}) = 0
read(3, "/.\n/var\n/var/lib\n/var/lib/dbus\n/"..., 880) = 880
close(3)                                = 0
open("/var/lib/dpkg/info/libgd2-xpm-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1686, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1686) = 1686
close(3)                                = 0
open("/var/lib/dpkg/info/libxfont1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=236, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 236) = 236
close(3)                                = 0
open("/var/lib/dpkg/info/libperl-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=109, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libper"..., 109) = 109
close(3)                                = 0
open("/var/lib/dpkg/info/libthai0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=322, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 322) = 322
close(3)                                = 0
open("/var/lib/dpkg/info/libhal-storage1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=388, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 388) = 388
close(3)                                = 0
open("/var/lib/dpkg/info/libgstreamer-plugins-base0.10-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2890, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2890) = 2890
close(3)                                = 0
open("/var/lib/dpkg/info/libgtk2.0-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2535, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libgtk"..., 2535) = 2535
close(3)                                = 0
open("/var/lib/dpkg/info/qt3-dev-tools.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=9546, ...}) = 0
brk(0x8cc000)                           = 0x8cc000
read(3, "/.\n/usr\n/usr/share\n/usr/share/qt"..., 9546) = 9546
close(3)                                = 0
open("/var/lib/dpkg/info/liboil0.3.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=370, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 370) = 370
close(3)                                = 0
open("/var/lib/dpkg/info/libgnomevfs2-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=14318, ...}) = 0
read(3, "/.\n/etc\n/etc/gnome-vfs-2.0\n/etc/"..., 14318) = 14318
close(3)                                = 0
open("/var/lib/dpkg/info/libebook1.2-9.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=331, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 331) = 331
close(3)                                = 0
open("/var/lib/dpkg/info/gconf2-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=7791, ...}) = 0
read(3, "/.\n/etc\n/etc/gconf\n/etc/gconf/2\n"..., 7791) = 7791
close(3)                                = 0
open("/var/lib/dpkg/info/libsnmp-base.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=6977, ...}) = 0
read(3, "/.\n/var\n/var/lib\n/var/lib/snmp\n/"..., 6977) = 6977
close(3)                                = 0
open("/var/lib/dpkg/info/libpam0g-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2987, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 2987) = 2987
close(3)                                = 0
open("/var/lib/dpkg/info/gawk.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=5073, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 5073) = 5073
close(3)                                = 0
brk(0x8ee000)                           = 0x8ee000
open("/var/lib/dpkg/info/libmpich1.0c2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=632, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/mpich\n"..., 632) = 632
close(3)                                = 0
open("/var/lib/dpkg/info/linux-libc-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=22536, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 22536) = 22536
close(3)                                = 0
open("/var/lib/dpkg/info/libxtst-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=799, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 799) = 799
close(3)                                = 0
open("/var/lib/dpkg/info/x11proto-xext-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1634, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/pkgcon"..., 1634) = 1634
close(3)                                = 0
open("/var/lib/dpkg/info/libartsc0-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=448, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 448) = 448
close(3)                                = 0
open("/var/lib/dpkg/info/libthai-data.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=397, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 397) = 397
close(3)                                = 0
open("/var/lib/dpkg/info/libimlib2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1858, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1858) = 1858
close(3)                                = 0
open("/var/lib/dpkg/info/python-sip4.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=378, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/python"..., 378) = 378
close(3)                                = 0
open("/var/lib/dpkg/info/libmozjs0d.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=248, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 248) = 248
close(3)                                = 0
open("/var/lib/dpkg/info/python2.4-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=7384, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/python"..., 7384) = 7384
close(3)                                = 0
open("/var/lib/dpkg/info/libnss3-0d.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=457, ...}) = 0
brk(0x910000)                           = 0x910000
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/nss\n/u"..., 457) = 457
close(3)                                = 0
open("/var/lib/dpkg/info/libxpm4.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=225, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 225) = 225
close(3)                                = 0
open("/var/lib/dpkg/info/libdbus-qt-1-1c2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=394, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 394) = 394
close(3)                                = 0
open("/var/lib/dpkg/info/gnome-keyring.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=8078, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 8078) = 8078
close(3)                                = 0
open("/var/lib/dpkg/info/tar.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4039, ...}) = 0
read(3, "/.\n/etc\n/etc/rmt\n/sbin\n/usr\n/usr"..., 4039) = 4039
close(3)                                = 0
open("/var/lib/dpkg/info/file.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=452, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/bu"..., 452) = 452
close(3)                                = 0
open("/var/lib/dpkg/info/gcc-4.2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2299, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2299) = 2299
close(3)                                = 0
open("/var/lib/dpkg/info/gcc-4.1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2931, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2931) = 2931
close(3)                                = 0
open("/var/lib/dpkg/info/liburi-perl.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2296, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2296) = 2296
close(3)                                = 0
open("/var/lib/dpkg/info/docbook.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=5748, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 5748) = 5748
close(3)                                = 0
open("/var/lib/dpkg/info/librecode-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=196, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 196) = 196
close(3)                                = 0
open("/var/lib/dpkg/info/libvisual-0.4-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2746, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2746) = 2746
close(3)                                = 0
open("/var/lib/dpkg/info/libxul-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=63049, ...}) = 0
brk(0x936000)                           = 0x936000
read(3, "/.\n/usr\n/usr/share\n/usr/share/xu"..., 32768) = 32768
read(3, "e.properties\n/usr/share/xulrunne"..., 30281) = 30281
close(3)                                = 0
open("/var/lib/dpkg/info/libtasn1-3-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2573, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2573) = 2573
close(3)                                = 0
open("/var/lib/dpkg/info/freeglut3.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=234, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libglu"..., 234) = 234
close(3)                                = 0
open("/var/lib/dpkg/info/libxi-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1956, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1956) = 1956
close(3)                                = 0
open("/var/lib/dpkg/info/zlib1g.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=218, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libz.s"..., 218) = 218
close(3)                                = 0
open("/var/lib/dpkg/info/libopenexr2ldbl.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=566, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 566) = 566
close(3)                                = 0
open("/var/lib/dpkg/info/tk8.4-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2103, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/tk8.4\n"..., 2103) = 2103
close(3)                                = 0
open("/var/lib/dpkg/info/libxul-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=166257, ...}) = 0
mmap(NULL, 172032, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7df2000
brk(0x95c000)                           = 0x95c000
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/pkgcon"..., 32768) = 32768
read(3, "nner/nsIScriptContextOwner.idl\n/"..., 32768) = 32768
read(3, "rentCharsetListener.h\n/usr/inclu"..., 32768) = 32768
read(3, "on.h\n/usr/include/xulrunner/nsID"..., 32768) = 32768
read(3, "/accessibility/nsIAccessibleEven"..., 32768) = 32768
read(3, "runner/sdk/include/nsXPCOMGlue.h"..., 2417) = 2417
brk(0x954000)                           = 0x954000
brk(0x976000)                           = 0x976000
close(3)                                = 0
brk(0x998000)                           = 0x998000
open("/var/lib/dpkg/info/fastjar.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=361, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/fastja"..., 361) = 361
close(3)                                = 0
open("/var/lib/dpkg/info/libopts25-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=745, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libopt"..., 745) = 745
close(3)                                = 0
open("/var/lib/dpkg/info/libbonobo2-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=201, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libbon"..., 201) = 201
close(3)                                = 0
open("/var/lib/dpkg/info/libxrandr2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=242, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 242) = 242
close(3)                                = 0
open("/var/lib/dpkg/info/libglu1-mesa.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=208, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 208) = 208
close(3)                                = 0
open("/var/lib/dpkg/info/adduser.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=5218, ...}) = 0
read(3, "/.\n/etc\n/etc/deluser.conf\n/usr\n/"..., 5218) = 5218
close(3)                                = 0
open("/var/lib/dpkg/info/python-support.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1457, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/pysupp"..., 1457) = 1457
close(3)                                = 0
open("/var/lib/dpkg/info/libfontconfig1-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=14213, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 14213) = 14213
close(3)                                = 0
open("/var/lib/dpkg/info/locales.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=19646, ...}) = 0
brk(0x9be000)                           = 0x9be000
read(3, "/.\n/usr\n/usr/sbin\n/usr/sbin/loca"..., 19646) = 19646
brk(0x9b8000)                           = 0x9b8000
close(3)                                = 0
open("/var/lib/dpkg/info/libmhash-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=563, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 563) = 563
close(3)                                = 0
open("/var/lib/dpkg/info/html2text.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=557, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/html2t"..., 557) = 557
close(3)                                = 0
open("/var/lib/dpkg/info/python2.5.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=20780, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/python"..., 20780) = 20780
close(3)                                = 0
open("/var/lib/dpkg/info/python2.4.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=19111, ...}) = 0
brk(0x9dc000)                           = 0x9dc000
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/python"..., 19111) = 19111
close(3)                                = 0
open("/var/lib/dpkg/info/ed.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=428, ...}) = 0
read(3, "/.\n/bin\n/bin/ed\n/usr\n/usr/bin\n/u"..., 428) = 428
close(3)                                = 0
open("/var/lib/dpkg/info/libsm-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=398, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 398) = 398
close(3)                                = 0
open("/var/lib/dpkg/info/libgnomecanvas2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1553, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1553) = 1553
close(3)                                = 0
open("/var/lib/dpkg/info/autoconf2.13.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1534, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/ifname"..., 1534) = 1534
close(3)                                = 0
open("/var/lib/dpkg/info/libgcc1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=166, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 166) = 166
close(3)                                = 0
open("/var/lib/dpkg/info/libidn11-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3040, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 3040) = 3040
close(3)                                = 0
open("/var/lib/dpkg/info/libxcomposite1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=266, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 266) = 266
close(3)                                = 0
open("/var/lib/dpkg/info/menu-xdg.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=377, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 377) = 377
close(3)                                = 0
open("/var/lib/dpkg/info/libice-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=504, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 504) = 504
close(3)                                = 0
open("/var/lib/dpkg/info/x11proto-fixes-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=368, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 368) = 368
close(3)                                = 0
open("/var/lib/dpkg/info/python-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=92, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/share\n/usr"..., 92) = 92
close(3)                                = 0
open("/var/lib/dpkg/info/libchm1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=454, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 454) = 454
close(3)                                = 0
open("/var/lib/dpkg/info/libidl0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=348, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 348) = 348
close(3)                                = 0
open("/var/lib/dpkg/info/libxv1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=218, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 218) = 218
close(3)                                = 0
open("/var/lib/dpkg/info/libncurses5-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=48864, ...}) = 0
brk(0x9fe000)                           = 0x9fe000
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 32768) = 32768
read(3, "s.gz\n/usr/share/man/man3/noecho."..., 16096) = 16096
close(3)                                = 0
open("/var/lib/dpkg/info/libslang2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1057, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libsla"..., 1057) = 1057
close(3)                                = 0
open("/var/lib/dpkg/info/realpath.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=225, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/realpa"..., 225) = 225
close(3)                                = 0
open("/var/lib/dpkg/info/libjpeg62-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=657, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 657) = 657
close(3)                                = 0
open("/var/lib/dpkg/info/libasound2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2929, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/li"..., 2929) = 2929
close(3)                                = 0
open("/var/lib/dpkg/info/libgnutlsxx13.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=412, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 412) = 412
close(3)                                = 0
open("/var/lib/dpkg/info/mesa-common-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3180, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 3180) = 3180
close(3)                                = 0
open("/var/lib/dpkg/info/base-files.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1314, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1314) = 1314
close(3)                                = 0
open("/var/lib/dpkg/info/libselinux1-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4722, ...}) = 0
brk(0xa20000)                           = 0xa20000
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 4722) = 4722
close(3)                                = 0
open("/var/lib/dpkg/info/gcc-3.4-base.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=317, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 317) = 317
close(3)                                = 0
open("/var/lib/dpkg/info/flex.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2329, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/flex\n/"..., 2329) = 2329
close(3)                                = 0
open("/var/lib/dpkg/info/libxtrap6.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=198, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 198) = 198
close(3)                                = 0
open("/var/lib/dpkg/info/libboost-python1.34.1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=337, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libboo"..., 337) = 337
close(3)                                = 0
open("/var/lib/dpkg/info/mount.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=583, ...}) = 0
read(3, "/.\n/bin\n/bin/mount\n/bin/umount\n/"..., 583) = 583
close(3)                                = 0
open("/var/lib/dpkg/info/x11proto-video-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=469, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/pkgcon"..., 469) = 469
close(3)                                = 0
open("/var/lib/dpkg/info/libsqlite3-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=288, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 288) = 288
close(3)                                = 0
open("/var/lib/dpkg/info/type-handling.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=379, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/type-h"..., 379) = 379
close(3)                                = 0
open("/var/lib/dpkg/info/automake1.4.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3636, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/li"..., 3636) = 3636
close(3)                                = 0
open("/var/lib/dpkg/info/automake1.9.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4833, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/li"..., 4833) = 4833
close(3)                                = 0
open("/var/lib/dpkg/info/mysql-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=506, ...}) = 0
read(3, "/.\n/etc\n/etc/mysql\n/etc/mysql/my"..., 506) = 506
close(3)                                = 0
open("/var/lib/dpkg/info/libavahi-qt3-1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=296, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 296) = 296
close(3)                                = 0
open("/var/lib/dpkg/info/libpq-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3404, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 3404) = 3404
close(3)                                = 0
open("/var/lib/dpkg/info/libreadline5.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=490, ...}) = 0
read(3, "/.\n/etc\n/lib\n/lib/libhistory.so."..., 490) = 490
close(3)                                = 0
open("/var/lib/dpkg/info/libncurses5.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=494, ...}) = 0
read(3, "/.\n/lib\n/lib/libncurses.so.5.6\n/"..., 494) = 494
close(3)                                = 0
open("/var/lib/dpkg/info/libmpcdec3.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=275, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libmpc"..., 275) = 275
close(3)                                = 0
open("/var/lib/dpkg/info/x11proto-xf86vidmode-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=389, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/pkgcon"..., 389) = 389
close(3)                                = 0
open("/var/lib/dpkg/info/libldap2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=6226, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 6226) = 6226
close(3)                                = 0
open("/var/lib/dpkg/info/libcdparanoia0-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=384, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 384) = 384
close(3)                                = 0
open("/var/lib/dpkg/info/x11proto-render-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=368, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 368) = 368
close(3)                                = 0
open("/var/lib/dpkg/info/libkeyutils1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=199, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 199) = 199
close(3)                                = 0
open("/var/lib/dpkg/info/libtidy-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=361, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 361) = 361
close(3)                                = 0
open("/var/lib/dpkg/info/libvorbisenc2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=218, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libvor"..., 218) = 218
close(3)                                = 0
open("/var/lib/dpkg/info/libpango1.0-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=821, ...}) = 0
read(3, "/.\n/var\n/var/lib\n/var/lib/defoma"..., 821) = 821
close(3)                                = 0
open("/var/lib/dpkg/info/libexpat1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=259, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libexp"..., 259) = 259
close(3)                                = 0
open("/var/lib/dpkg/info/libltdl3.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=371, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libltd"..., 371) = 371
close(3)                                = 0
open("/var/lib/dpkg/info/libmad0-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=519, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libmad"..., 519) = 519
close(3)                                = 0
open("/var/lib/dpkg/info/libgnome-keyring-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2326, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2326) = 2326
close(3)                                = 0
open("/var/lib/dpkg/info/docbook-xsl.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=35443, ...}) = 0
brk(0xa4a000)                           = 0xa4a000
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 32768) = 32768
read(3, "ml/docbook/stylesheet/nwalsh/xht"..., 2675) = 2675
close(3)                                = 0
open("/var/lib/dpkg/info/libgnome2-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=9865, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/gc"..., 9865) = 9865
close(3)                                = 0
open("/var/lib/dpkg/info/libxt-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=12682, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 12682) = 12682
close(3)                                = 0
open("/var/lib/dpkg/info/docbook-to-man.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=657, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/docboo"..., 657) = 657
close(3)                                = 0
open("/var/lib/dpkg/info/libglu1-mesa-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=286, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 286) = 286
close(3)                                = 0
open("/var/lib/dpkg/info/libchm-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=964, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 964) = 964
close(3)                                = 0
open("/var/lib/dpkg/info/libt1-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=518, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libt1."..., 518) = 518
close(3)                                = 0
open("/var/lib/dpkg/info/texlive-latex-recommended.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=147393, ...}) = 0
mmap(NULL, 155648, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7dcc000
brk(0xa72000)                           = 0xa72000
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 32768) = 32768
read(3, "rotype/mt-msb.cfg\n/usr/share/tex"..., 32768) = 32768
read(3, "/fonts/source/jknappen/ec/ecsc09"..., 32768) = 32768
read(3, "bx0600.tfm\n/usr/share/texmf-texl"..., 32768) = 32768
read(3, "iek/pdfatfi.pl\n/usr/share/texmf-"..., 16321) = 16321
brk(0xa6a000)                           = 0xa6a000
close(3)                                = 0
brk(0xa8c000)                           = 0xa8c000
open("/var/lib/dpkg/info/libgadu-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1202, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 1202) = 1202
close(3)                                = 0
open("/var/lib/dpkg/info/python-dbg.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=287, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/share\n/usr"..., 287) = 287
close(3)                                = 0
open("/var/lib/dpkg/info/patch.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=337, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/patch\n"..., 337) = 337
close(3)                                = 0
open("/var/lib/dpkg/info/libpango1.0-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1181, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libpan"..., 1181) = 1181
close(3)                                = 0
open("/var/lib/dpkg/info/odbcinst1debian1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=907, ...}) = 0
read(3, "/.\n/etc\n/etc/ODBCDataSources\n/et"..., 907) = 907
close(3)                                = 0
open("/var/lib/dpkg/info/libxft-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=532, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 532) = 532
close(3)                                = 0
open("/var/lib/dpkg/info/docbook-dsssl.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=16824, ...}) = 0
brk(0xab0000)                           = 0xab0000
read(3, "/.\n/usr\n/usr/share\n/usr/share/sg"..., 16824) = 16824
brk(0xaaa000)                           = 0xaaa000
close(3)                                = 0
open("/var/lib/dpkg/info/libdbus-qt-1-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=597, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 597) = 597
close(3)                                = 0
open("/var/lib/dpkg/info/intltool-debian.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=390, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 390) = 390
close(3)                                = 0
open("/var/lib/dpkg/info/libdevmapper1.02.1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=294, ...}) = 0
read(3, "/.\n/lib\n/lib/libdevmapper.so.1.0"..., 294) = 294
close(3)                                = 0
open("/var/lib/dpkg/info/libxi6.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=218, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 218) = 218
close(3)                                = 0
open("/var/lib/dpkg/info/libhal1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=316, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 316) = 316
close(3)                                = 0
open("/var/lib/dpkg/info/libsnmp-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=15331, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 15331) = 15331
close(3)                                = 0
open("/var/lib/dpkg/info/libattr1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=201, ...}) = 0
read(3, "/.\n/lib\n/lib/libattr.so.1.1.0\n/u"..., 201) = 201
close(3)                                = 0
open("/var/lib/dpkg/info/freeglut3-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=740, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 740) = 740
close(3)                                = 0
open("/var/lib/dpkg/info/libhtml-tree-perl.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1246, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/pe"..., 1246) = 1246
close(3)                                = 0
open("/var/lib/dpkg/info/libsnmp15.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=994, ...}) = 0
read(3, "/.\n/var\n/var/lib\n/var/lib/snmp\n/"..., 994) = 994
close(3)                                = 0
open("/var/lib/dpkg/info/sed.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3530, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 3530) = 3530
close(3)                                = 0
open("/var/lib/dpkg/info/libperl5.8.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=60, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 60) = 60
close(3)                                = 0
open("/var/lib/dpkg/info/libidn11.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=408, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 408) = 408
close(3)                                = 0
open("/var/lib/dpkg/info/libxml2-utils.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=213, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 213) = 213
close(3)                                = 0
open("/var/lib/dpkg/info/libtheora0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=312, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 312) = 312
close(3)                                = 0
open("/var/lib/dpkg/info/autogen.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2330, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/pkgcon"..., 2330) = 2330
close(3)                                = 0
open("/var/lib/dpkg/info/x11proto-randr-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=461, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 461) = 461
close(3)                                = 0
open("/var/lib/dpkg/info/x11proto-kb-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=458, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 458) = 458
close(3)                                = 0
open("/var/lib/dpkg/info/libgtk2.0-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=14887, ...}) = 0
brk(0xace000)                           = 0xace000
read(3, "/.\n/usr\n/usr/share\n/usr/share/th"..., 14887) = 14887
close(3)                                = 0
open("/var/lib/dpkg/info/libgpg-error-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=622, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libgpg"..., 622) = 622
close(3)                                = 0
open("/var/lib/dpkg/info/libtiff4.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=6699, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 6699) = 6699
close(3)                                = 0
open("/var/lib/dpkg/info/libaudiofile0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=485, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libaud"..., 485) = 485
close(3)                                = 0
open("/var/lib/dpkg/info/libwrap0-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=453, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libwra"..., 453) = 453
close(3)                                = 0
open("/var/lib/dpkg/info/libgmp3-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=436, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libgmp"..., 436) = 436
close(3)                                = 0
open("/var/lib/dpkg/info/libavahi-common-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=924, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 924) = 924
close(3)                                = 0
open("/var/lib/dpkg/info/g++.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=139, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 139) = 139
close(3)                                = 0
open("/var/lib/dpkg/info/e2fslibs.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=219, ...}) = 0
read(3, "/.\n/lib\n/lib/libext2fs.so.2.4\n/l"..., 219) = 219
close(3)                                = 0
open("/var/lib/dpkg/info/libg2c0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=226, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 226) = 226
close(3)                                = 0
open("/var/lib/dpkg/info/xulrunner.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1406, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/xulrun"..., 1406) = 1406
close(3)                                = 0
open("/var/lib/dpkg/info/libgcj8-1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=344, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 344) = 344
close(3)                                = 0
open("/var/lib/dpkg/info/libfam-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=556, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 556) = 556
close(3)                                = 0
open("/var/lib/dpkg/info/libcppunit-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4097, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/DllPlu"..., 4097) = 4097
close(3)                                = 0
open("/var/lib/dpkg/info/libsilc-1.1-2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=694, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 694) = 694
close(3)                                = 0
open("/var/lib/dpkg/info/libxaw7-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=298, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 298) = 298
close(3)                                = 0
open("/var/lib/dpkg/info/x11proto-xf86dga-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=502, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 502) = 502
close(3)                                = 0
open("/var/lib/dpkg/info/libgl1-mesa-glx.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=208, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 208) = 208
close(3)                                = 0
open("/var/lib/dpkg/info/x11-utils.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1361, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1361) = 1361
close(3)                                = 0
open("/var/lib/dpkg/info/base-passwd.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=642, ...}) = 0
read(3, "/.\n/usr\n/usr/sbin\n/usr/sbin/upda"..., 642) = 642
close(3)                                = 0
open("/var/lib/dpkg/info/libsqlite0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=276, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 276) = 276
close(3)                                = 0
open("/var/lib/dpkg/info/libaprutil1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=277, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libapr"..., 277) = 277
close(3)                                = 0
open("/var/lib/dpkg/info/x11proto-xinerama-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=424, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/pkgcon"..., 424) = 424
close(3)                                = 0
open("/var/lib/dpkg/info/gcc-4.1-base.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=362, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 362) = 362
close(3)                                = 0
open("/var/lib/dpkg/info/libjack0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=553, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 553) = 553
close(3)                                = 0
open("/var/lib/dpkg/info/libpaper-utils.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=379, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/paperc"..., 379) = 379
close(3)                                = 0
open("/var/lib/dpkg/info/libc6-sparc64.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=8244, ...}) = 0
brk(0xaf0000)                           = 0xaf0000
read(3, "/.\n/lib64\n/lib64/ld-2.6.1.so\n/li"..., 8244) = 8244
brk(0xaee000)                           = 0xaee000
close(3)                                = 0
open("/var/lib/dpkg/info/libboost-python-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=10802, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 10802) = 10802
close(3)                                = 0
open("/var/lib/dpkg/info/libxul0d.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1420, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/xulrun"..., 1420) = 1420
close(3)                                = 0
open("/var/lib/dpkg/info/libcomerr2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=191, ...}) = 0
read(3, "/.\n/lib\n/lib/libcom_err.so.2.1\n/"..., 191) = 191
close(3)                                = 0
open("/var/lib/dpkg/info/libraw1394-8.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=441, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libraw"..., 441) = 441
close(3)                                = 0
open("/var/lib/dpkg/info/mawk.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=759, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/mawk\n/"..., 759) = 759
close(3)                                = 0
open("/var/lib/dpkg/info/texlive-latex-base.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=81143, ...}) = 0
brk(0xb16000)                           = 0xb16000
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 32768) = 32768
read(3, "sr/share/texmf-texlive/tex/latex"..., 32768) = 32768
read(3, "ex/babel\n/usr/share/texmf-texliv"..., 15607) = 15607
close(3)                                = 0
brk(0xb38000)                           = 0xb38000
open("/var/lib/dpkg/info/gnupg.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4466, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/gpgspl"..., 4466) = 4466
close(3)                                = 0
open("/var/lib/dpkg/info/libjasper-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=976, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 976) = 976
close(3)                                = 0
open("/var/lib/dpkg/info/libnewt0.52.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=5611, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libnew"..., 5611) = 5611
close(3)                                = 0
open("/var/lib/dpkg/info/libdb4.6.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=167, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libdb-"..., 167) = 167
close(3)                                = 0
open("/var/lib/dpkg/info/libxmu-headers.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=926, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 926) = 926
close(3)                                = 0
open("/var/lib/dpkg/info/libdb4.4.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=167, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libdb-"..., 167) = 167
close(3)                                = 0
open("/var/lib/dpkg/info/jade.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=812, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/jade\n/"..., 812) = 812
close(3)                                = 0
open("/var/lib/dpkg/info/libgail18.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=7676, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 7676) = 7676
close(3)                                = 0
open("/var/lib/dpkg/info/x11-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1008, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/X\n/usr"..., 1008) = 1008
close(3)                                = 0
open("/var/lib/dpkg/info/libxdamage-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=396, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 396) = 396
close(3)                                = 0
open("/var/lib/dpkg/info/net-tools.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1329, ...}) = 0
read(3, "/.\n/usr\n/usr/sbin\n/usr/sbin/arp\n"..., 1329) = 1329
close(3)                                = 0
open("/var/lib/dpkg/info/libxfixes3.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=203, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 203) = 203
close(3)                                = 0
open("/var/lib/dpkg/info/liblualib50.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=316, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/liblua"..., 316) = 316
close(3)                                = 0
open("/var/lib/dpkg/info/libgtk2.0-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=11640, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/dh_gtk"..., 11640) = 11640
close(3)                                = 0
open("/var/lib/dpkg/info/libxml-perl.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2669, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/pe"..., 2669) = 2669
close(3)                                = 0
open("/var/lib/dpkg/info/libfs6.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=183, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 183) = 183
close(3)                                = 0
open("/var/lib/dpkg/info/libgtkspell-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1111, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libgtk"..., 1111) = 1111
close(3)                                = 0
open("/var/lib/dpkg/info/libxmu6.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=224, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 224) = 224
close(3)                                = 0
brk(0xb5a000)                           = 0xb5a000
open("/var/lib/dpkg/info/grep.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2454, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/rgrep\n"..., 2454) = 2454
close(3)                                = 0
open("/var/lib/dpkg/info/libstartup-notification0-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=937, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 937) = 937
close(3)                                = 0
open("/var/lib/dpkg/info/libedataserver1.2-9.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=379, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 379) = 379
close(3)                                = 0
open("/var/lib/dpkg/info/libapr1-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=11935, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 11935) = 11935
close(3)                                = 0
open("/var/lib/dpkg/info/x11proto-record-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=366, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/pkgcon"..., 366) = 366
close(3)                                = 0
open("/var/lib/dpkg/info/libxaw-headers.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2569, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2569) = 2569
close(3)                                = 0
open("/var/lib/dpkg/info/gcc-4.2-base.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=233, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 233) = 233
close(3)                                = 0
open("/var/lib/dpkg/info/libodbcinstq1c2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=268, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libodb"..., 268) = 268
close(3)                                = 0
open("/var/lib/dpkg/info/libcurl3.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=632, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libcur"..., 632) = 632
close(3)                                = 0
open("/var/lib/dpkg/info/autoconf.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2688, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/autom4"..., 2688) = 2688
close(3)                                = 0
open("/var/lib/dpkg/info/libxdamage1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=248, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 248) = 248
close(3)                                = 0
open("/var/lib/dpkg/info/x11-xserver-utils.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1522, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1522) = 1522
close(3)                                = 0
open("/var/lib/dpkg/info/libxaw7.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=247, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 247) = 247
close(3)                                = 0
open("/var/lib/dpkg/info/gnome-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=595, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/gnome-"..., 595) = 595
close(3)                                = 0
open("/var/lib/dpkg/info/sgml-data.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=8515, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/sg"..., 8515) = 8515
close(3)                                = 0
open("/var/lib/dpkg/info/libavahi-glib-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=494, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 494) = 494
close(3)                                = 0
open("/var/lib/dpkg/info/flac.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=294, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/flac\n/"..., 294) = 294
close(3)                                = 0
open("/var/lib/dpkg/info/libaspell-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=445, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 445) = 445
close(3)                                = 0
open("/var/lib/dpkg/info/libmng1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=269, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/lib\n/u"..., 269) = 269
close(3)                                = 0
open("/var/lib/dpkg/info/libgadu3.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=322, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libgad"..., 322) = 322
close(3)                                = 0
open("/var/lib/dpkg/info/libpoppler1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=426, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 426) = 426
close(3)                                = 0
open("/var/lib/dpkg/info/libcamel1.2-10.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=417, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 417) = 417
close(3)                                = 0
open("/var/lib/dpkg/info/libxxf86dga-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1219, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1219) = 1219
close(3)                                = 0
open("/var/lib/dpkg/info/libsasl2-modules.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1132, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1132) = 1132
close(3)                                = 0
open("/var/lib/dpkg/info/libsasl2-2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=455, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 455) = 455
close(3)                                = 0
open("/var/lib/dpkg/info/passwd.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=11465, ...}) = 0
brk(0xb7e000)                           = 0xb7e000
read(3, "/.\n/usr\n/usr/share\n/usr/share/li"..., 11465) = 11465
close(3)                                = 0
open("/var/lib/dpkg/info/libiec61883-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=368, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 368) = 368
close(3)                                = 0
open("/var/lib/dpkg/info/libimlib2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=913, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 913) = 913
close(3)                                = 0
open("/var/lib/dpkg/info/hostname.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=316, ...}) = 0
read(3, "/.\n/bin\n/bin/hostname\n/bin/dnsdo"..., 316) = 316
close(3)                                = 0
open("/var/lib/dpkg/info/libsensors-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=445, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 445) = 445
close(3)                                = 0
open("/var/lib/dpkg/info/fakeroot.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1538, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/fakero"..., 1538) = 1538
close(3)                                = 0
open("/var/lib/dpkg/info/libacl1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=195, ...}) = 0
read(3, "/.\n/lib\n/lib/libacl.so.1.1.0\n/us"..., 195) = 195
close(3)                                = 0
open("/var/lib/dpkg/info/libebook1.2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2316, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2316) = 2316
close(3)                                = 0
open("/var/lib/dpkg/info/libdbus-glib-1-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=788, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 788) = 788
close(3)                                = 0
open("/var/lib/dpkg/info/libstartup-notification0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=426, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 426) = 426
close(3)                                = 0
open("/var/lib/dpkg/info/libpam-runtime.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2661, ...}) = 0
read(3, "/.\n/etc\n/etc/pam.conf\n/etc/pam.d"..., 2661) = 2661
close(3)                                = 0
open("/var/lib/dpkg/info/libaudio2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=386, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libaud"..., 386) = 386
close(3)                                = 0
open("/var/lib/dpkg/info/docbook-xml.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=7383, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 7383) = 7383
close(3)                                = 0
open("/var/lib/dpkg/info/liblualib50-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=430, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/liblua"..., 430) = 430
close(3)                                = 0
open("/var/lib/dpkg/info/libgstreamer0.10-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3348, ...}) = 0
read(3, "/.\n/var\n/var/lib\n/var/lib/gstrea"..., 3348) = 3348
close(3)                                = 0
open("/var/lib/dpkg/info/sysvinit.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=887, ...}) = 0
read(3, "/.\n/etc\n/usr\n/usr/share\n/usr/sha"..., 887) = 887
close(3)                                = 0
open("/var/lib/dpkg/info/lua50.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1184, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/lua50\n"..., 1184) = 1184
close(3)                                = 0
open("/var/lib/dpkg/info/libslang2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=489, ...}) = 0
read(3, "/.\n/lib\n/lib/libslang.so.2.0.7\n/"..., 489) = 489
close(3)                                = 0
open("/var/lib/dpkg/info/libxmltok1-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=933, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 933) = 933
close(3)                                = 0
open("/var/lib/dpkg/info/initscripts.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1623, ...}) = 0
read(3, "/.\n/sbin\n/sbin/fsck.nfs\n/lib\n/li"..., 1623) = 1623
close(3)                                = 0
open("/var/lib/dpkg/info/libblkid1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=184, ...}) = 0
read(3, "/.\n/lib\n/lib/libblkid.so.1.0\n/us"..., 184) = 184
close(3)                                = 0
open("/var/lib/dpkg/info/texlive-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1443, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1443) = 1443
close(3)                                = 0
open("/var/lib/dpkg/info/libdatrie0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=309, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 309) = 309
close(3)                                = 0
open("/var/lib/dpkg/info/liborbit2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=569, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 569) = 569
close(3)                                = 0
open("/var/lib/dpkg/info/dc.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=521, ...}) = 0
brk(0xba0000)                           = 0xba0000
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/dc\n/us"..., 521) = 521
close(3)                                = 0
open("/var/lib/dpkg/info/libstdc++6-4.2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=34131, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 32768) = 32768
read(3, "sr/include/c++/4.2/sparc-linux-g"..., 1363) = 1363
close(3)                                = 0
open("/var/lib/dpkg/info/libss2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=169, ...}) = 0
read(3, "/.\n/lib\n/lib/libss.so.2.0\n/usr\n/"..., 169) = 169
close(3)                                = 0
open("/var/lib/dpkg/info/libssh2-1-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4434, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 4434) = 4434
close(3)                                = 0
open("/var/lib/dpkg/info/libavahi-common-data.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=341, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 341) = 341
close(3)                                = 0
open("/var/lib/dpkg/info/apache2-utils.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=873, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/dbmman"..., 873) = 873
close(3)                                = 0
open("/var/lib/dpkg/info/findutils.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4604, ...}) = 0
read(3, "/.\n/etc\n/etc/cron.daily\n/etc/cro"..., 4604) = 4604
close(3)                                = 0
open("/var/lib/dpkg/info/libxft2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=224, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 224) = 224
close(3)                                = 0
open("/var/lib/dpkg/info/libgnomecanvas2-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=9197, ...}) = 0
brk(0xbc2000)                           = 0xbc2000
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 9197) = 9197
brk(0xbc0000)                           = 0xbc0000
close(3)                                = 0
open("/var/lib/dpkg/info/libgail-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=435, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 435) = 435
close(3)                                = 0
open("/var/lib/dpkg/info/gcj-4.2-base.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=233, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 233) = 233
close(3)                                = 0
open("/var/lib/dpkg/info/libqt3-mt-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=995, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/qt"..., 995) = 995
close(3)                                = 0
open("/var/lib/dpkg/info/libxau-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=707, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 707) = 707
close(3)                                = 0
open("/var/lib/dpkg/info/libtidy-0.99-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=241, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 241) = 241
close(3)                                = 0
open("/var/lib/dpkg/info/python-xml.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=33567, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 32768) = 32768
read(3, "usr/lib/python2.4/site-packages\n"..., 799) = 799
close(3)                                = 0
open("/var/lib/dpkg/info/libgnomevfs2-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=859, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 859) = 859
close(3)                                = 0
open("/var/lib/dpkg/info/xfonts-encodings.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2966, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2966) = 2966
close(3)                                = 0
open("/var/lib/dpkg/info/libx11-6.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=191, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 191) = 191
close(3)                                = 0
open("/var/lib/dpkg/info/libsensors3.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=289, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libsen"..., 289) = 289
close(3)                                = 0
open("/var/lib/dpkg/info/libjasper1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=243, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 243) = 243
close(3)                                = 0
open("/var/lib/dpkg/info/libspeex-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=713, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 713) = 713
close(3)                                = 0
open("/var/lib/dpkg/info/libmysqlclient15-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3490, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 3490) = 3490
close(3)                                = 0
brk(0xbe2000)                           = 0xbe2000
open("/var/lib/dpkg/info/e2fsprogs.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2794, ...}) = 0
read(3, "/.\n/sbin\n/sbin/e2fsck\n/sbin/fsck"..., 2794) = 2794
close(3)                                = 0
open("/var/lib/dpkg/info/libpaper1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=322, ...}) = 0
read(3, "/.\n/etc\n/etc/libpaper.d\n/usr\n/us"..., 322) = 322
close(3)                                = 0
open("/var/lib/dpkg/info/ecj.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=240, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 240) = 240
close(3)                                = 0
open("/var/lib/dpkg/info/libgstreamer-plugins-base0.10-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4314, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 4314) = 4314
close(3)                                = 0
open("/var/lib/dpkg/info/libnss3-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2771, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/nss-co"..., 2771) = 2771
close(3)                                = 0
open("/var/lib/dpkg/info/libsoup2.2-8.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=361, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 361) = 361
close(3)                                = 0
open("/var/lib/dpkg/info/libopencdk10-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=816, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 816) = 816
close(3)                                = 0
open("/var/lib/dpkg/info/libatk1.0-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=355, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 355) = 355
close(3)                                = 0
open("/var/lib/dpkg/info/python-central.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=780, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/py_com"..., 780) = 780
close(3)                                = 0
open("/var/lib/dpkg/info/libhesiod0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=354, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libhes"..., 354) = 354
close(3)                                = 0
open("/var/lib/dpkg/info/libgcj-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=821, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 821) = 821
close(3)                                = 0
open("/var/lib/dpkg/info/libhal-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=429, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 429) = 429
close(3)                                = 0
open("/var/lib/dpkg/info/libopenexr-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4714, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 4714) = 4714
close(3)                                = 0
open("/var/lib/dpkg/info/libhal-storage-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=517, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 517) = 517
close(3)                                = 0
open("/var/lib/dpkg/info/libpng12-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=658, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 658) = 658
close(3)                                = 0
open("/var/lib/dpkg/info/libavahi-common3.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=312, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 312) = 312
close(3)                                = 0
open("/var/lib/dpkg/info/libgconf2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2291, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2291) = 2291
close(3)                                = 0
open("/var/lib/dpkg/info/cpp.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=268, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 268) = 268
close(3)                                = 0
open("/var/lib/dpkg/info/xsltproc.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=429, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/xsltpr"..., 429) = 429
close(3)                                = 0
open("/var/lib/dpkg/info/dbus-x11.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=446, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 446) = 446
close(3)                                = 0
open("/var/lib/dpkg/info/libarts1-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4226, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 4226) = 4226
close(3)                                = 0
open("/var/lib/dpkg/info/libdbus-1-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1252, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1252) = 1252
close(3)                                = 0
open("/var/lib/dpkg/info/xutils.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=123, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 123) = 123
close(3)                                = 0
open("/var/lib/dpkg/info/debian-archive-keyring.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=338, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/ke"..., 338) = 338
close(3)                                = 0
open("/var/lib/dpkg/info/libavahi-qt3-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=443, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 443) = 443
close(3)                                = 0
open("/var/lib/dpkg/info/libsnmp-perl.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2146, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2146) = 2146
close(3)                                = 0
open("/var/lib/dpkg/info/libgnomeui-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=9969, ...}) = 0
brk(0xc04000)                           = 0xc04000
read(3, "/.\n/usr\n/usr/share\n/usr/share/pi"..., 9969) = 9969
close(3)                                = 0
open("/var/lib/dpkg/info/gzip.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1010, ...}) = 0
read(3, "/.\n/bin\n/bin/gzip\n/bin/gunzip\n/b"..., 1010) = 1010
close(3)                                = 0
open("/var/lib/dpkg/info/libwww-perl.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4345, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/pe"..., 4345) = 4345
close(3)                                = 0
open("/var/lib/dpkg/info/chrpath.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=432, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/chrpat"..., 432) = 432
close(3)                                = 0
open("/var/lib/dpkg/info/dpkg.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=6997, ...}) = 0
read(3, "/.\n/etc\n/etc/dpkg\n/etc/dpkg/dpkg"..., 6997) = 6997
close(3)                                = 0
open("/var/lib/dpkg/info/libqt3-headers.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=10631, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 10631) = 10631
close(3)                                = 0
open("/var/lib/dpkg/info/libpcre3.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=579, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libpcr"..., 579) = 579
close(3)                                = 0
open("/var/lib/dpkg/info/pkg-config.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=476, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/pkgcon"..., 476) = 476
close(3)                                = 0
open("/var/lib/dpkg/info/liblua50-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=472, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/liblua"..., 472) = 472
close(3)                                = 0
open("/var/lib/dpkg/info/libaudio-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=7114, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 7114) = 7114
close(3)                                = 0
open("/var/lib/dpkg/info/libncursesw5.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=433, ...}) = 0
read(3, "/.\n/lib\n/lib/libncursesw.so.5.6\n"..., 433) = 433
close(3)                                = 0
open("/var/lib/dpkg/info/libxml2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2295, ...}) = 0
brk(0xc26000)                           = 0xc26000
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2295) = 2295
close(3)                                = 0
open("/var/lib/dpkg/info/dbs.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=846, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 846) = 846
close(3)                                = 0
open("/var/lib/dpkg/info/gtk-doc-tools.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2987, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/em"..., 2987) = 2987
close(3)                                = 0
open("/var/lib/dpkg/info/libdb4.4-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=308, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libdb-"..., 308) = 308
close(3)                                = 0
open("/var/lib/dpkg/info/libncursesw5-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1111, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 1111) = 1111
close(3)                                = 0
open("/var/lib/dpkg/info/libsoup2.2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1734, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1734) = 1734
close(3)                                = 0
open("/var/lib/dpkg/info/build-essential.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=390, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/bu"..., 390) = 390
close(3)                                = 0
open("/var/lib/dpkg/info/python-all-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=64, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 64) = 64
close(3)                                = 0
open("/var/lib/dpkg/info/libxxf86vm-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1360, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1360) = 1360
close(3)                                = 0
open("/var/lib/dpkg/info/quilt.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2224, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/qu"..., 2224) = 2224
close(3)                                = 0
open("/var/lib/dpkg/info/kdelibs-data.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=266441, ...}) = 0
mmap(NULL, 270336, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7d8a000
read(3, "/.\n/etc\n/etc/kde3\n/etc/kde3/kdeb"..., 32768) = 32768
read(3, "g\n/usr/share/icons/crystalsvg/16"..., 32768) = 32768
read(3, "vg/22x22/actions/mail_find.png\n/"..., 32768) = 32768
read(3, "scalable/mimetypes/source_o.svgz"..., 32768) = 32768
read(3, "elnk/application/x-sqlite3.deskt"..., 32768) = 32768
read(3, "ation/en-GB/entities/fdl-notice."..., 32768) = 32768
read(3, "\n/usr/share/apps/ksgmltools2/cus"..., 32768) = 32768
read(3, ".embed.for.svg.xml\n/usr/share/ap"..., 32768) = 32768
read(3, "/ent/iso-num.ent\n/usr/share/apps"..., 4297) = 4297
brk(0xc48000)                           = 0xc48000
close(3)                                = 0
brk(0xc6a000)                           = 0xc6a000
brk(0xc8c000)                           = 0xc8c000
open("/var/lib/dpkg/info/x11proto-core-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=992, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 992) = 992
close(3)                                = 0
open("/var/lib/dpkg/info/libopencdk8.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
close(3)                                = 0
open("/var/lib/dpkg/info/libfreebob0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=428, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 428) = 428
close(3)                                = 0
open("/var/lib/dpkg/info/libssl-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=51600, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libssl"..., 32768) = 32768
read(3, ".gz\n/usr/share/man/man3/RSA_padd"..., 18832) = 18832
brk(0xcae000)                           = 0xcae000
close(3)                                = 0
open("/var/lib/dpkg/info/libbonoboui2-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=11737, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 11737) = 11737
close(3)                                = 0
open("/var/lib/dpkg/info/libhunspell-1.1-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=282, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libhun"..., 282) = 282
close(3)                                = 0
open("/var/lib/dpkg/info/libxss-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=882, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 882) = 882
close(3)                                = 0
open("/var/lib/dpkg/info/gcc.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=354, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 354) = 354
close(3)                                = 0
open("/var/lib/dpkg/info/libmcrypt4.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=482, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libmcr"..., 482) = 482
close(3)                                = 0
open("/var/lib/dpkg/info/libgc-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1262, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1262) = 1262
close(3)                                = 0
open("/var/lib/dpkg/info/diffstat.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=300, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 300) = 300
close(3)                                = 0
open("/var/lib/dpkg/info/libx11-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=25393, ...}) = 0
brk(0xcd0000)                           = 0xcd0000
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 25393) = 25393
close(3)                                = 0
open("/var/lib/dpkg/info/liblcms1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=299, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/liblcm"..., 299) = 299
close(3)                                = 0
open("/var/lib/dpkg/info/libcupsys2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=560, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/cups-c"..., 560) = 560
close(3)                                = 0
open("/var/lib/dpkg/info/libartsc0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=198, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 198) = 198
close(3)                                = 0
open("/var/lib/dpkg/info/diff.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2040, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2040) = 2040
close(3)                                = 0
open("/var/lib/dpkg/info/doxygen.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=409, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/doxyge"..., 409) = 409
close(3)                                = 0
open("/var/lib/dpkg/info/xtrans-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=730, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 730) = 730
close(3)                                = 0
open("/var/lib/dpkg/info/dejagnu.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=8586, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/runtes"..., 8586) = 8586
close(3)                                = 0
open("/var/lib/dpkg/info/libpspell-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=578, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 578) = 578
close(3)                                = 0
open("/var/lib/dpkg/info/guile-1.6-libs.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3781, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libgui"..., 3781) = 3781
close(3)                                = 0
open("/var/lib/dpkg/info/libbz2-1.0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=243, ...}) = 0
read(3, "/.\n/lib\n/lib/libbz2.so.1.0.3\n/us"..., 243) = 243
close(3)                                = 0
open("/var/lib/dpkg/info/ecj-gcj.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=227, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/ecj-gc"..., 227) = 227
close(3)                                = 0
open("/var/lib/dpkg/info/libvisual-0.4-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=792, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libvis"..., 792) = 792
close(3)                                = 0
open("/var/lib/dpkg/info/libungif4-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=422, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 422) = 422
close(3)                                = 0
open("/var/lib/dpkg/info/perl.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=23286, ...}) = 0
brk(0xcf6000)                           = 0xcf6000
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/a2p\n/u"..., 23286) = 23286
close(3)                                = 0
open("/var/lib/dpkg/info/automake.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4985, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/li"..., 4985) = 4985
close(3)                                = 0
open("/var/lib/dpkg/info/libedata-book1.2-2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=371, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 371) = 371
close(3)                                = 0
open("/var/lib/dpkg/info/libmpcdec-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4596, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libmpc"..., 4596) = 4596
close(3)                                = 0
open("/var/lib/dpkg/info/x11proto-damage-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=474, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 474) = 474
close(3)                                = 0
open("/var/lib/dpkg/info/unixodbc-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=736, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libgtr"..., 736) = 736
close(3)                                = 0
open("/var/lib/dpkg/info/libhtml-parser-perl.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1425, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/perl5\n"..., 1425) = 1425
close(3)                                = 0
open("/var/lib/dpkg/info/libakode-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1404, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1404) = 1404
close(3)                                = 0
open("/var/lib/dpkg/info/comerr-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1345, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libcom"..., 1345) = 1345
close(3)                                = 0
open("/var/lib/dpkg/info/libkadm55.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=523, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libkad"..., 523) = 523
close(3)                                = 0
open("/var/lib/dpkg/info/libflac++-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=503, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libFLA"..., 503) = 503
close(3)                                = 0
open("/var/lib/dpkg/info/libtiff4-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2091, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2091) = 2091
close(3)                                = 0
open("/var/lib/dpkg/info/libqt4-core.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2030, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2030) = 2030
close(3)                                = 0
open("/var/lib/dpkg/info/libtag1c2a.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=239, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libtag"..., 239) = 239
close(3)                                = 0
brk(0xd18000)                           = 0xd18000
open("/var/lib/dpkg/info/libvorbis0a.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=206, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libvor"..., 206) = 206
close(3)                                = 0
open("/var/lib/dpkg/info/libgnomevfs2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3944, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 3944) = 3944
close(3)                                = 0
open("/var/lib/dpkg/info/apache2.2-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=19834, ...}) = 0
read(3, "/.\n/etc\n/etc/apache2\n/etc/apache"..., 19834) = 19834
close(3)                                = 0
open("/var/lib/dpkg/info/python-xml-dbg.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1854, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/python"..., 1854) = 1854
close(3)                                = 0
open("/var/lib/dpkg/info/zlib1g-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1071, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libz.a"..., 1071) = 1071
close(3)                                = 0
open("/var/lib/dpkg/info/libreadline5-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1124, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libhis"..., 1124) = 1124
close(3)                                = 0
open("/var/lib/dpkg/info/libqt4-qt3support.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=596, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 596) = 596
close(3)                                = 0
open("/var/lib/dpkg/info/libavahi-client3.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=312, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 312) = 312
close(3)                                = 0
open("/var/lib/dpkg/info/libguile-ltdl-1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=226, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libgui"..., 226) = 226
close(3)                                = 0
open("/var/lib/dpkg/info/dselect.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4681, ...}) = 0
read(3, "/.\n/etc\n/etc/dpkg\n/etc/dpkg/dsel"..., 4681) = 4681
close(3)                                = 0
open("/var/lib/dpkg/info/gconf2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=611, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 611) = 611
close(3)                                = 0
open("/var/lib/dpkg/info/mime-support.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=829, ...}) = 0
read(3, "/.\n/etc\n/etc/mime.types\n/etc/mai"..., 829) = 829
close(3)                                = 0
open("/var/lib/dpkg/info/libxine1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=7510, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libxin"..., 7510) = 7510
close(3)                                = 0
open("/var/lib/dpkg/info/libmhash2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=331, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libmha"..., 331) = 331
close(3)                                = 0
open("/var/lib/dpkg/info/libvolume-id0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=249, ...}) = 0
read(3, "/.\n/lib\n/lib/libvolume_id.so.0.7"..., 249) = 249
close(3)                                = 0
open("/var/lib/dpkg/info/xml-core.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1398, ...}) = 0
brk(0xd3a000)                           = 0xd3a000
read(3, "/.\n/etc\n/etc/xml\n/etc/sgml\n/var\n"..., 1398) = 1398
close(3)                                = 0
open("/var/lib/dpkg/info/sysvinit-utils.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=549, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 549) = 549
close(3)                                = 0
open("/var/lib/dpkg/info/libacl1-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1880, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 1880) = 1880
close(3)                                = 0
open("/var/lib/dpkg/info/libgnome-keyring0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=444, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 444) = 444
close(3)                                = 0
open("/var/lib/dpkg/info/python-all.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=60, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 60) = 60
close(3)                                = 0
open("/var/lib/dpkg/info/libgcj-bc.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=179, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/li"..., 179) = 179
close(3)                                = 0
open("/var/lib/dpkg/info/libgcj8-jar.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=145, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/ja"..., 145) = 145
close(3)                                = 0
open("/var/lib/dpkg/info/fontconfig-config.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2036, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2036) = 2036
close(3)                                = 0
open("/var/lib/dpkg/info/ttf-dejavu.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1869, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/fo"..., 1869) = 1869
close(3)                                = 0
open("/var/lib/dpkg/info/libxtst6.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=193, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 193) = 193
close(3)                                = 0
open("/var/lib/dpkg/info/libgnome2-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=545, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 545) = 545
close(3)                                = 0
open("/var/lib/dpkg/info/libcdparanoia0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=472, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/li"..., 472) = 472
close(3)                                = 0
open("/var/lib/dpkg/info/blt.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2908, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/blt2.4"..., 2908) = 2908
close(3)                                = 0
open("/var/lib/dpkg/info/libnspr4-0d.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=225, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 225) = 225
close(3)                                = 0
open("/var/lib/dpkg/info/unixodbc.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=806, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/isql\n/"..., 806) = 806
close(3)                                = 0
open("/var/lib/dpkg/info/libice6.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=224, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 224) = 224
close(3)                                = 0
open("/var/lib/dpkg/info/libesd0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=196, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/esound"..., 196) = 196
close(3)                                = 0
open("/var/lib/dpkg/info/tex-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4425, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/de"..., 4425) = 4425
close(3)                                = 0
open("/var/lib/dpkg/info/libpcrecpp0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=355, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libpcr"..., 355) = 355
close(3)                                = 0
open("/var/lib/dpkg/info/libzephyr-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=334, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libzep"..., 334) = 334
close(3)                                = 0
open("/var/lib/dpkg/info/python-sip4-dbg.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=587, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/python"..., 587) = 587
close(3)                                = 0
open("/var/lib/dpkg/info/libkrb5-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1573, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/ac"..., 1573) = 1573
close(3)                                = 0
open("/var/lib/dpkg/info/libzephyr3.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=222, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/sbin\n/usr/"..., 222) = 222
close(3)                                = 0
open("/var/lib/dpkg/info/libcupsys2.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=564, ...}) = 0
read(3, "/.\n/var\n/var/spool\n/var/spool/cu"..., 564) = 564
close(3)                                = 0
open("/var/lib/dpkg/info/libsysfs-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=914, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 914) = 914
close(3)                                = 0
open("/var/lib/dpkg/info/libesd0-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=351, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libesd"..., 351) = 351
close(3)                                = 0
open("/var/lib/dpkg/info/python2.5-dbg.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=10555, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/python"..., 10555) = 10555
close(3)                                = 0
open("/var/lib/dpkg/info/libx11-data.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=9569, ...}) = 0
brk(0xd5c000)                           = 0xd5c000
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 9569) = 9569
close(3)                                = 0
open("/var/lib/dpkg/info/libedata-book1.2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1429, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1429) = 1429
close(3)                                = 0
open("/var/lib/dpkg/info/libselinux1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=211, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 211) = 211
close(3)                                = 0
open("/var/lib/dpkg/info/libfam0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=381, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 381) = 381
close(3)                                = 0
open("/var/lib/dpkg/info/x11proto-composite-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=497, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 497) = 497
close(3)                                = 0
open("/var/lib/dpkg/info/libc6.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=9056, ...}) = 0
read(3, "/.\n/etc\n/etc/init.d\n/etc/init.d/"..., 9056) = 9056
close(3)                                = 0
open("/var/lib/dpkg/info/libtag1-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2123, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/taglib"..., 2123) = 2123
close(3)                                = 0
open("/var/lib/dpkg/info/libsm6.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=218, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 218) = 218
close(3)                                = 0
open("/var/lib/dpkg/info/libattr1-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1278, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 1278) = 1278
close(3)                                = 0
open("/var/lib/dpkg/info/libxxf86vm1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=208, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 208) = 208
close(3)                                = 0
open("/var/lib/dpkg/info/libpng12-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=704, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/sbin\n/usr/"..., 704) = 704
close(3)                                = 0
open("/var/lib/dpkg/info/libxmu-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=272, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 272) = 272
close(3)                                = 0
open("/var/lib/dpkg/info/libedataserver1.2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4802, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 4802) = 4802
close(3)                                = 0
open("/var/lib/dpkg/info/libbonoboui2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2491, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2491) = 2491
close(3)                                = 0
open("/var/lib/dpkg/info/libgnutls-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1311, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/ac"..., 1311) = 1311
close(3)                                = 0
open("/var/lib/dpkg/info/defoma.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4088, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/defoma"..., 4088) = 4088
brk(0xd7e000)                           = 0xd7e000
close(3)                                = 0
open("/var/lib/dpkg/info/apache2-prefork-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2257, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 2257) = 2257
close(3)                                = 0
open("/var/lib/dpkg/info/bison.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4165, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/bison\n"..., 4165) = 4165
close(3)                                = 0
open("/var/lib/dpkg/info/kdelibs4-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=27280, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 27280) = 27280
close(3)                                = 0
open("/var/lib/dpkg/info/libsasl2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2660, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2660) = 2660
close(3)                                = 0
brk(0xda0000)                           = 0xda0000
open("/var/lib/dpkg/info/libc-client2006j2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2817, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2817) = 2817
close(3)                                = 0
open("/var/lib/dpkg/info/bash.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2777, ...}) = 0
read(3, "/.\n/bin\n/bin/bash\n/etc\n/etc/skel"..., 2777) = 2777
close(3)                                = 0
open("/var/lib/dpkg/info/libpcre3-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2015, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libpcr"..., 2015) = 2015
close(3)                                = 0
open("/var/lib/dpkg/info/make.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2686, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/make\n/"..., 2686) = 2686
close(3)                                = 0
open("/var/lib/dpkg/info/util-linux.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4715, ...}) = 0
read(3, "/.\n/bin\n/bin/tailf\n/bin/dmesg\n/b"..., 4715) = 4715
close(3)                                = 0
open("/var/lib/dpkg/info/libkrb53.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=794, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/krb5\n/"..., 794) = 794
close(3)                                = 0
open("/var/lib/dpkg/info/libmpich1.0-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=5140, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 5140) = 5140
close(3)                                = 0
open("/var/lib/dpkg/info/libxcursor1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=208, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 208) = 208
close(3)                                = 0
open("/var/lib/dpkg/info/xfonts-utils.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1571, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1571) = 1571
close(3)                                = 0
open("/var/lib/dpkg/info/libqt3-compat-headers.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1800, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 1800) = 1800
close(3)                                = 0
open("/var/lib/dpkg/info/libmeanwhile1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=367, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 367) = 367
close(3)                                = 0
open("/var/lib/dpkg/info/libmusicbrainz4c2a.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=502, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/li"..., 502) = 502
close(3)                                = 0
open("/var/lib/dpkg/info/libgnome2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1249, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1249) = 1249
close(3)                                = 0
open("/var/lib/dpkg/info/po-debconf.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1405, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1405) = 1405
close(3)                                = 0
open("/var/lib/dpkg/info/m4.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1794, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1794) = 1794
close(3)                                = 0
open("/var/lib/dpkg/info/libmad0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=319, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libmad"..., 319) = 319
close(3)                                = 0
open("/var/lib/dpkg/info/libfontenc1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=248, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 248) = 248
close(3)                                = 0
open("/var/lib/dpkg/info/libopencdk10.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=429, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 429) = 429
close(3)                                = 0
open("/var/lib/dpkg/info/cpio.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2225, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2225) = 2225
close(3)                                = 0
open("/var/lib/dpkg/info/libstdc++6.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=121, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 121) = 121
close(3)                                = 0
open("/var/lib/dpkg/info/x11-xfs-utils.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=394, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 394) = 394
close(3)                                = 0
open("/var/lib/dpkg/info/zip.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=475, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 475) = 475
close(3)                                = 0
open("/var/lib/dpkg/info/libbonobo2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3320, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 3320) = 3320
close(3)                                = 0
open("/var/lib/dpkg/info/uuid-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libuui"..., 798) = 798
close(3)                                = 0
brk(0xdc2000)                           = 0xdc2000
open("/var/lib/dpkg/info/libhtml-tagset-perl.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=405, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/pe"..., 405) = 405
close(3)                                = 0
open("/var/lib/dpkg/info/strace.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=287, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/strace"..., 287) = 287
close(3)                                = 0
open("/var/lib/dpkg/info/libmusicbrainz4-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1510, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 1510) = 1510
close(3)                                = 0
open("/var/lib/dpkg/info/libsqlite0-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=348, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 348) = 348
close(3)                                = 0
open("/var/lib/dpkg/info/binutils.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=6845, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 6845) = 6845
close(3)                                = 0
open("/var/lib/dpkg/info/cdparanoia.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=395, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/ma"..., 395) = 395
close(3)                                = 0
open("/var/lib/dpkg/info/libart-2.0-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2897, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2897) = 2897
close(3)                                = 0
open("/var/lib/dpkg/info/libglib2.0-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4239, ...}) = 0
read(3, "/.\n/usr\n/usr/include\n/usr/includ"..., 4239) = 4239
close(3)                                = 0
open("/var/lib/dpkg/info/libsqlite3-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=379, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 379) = 379
close(3)                                = 0
open("/var/lib/dpkg/info/libxmltok1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=295, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libxml"..., 295) = 295
close(3)                                = 0
open("/var/lib/dpkg/info/gstreamer0.10-tools.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=861, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 861) = 861
close(3)                                = 0
open("/var/lib/dpkg/info/libfreetype6-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=7592, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/freety"..., 7592) = 7592
close(3)                                = 0
open("/var/lib/dpkg/info/libglib2.0-0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=717, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libgli"..., 717) = 717
close(3)                                = 0
open("/var/lib/dpkg/info/intltool.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=890, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/ac"..., 890) = 890
close(3)                                = 0
open("/var/lib/dpkg/info/libgomp1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=115, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libgom"..., 115) = 115
close(3)                                = 0
open("/var/lib/dpkg/info/liblzo2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1427, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1427) = 1427
close(3)                                = 0
open("/var/lib/dpkg/info/libxt6.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=218, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 218) = 218
close(3)                                = 0
open("/var/lib/dpkg/info/readline-common.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=517, ...}) = 0
read(3, "/.\n/etc\n/usr\n/usr/share\n/usr/sha"..., 517) = 517
close(3)                                = 0
open("/var/lib/dpkg/info/libcap1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=211, ...}) = 0
read(3, "/.\n/lib\n/lib/libcap.so.1.10\n/usr"..., 211) = 211
close(3)                                = 0
open("/var/lib/dpkg/info/libapr1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=254, ...}) = 0
read(3, "/.\n/usr\n/usr/lib\n/usr/lib/libapr"..., 254) = 254
close(3)                                = 0
open("/var/lib/dpkg/info/lib64gcc1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=87, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 87) = 87
close(3)                                = 0
open("/var/lib/dpkg/info/python2.4-minimal.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=5912, ...}) = 0
read(3, "/.\n/usr\n/usr/bin\n/usr/bin/python"..., 5912) = 5912
close(3)                                = 0
open("/var/lib/dpkg/info/libxcursor-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1883, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1883) = 1883
close(3)                                = 0
brk(0xde4000)                           = 0xde4000
open("/var/lib/dpkg/info/libmpfr-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=332, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 332) = 332
close(3)                                = 0
open("/var/lib/dpkg/info/libid3tag0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=340, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 340) = 340
close(3)                                = 0
open("/var/lib/dpkg/info/libgnutls13.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1182, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/lo"..., 1182) = 1182
close(3)                                = 0
open("/var/lib/dpkg/info/libwrap0.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=218, ...}) = 0
read(3, "/.\n/lib\n/lib/libwrap.so.0.7.6\n/u"..., 218) = 218
close(3)                                = 0
open("/var/lib/dpkg/info/libxau6.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=224, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 224) = 224
close(3)                                = 0
open("/var/lib/dpkg/info/libssh2-1.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=267, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 267) = 267
close(3)                                = 0
open("/var/lib/dpkg/info/libglade2-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2307, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 2307) = 2307
close(3)                                = 0
open("/var/lib/dpkg/info/libxcomposite-dev.list", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1066, ...}) = 0
read(3, "/.\n/usr\n/usr/share\n/usr/share/do"..., 1066) = 1066
close(3)                                = 0
open("/var/lib/dpkg/diversions", O_RDONLY|O_LARGEFILE) = 3
fcntl64(3, F_GETFD)                     = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
fstat64(3, {st_mode=S_IFREG|0644, st_size=430, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7fbe000
read(3, "/usr/bin/autoconf\n/usr/bin/autoc"..., 4096) = 430
read(3, "", 4096)                       = 0
write(1, "libc6-sparc64", 13)           = 13
write(1, ": /lib64/libc.so.6\n", 19)    = 19
write(1, "libc6", 5)                    = 5
write(1, ": /lib/libc.so.6\n", 17)      = 17
exit_group(0)                           = ?

--5mCyUwZo2JvN/JJP--
