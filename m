From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Mon, 09 Jan 2006 00:50:43 +0000
Subject: strace broken on SPARC64
Message-Id: <1136767843.9208.15.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

Whilst debugging some USB printing problems with strace I noticed that
the output from strace in recent kernels is broken. A bit of detective
work shows that it last worked properly in 2.6.12 and broke during
2.6.13 development. It seems that it broke due to git commit
db7d9a4eb700be766cc9f29241483dbb1e748832

http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff_plain;h=DB7d9a4eb700be766cc9f29241483dbb1e748832;hp=CDd5186f753b=
23ab51f86679bdc4cc698ab0b893

After a bit of searching I found that removing the above patch makes
strace happy (note I didn't get time to try this with 2.6.15 saw it with
a tree based between 2.6.12 and 2.6.13 - with git head set to
d06e4c4001cf26147a6af0718703368944f0df32)

I cannot obviously see what is wrong with the patch but looking at the
symptoms of the breakage I would guess that either syscall entry or exit
is not being captured. I only seem to see every other syscall and the
return values are bogus in many cases. (It is probably exit that is
wrong)

As an example (from debian/testing running /usr/lib/cups/backend/usb)

Bad gives

execve("/usr/lib/cups/backend/usb", ["/usr/lib/cups/backend/usb"], [/*
14 vars */]) =3D 0
uname({sys=3D"Linux", node=3D"pingu", ...}) =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D 1879141984
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
mmap(NULL, 35005, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x3
access("/etc/ld.so.nohwcap", F_OK)      =3D 1879192233


Good gives

execve("/usr/lib/cups/backend/usb", ["/usr/lib/cups/backend/usb"], [/*
18 vars */]) =3D 0
uname({sys=3D"Linux", node=3D"pingu", ...}) =3D 0
brk(0)                                  =3D 0x24000
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or
directory)
access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size5005, ...}) =3D 0
mmap(NULL, 35005, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7001c000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or
directory)

Note the brk(0), access(...,R_OK), fstat64 and close() calls have
disappeared in the bad stuff.

Anyone have any clues?

Richard

--=20
Richard Mortimer <richm@oldelvet.org.uk>

