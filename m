From: Joshua Kwan <joshk@triplehelix.org>
Date: Fri, 27 Aug 2004 00:57:27 +0000
Subject: Re: [2.6] busybox EFAULT on sparc64
Message-Id: <pan.2004.08.27.00.57.25.841201@triplehelix.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040818235528.GA8070@triplehelix.org>
In-Reply-To: <20040818235528.GA8070@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Thu, 19 Aug 2004 22:02:59 -0700, David S. Miller wrote:
> It should definitely fix the busybox mount() problem.
> The fork() problem probably not, please try to trace
> into the forked() process.  If that proves too hard
> get back to me and I'll try to cons up some debugging
> hacks for the kernel to try and track that one down
> too.

I tried making it not fork:

~ # strace -f /sbin/klogd -n
execve("/sbin/klogd", ["/sbin/klogd", "-n"], [/* 3 vars */]) =3D 0
uname({sys=3D"Linux", node=3D"(none)", ...}) =3D 0
brk(0)                                  =3D 0x14e000
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
open("/etc/ld.so.preload", O_RDONLY)    =3D -1 ENOENT (No such file or dire=
ctory)
open("/etc/ld.so.cache", O_RDONLY)      =3D -1 ENOENT (No such file or dire=
ctory)
open("/lib/v9/libc.so.6", O_RDONLY)     =3D -1 ENOENT (No such file or dire=
ctory)
stat64("/lib/v9", 0xeffff390)           =3D -1 ENOENT (No such file or dire=
ctory)
open("/lib/libc.so.6", O_RDONLY)        =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\2\0\0\0\1\0\0\366"..., 512) =
=3D 512
fstat64(3, {st_mode=3DS_IFREG|0666, st_sizer4900, ...}) =3D 0
mmap(NULL, 794096, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x7002c000
mprotect(0x700d8000, 89584, PROT_NONE)  =3D 0
mmap(0x700dc000, 73728, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIX=
ED, 3, 0xa0000) =3D 0x700dc000
close(3)                                =3D 0
rt_sigaction(SIGINT, {0x477d8, [], SA_RESTART}, {SIG_DFL}, 0x70043958, 3) =
=3D 0
rt_sigaction(SIGKILL, {0x477d8, [KILL], SA_RESTART}, {SIG_DFL}, 0x70043958,=
 3) =3D -1 EINVAL (Invalid argument)
rt_sigaction(SIGTERM, {0x477d8, [TERM], SA_RESTART}, {SIG_DFL}, 0x70043958,=
 3) =3D 0
rt_sigaction(SIGHUP, {SIG_IGN}, {SIG_DFL}, 0x70043958, 3) =3D 0
syslog(0x1, 0, 0)                       =3D 0
syslog(0x8, 0, 0x7)                     =3D 0
brk(0)                                  =3D 0x14e000
brk(0x170000)                           =3D 0x170000
brk(0)                                  =3D 0x170000
time([1093542749])                      =3D 1093542749
open("/etc/localtime", O_RDONLY)        =3D -1 ENOENT (No such file or dire=
ctory)
rt_sigaction(SIGPIPE, {0x700903f0, [], 0}, {SIG_DFL}, 0x70043958, 3) =3D 0
socket(PF_FILE, SOCK_DGRAM, 0)          =3D 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         =3D 0
connect(3, {sa_family=AF_FILE, path=3D"/dev/log"}, 16) =3D -1 ENOENT (No su=
ch file or directory)
close(3)                                =3D 0
rt_sigaction(SIGPIPE, {SIG_DFL}, NULL, 0x70043958, 3) =3D 0
syslog(0x2, 0xefffed20, 0x1000

At this point everything hangs. I'm not sure if there's another four
digits after the 0x1000.

Ideas?

--=20
Joshua Kwan


