From: David Miller <davem@davemloft.net>
Date: Tue, 11 Aug 2020 23:42:18 +0000
Subject: Re: sparc vs sparc64: O_NDELAY and O_NONBLOCK mismatch in kernel and in glibc
Message-Id: <20200811.164218.846363035312807388.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sergei Trofimovich <slyfox@gentoo.org>
Date: Fri, 29 May 2020 10:40:19 +0100

> Question time:
> 
> 1. Why is sparc32 special? Does it have something to do with
>    compatibility to other OSes of that time? (Solaris? BSD?)
> 
>    fs/fcntl.c has kernel handling:
>         /* required for strict SunOS emulation */
>         if (O_NONBLOCK != O_NDELAY)
>                if (arg & O_NDELAY)
>                    arg |= O_NONBLOCK;
>    but why does it leak to to userspace header definition?
> 
>    I think it should not.

The original sparc value was meant to match the SunOS value
exactly in order to make the SunOS emulation support easier.

The current situation is a mess and I don't doubt that it accounts
for various kinds of weird behavior we've seen over the years :-/
