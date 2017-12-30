From: valdis.kletnieks@vt.edu
Date: Sat, 30 Dec 2017 12:14:15 +0000
Subject: Re: building debug version of klibc
Message-Id: <239797.1514636055@turing-police.cc.vt.edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="==_Exmh_1514636055_2626P"
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqz24hXaLZzSgn=4ZC-Mj53ecbq7J=AcwxVyypU6eNQVqA@mail.gmail.com>
	<238034.1514635201@turing-police.cc.vt.edu>
	<CADxRZqy1+ovSHdoUS+kr8=vMgLDmq+gmsz=uw2K=6JQzrxRYPQ@mail.gmail.com>
In-Reply-To: <CADxRZqy1+ovSHdoUS+kr8=vMgLDmq+gmsz=uw2K=6JQzrxRYPQ@mail.gmail.com>
To: kernelnewbies@lists.kernelnewbies.org

--==_Exmh_1514636055_2626P
Content-Type: text/plain; charset=us-ascii

On Sat, 30 Dec 2017 15:05:46 +0300, Anatoly Pugachev said:
> On Sat, Dec 30, 2017 at 3:00 PM,  <valdis.kletnieks@vt.edu> wrote:
> > On Sat, 30 Dec 2017 13:54:05 +0300, Anatoly Pugachev said:
> >> Hello!
> >>
> >> Can someone please help me in building debug version of klibc ?
> >>
> >> I've cloned git://git.kernel.org/pub/scm/libs/klibc/klibc.git  , but
> >> failed to build it with debug info
> >>
> >> added "-g" to HOSTCFLAGS in Makefile, but

> it's usual git kernel compile and install. And it's the first time I
> started to get segfault from fstype.

I missed where you went from klibc to building a new kernel, probably
because you changed topics in mid-email.  Why were you building a new
kernel for your host system just to get a klibc that had -g?

--==_Exmh_1514636055_2626P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWkeDF40DS38y7CIcAQLZEQgAmZBvOCpoPNnAZXA/ccPmtuWi4iY+0lR1
RQfL4m9mCWniF+FkJwiH/XttvY9Lv/YaATL4kMmTGrAhlszVzoSdi0wkst/o6wuS
EpH+eK2o9+Z5hdB+b+adt4t37rHVdwOwhAiAywVq6U1X0FpYhzFZJzWC8Qy8ORmF
oVF8S7xdegHgnEHAO2tO9Sbnn11zTBeoAQ7X+KTna2sHApbpN0zdj1Cvko5GKr4c
EFMj3kabVWTQYctV62ZJIJEXtHa+glMqhznrTDom9ttuIwwlvlQ9vQKcQwZuhibs
YC4cDWWqxaIXHB8YIgxFQLwIY+QlUyqyaF6irqCHkxQ56VfUr7A7pw==
=Em1d
-----END PGP SIGNATURE-----

--==_Exmh_1514636055_2626P--
