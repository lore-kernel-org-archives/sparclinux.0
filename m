From: Anatoly Pugachev <matorola@gmail.com>
Date: Sat, 30 Dec 2017 12:27:17 +0000
Subject: Re: building debug version of klibc
Message-Id: <CADxRZqz54xbBVucSfipzjViAa7=j5WiLodM_5i0-88szjbxB5Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqz24hXaLZzSgn=4ZC-Mj53ecbq7J=AcwxVyypU6eNQVqA@mail.gmail.com>
	<238034.1514635201@turing-police.cc.vt.edu>
	<CADxRZqy1+ovSHdoUS+kr8=vMgLDmq+gmsz=uw2K=6JQzrxRYPQ@mail.gmail.com>
	<239797.1514636055@turing-police.cc.vt.edu>
In-Reply-To: <239797.1514636055@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernelnewbies@lists.kernelnewbies.org

On Sat, Dec 30, 2017 at 3:14 PM,  <valdis.kletnieks@vt.edu> wrote:
> On Sat, 30 Dec 2017 15:05:46 +0300, Anatoly Pugachev said:
>> On Sat, Dec 30, 2017 at 3:00 PM,  <valdis.kletnieks@vt.edu> wrote:
>> > On Sat, 30 Dec 2017 13:54:05 +0300, Anatoly Pugachev said:
>> >> Hello!
>> >>
>> >> Can someone please help me in building debug version of klibc ?
>> >>
>> >> I've cloned git://git.kernel.org/pub/scm/libs/klibc/klibc.git  , but
>> >> failed to build it with debug info
>> >>
>> >> added "-g" to HOSTCFLAGS in Makefile, but
>
>> it's usual git kernel compile and install. And it's the first time I
>> started to get segfault from fstype.
>
> I missed where you went from klibc to building a new kernel, probably
> because you changed topics in mid-email.  Why were you building a new
> kernel for your host system just to get a klibc that had -g?

I'm using / testing a git kernel upstream on my hardware (sparc64 /
ppc64 / ia64 ).
Only this time, installing latest git kernel, I get a sigserv on
sparc64 from klibc utility (fstype), and posted about it to mailing
list.
So, to properly report with gdb backtrace, i was need to build klibc
(fstype) with debug info.
I'm not able to fix it myself, so probably someone else could look
into the issue (or i'm just raising awareness for the issue to other
who can hit it as well).
It could be compiler issue as well, if files in klibc.git repo does
not changed for about a year....
I was asking for help with building debug version of klibc and since i
was able to build it, we could close this issue for now (going to
discuss it with debian distribution maintainers first).
Thanks!
