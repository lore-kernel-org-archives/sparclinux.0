From: David Miller <davem@davemloft.net>
Date: Sat, 14 Apr 2007 17:00:07 +0000
Subject: Re: /proc/interrupts and timer
Message-Id: <20070414.100007.89399340.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0704141317001.13883@math>
In-Reply-To: <Pine.SOC.4.64.0704141317001.13883@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sat, 14 Apr 2007 13:20:54 +0300 (EEST)

> I tried todays 2.6.21-rc6+git on Ultra 5 to test out the latest merged 
> sparc64 changes. Works fine here.
> 
> I have not looked into /proc for some time but now I did. One slightly 
> strange this is in /proc/interrupts - timer has <NULL> interrupt type:
>            CPU0
>   0:       9404     <NULL>  timer
>   1:          0      sun4u  SABRE PCIERR
>   2:          0      sun4u  SABRE UE
>   3:          0      sun4u  SABRE CE
>   4:          0      sun4u  power
>   5:        339      sun4u  sab
>   6:          0      sun4u  su(kbd)
>   7:          0      sun4u  su(mouse)
>   8:          1      sun4u  parport0
>   9:          4      sun4u  floppy
>  12:        402      sun4u  eth0
>  14:       4768      sun4u  ide0
> 
> Is this intentional or rather by accident?

Yeah, there is no interrupt controller driving the timer
interrupt so there is no "struct irq_chip" hung off of
it.  I could put some dummy entry there to make the
"<NULL>" read something more pleasant :-)
