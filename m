From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 29 Aug 2006 22:51:25 +0000
Subject: Re: Sparc termios.h
Message-Id: <1156891886.6271.135.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1156885191.6271.133.camel@localhost.localdomain>
In-Reply-To: <1156885191.6271.133.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Ar Maw, 2006-08-29 am 14:53 -0700, ysgrifennodd David Miller:
> Some of the c_cc[] array entries (specifically entries 4 and 5) are
> aliased, and their meaning is determined by whether ICANON is set.

This is a sys5/solaris perversion you emulate for the existing ioctls
then ? So a next generation struct termios need not emulate the junk
merely any compat glue ?

Alan
