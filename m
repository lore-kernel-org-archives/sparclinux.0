From: "David S. Miller" <davem@redhat.com>
Date: Wed, 24 Mar 2004 22:30:28 +0000
Subject: Re: Compile problem on sparc64
Message-Id: <20040324143028.747af65c.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1080130448.2515.108.camel@pegasus>
	<20040324121914.00fb9bf9.davem@redhat.com>
	<1080160367.2309.71.camel@pegasus>
In-Reply-To: <1080160367.2309.71.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Wed, 24 Mar 2004 21:32:47 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> > > I am using Debian Sid with GCC 3.3.3 (Debian 20040320) and I got the
> > > following error on my sparc64 platform while compiling the latest
> > > Bitkeeper sources from 2.6:
> > 
> > This should cure it, let me know if it doesn't.
> 
> Seems that this is not enough. Now I get this one:
> 
>   CC      arch/sparc64/kernel/process.o
> arch/sparc64/kernel/process.c: In function `flush_thread':
> arch/sparc64/kernel/process.c:435: warning: use of cast expressions as lvalues is deprecated

I'm not getting these, I wonder why.  I'm using something similar
to you for builds:

davem@nuts:/disk1/BK/sparc-2.6$ gcc --version
gcc (GCC) 3.3.3 (Debian)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

davem@nuts:/disk1/BK/sparc-2.6$

Please also send me your .config under seperate cover if you'd be so
kind, thanks.
