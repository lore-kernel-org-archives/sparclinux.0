From: Bob Breuer <breuerr@mc.net>
Date: Thu, 24 Mar 2005 03:22:36 +0000
Subject: Re: sunbmac panic when no card present
Message-Id: <4242327C.6060901@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0503221030220.29185@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0503221030220.29185@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Meelis Roos wrote:
>> Looking into it a little more now, uart_tasklet_action() in 
>> drivers/serial/serial_core.c looks suspicious.  Meelis, can you add a 
>> BUG_ON(state->info->tty=NULL) in the middle of uart_tasklet_action() 
>> and see if it dies on that instead?
> 
> Yes, this BUG triggers

At least I'm looking in the right place, even if I don't know what I'm 
looking for.

Ok, one more thing to try.  Still in serial_core.c, let's also add a 
BUG_ON(info->tty=NULL) in the middle of uart_write_wakeup().  I don't 
expect this bug to trigger.  My current guess is that the tty is closed 
between scheduling and running the tasklet.  How about adding a printk 
after each time where info->tty is set:  near line 1224 in uart_close(), 
line 1320 in uart_hangup(), and line 1538 in uart_open().  If my guess 
is right, we will see a uart_close just before the BUG from the tasklet.

Bob

