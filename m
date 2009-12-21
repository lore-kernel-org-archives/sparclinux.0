From: Jan Engelhardt <jengelh@medozas.de>
Date: Mon, 21 Dec 2009 20:17:33 +0000
Subject: Re: setsockopt number collisions
Message-Id: <alpine.LSU.2.00.0911300804470.303@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.00.0911292034010.5701@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.00.0911292034010.5701@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Monday 2009-11-30 02:07, David Miller wrote:

>From: Jan Engelhardt <jengelh@medozas.de>
>Date: Sun, 29 Nov 2009 20:34:56 +0100 (CET)
>
>> I notice that SO_PEERCRED (sparc-only definition of it, 
>> arch/sparc/include/asm/socket.h) collides with IPT_SO_BASE_CTL. How 
>> would this be resolved?
>
>These don't live at different socket option levels?

In other words, we need more comments in socket.h or a nice man-page 
that lists which SO_s belong to which level.
Ok :)


thanks,
Jan
