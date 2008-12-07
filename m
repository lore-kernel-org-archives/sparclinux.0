From: David Miller <davem@davemloft.net>
Date: Sun, 07 Dec 2008 08:05:53 +0000
Subject: Re: [PATCH] sparc: unify kernel/cpu
Message-Id: <20081207.000553.55133542.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081206210237.GA27594@uranus.ravnborg.org>
In-Reply-To: <20081206210237.GA27594@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 6 Dec 2008 22:02:37 +0100

> o use cpu_32.c as base
> o move all sparc64 definitions to the common cpu.c
> o use ifdef for the parts that differs and use cpu_32 as base
> o spitfire.h required a CONFIG_SPARC64 guard to fix build on 32 bit
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
> This is build tested only! 
> I need to get a sparc system soon if I shall continue this...

Applied and I'll test this.

Sam, if you want I can give you an account on one of my Niagara
systems which is very easy to reboot remotely and does allmodconfig
builds from scratch in like 12 minutes :-)  Just email me privately
if interested.

That would take care of sparc64.  For sparc32 it is possible to use
qemu for basic kernel testing.
