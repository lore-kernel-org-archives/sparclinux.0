From: Marcel Holtmann <marcel@holtmann.org>
Date: Wed, 24 Mar 2004 20:32:47 +0000
Subject: Re: Compile problem on sparc64
Message-Id: <1080160367.2309.71.camel@pegasus>
List-Id: <sparclinux.vger.kernel.org>
References: <1080130448.2515.108.camel@pegasus>
	 <20040324121914.00fb9bf9.davem@redhat.com>
In-Reply-To: <20040324121914.00fb9bf9.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, SPARC Linux Mailing List <sparclinux@vger.kernel.org>

Hi Dave,

> [ Please us sparclinux@vger.kernel.org in the future, thanks... ]

I will do.

> > I am using Debian Sid with GCC 3.3.3 (Debian 20040320) and I got the
> > following error on my sparc64 platform while compiling the latest
> > Bitkeeper sources from 2.6:
> 
> This should cure it, let me know if it doesn't.

Seems that this is not enough. Now I get this one:

  CC      arch/sparc64/kernel/process.o
arch/sparc64/kernel/process.c: In function `flush_thread':
arch/sparc64/kernel/process.c:435: warning: use of cast expressions as lvalues is deprecated

Regards

Marcel


