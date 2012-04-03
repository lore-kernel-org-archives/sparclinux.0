From: David Miller <davem@davemloft.net>
Date: Tue, 03 Apr 2012 22:39:11 +0000
Subject: Re: sparc32 - keyboard is dead with v3.4-rc1
Message-Id: <20120403.183911.210339857039667503.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120403204455.GA29433@merkur.ravnborg.org>
In-Reply-To: <20120403204455.GA29433@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 4 Apr 2012 00:35:57 +0200

>     serial: Kill off NO_IRQ
 ...
> This was also my prime suspect when I looked at tty/serial.
> 
> I assume we have some inconsistency in the interpretation
> of irq = 0 somewhere.
> 
> In my first post I said that nothing unusual showed up in
> the boot log.
> But the following line is missing when it does not work:
> 
>     input: Sun Type 5 keyboard as /devices/root/ffd31a40/ffd31cf0/serio0/input/input0
> 
> 
> I will take a look at this tomorrow.

Great work Sam.
