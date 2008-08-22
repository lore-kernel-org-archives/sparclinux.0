From: Meelis Roos <mroos@ut.ee>
Date: Fri, 22 Aug 2008 16:49:34 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <Pine.SOC.4.64.0808221944160.15748@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Also, if you can, increase the serial console baud rate.  (On the boot
> command line, put something like "console=ttyS0,115200", or whatever is
> appropriate for Sparcs.)  That should help reduce the console
> transmission delays.

I applied bot patches but ran into problems with 115200 at the other end 
of the cable. As a bad surprise, Sun Ultra 5 with 2.6.27-rc4 hangs 
reproducibly when I try to set the speed to 115200 from minicom. I don't 
have a serial adapter handy for hooking the V100 up to a PC, so I lost 
the machine for the weekend, because I can not get to PROM prompt to 
switch it back to a lower speed (because that would need working 115200 
on the other end). I hope to get the serial adapter sometime in the 
beginning of the next week.

Or can I use some linux command line to change nvram variables?
"setenv ttya-mode 9600,8,n,1,-" is needed.

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
