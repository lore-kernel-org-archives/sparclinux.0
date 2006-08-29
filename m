From: David Miller <davem@davemloft.net>
Date: Tue, 29 Aug 2006 23:20:06 +0000
Subject: Re: Sparc termios.h
Message-Id: <20060829.162006.107939467.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1156885191.6271.133.camel@localhost.localdomain>
In-Reply-To: <1156885191.6271.133.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 29 Aug 2006 23:51:25 +0100

> Ar Maw, 2006-08-29 am 14:53 -0700, ysgrifennodd David Miller:
> > Some of the c_cc[] array entries (specifically entries 4 and 5) are
> > aliased, and their meaning is determined by whether ICANON is set.
> 
> This is a sys5/solaris perversion you emulate for the existing ioctls
> then ? So a next generation struct termios need not emulate the junk
> merely any compat glue ?

It's SunOS stuff that we inherited for the Linux ioctls, yes.

If you're redoing things with new ioctl numbers and stuff like that,
you should feel no need to retain any of this junk.
