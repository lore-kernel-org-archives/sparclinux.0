From: David Miller <davem@davemloft.net>
Date: Sun, 28 Oct 2007 05:30:14 +0000
Subject: Re: possible typo in arch/sparc64/kernel/time.c
Message-Id: <20071027.223014.62992249.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4723587F.1020301@tiscali.nl>
In-Reply-To: <4723587F.1020301@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Roel Kluin <12o3l@tiscali.nl>
Date: Sat, 27 Oct 2007 17:25:51 +0200

> I already posted something on lkml, but it wasn't picked up
> 
> in arch/sparc64/kernel/time.c, line 1073 it reads:
> 
>         if (!mregs && !dregs & !bregs)
> 
> shouldn this be
> 
>         if (!mregs && !dregs && !bregs)
> 

Yep, thanks I'll fix it up.
