From: chase rayfield <cusbrar1@gmail.com>
Date: Tue, 12 Jan 2021 00:50:48 +0000
Subject: Re: Old platforms: bring out your dead
Message-Id: <CACwypyNVibQby75dZek=P1oBkcHQYMx-kbria9Y6NnBpERh+qQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <20210110214653.GA1693373@ravnborg.org> <df42946e-5b1f-c433-fc6b-a2950f3d8dab@physik.fu-berlin.de>
 <CACwypyNS+fVoPVspSr36v8YjFbkrnYb+amcYRqVmA2kD2uD1Wg@mail.gmail.com> <1f6e936c-4947-4952-fae2-c05d03e0cd2c@landley.net>
In-Reply-To: <1f6e936c-4947-4952-fae2-c05d03e0cd2c@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

> Sparc has a runtime relocation I've never understood but did manage to break
> once, resulting in a long thread to fix:
>
> http://lists.landley.net/pipermail/aboriginal-landley.net/2011-December/001964.html
>
> Between that and the weird save half the stack register thing with function
> calls on some sort of "wheel"... there's a _reason_ I haven't been able to talk
> Rich into adding support for it to musl.
>
Register windowing, with parts of each window overlapping for function
arguments etc... you can kind of think of it as a ring buffer of
overlapping register files that's an oversimplification but it was
originally intended to accelerate and improve register file usage.
MIPS and the rest of the industry abandoned this for improved compile
time allocation. I think you might be more likely on MIPS to incur
more interrupt latency though since you have to spill to memory (at
least on MIPS contemporary to Sparc V8) instead of just switching
register windows mileage varies greatly.... From what I remember
overflowing the register file is implemented with hardware traps that
spill to memory etc... since you don't know that information at
compile time. on Sparc so yeah it's quite involved to understand and I
certainly don't grasp it fully. So on MIPS you spill the register file
to memory, on Sparc you spill register windows to memory... if you
have exceeded the supported call depth (which is rather expensive
since all the register windows go at once). Note spilling a single
variable within a register window is a separate issue.

Amazing, a link that actually works and is informative:
https://blogs.oracle.com/d/flush-register-windows


Chase
