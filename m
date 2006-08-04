From: Daniel Smolik <marvin@mydatex.cz>
Date: Fri, 04 Aug 2006 22:22:20 +0000
Subject: Re: serial console broken on Ultra 5
Message-Id: <44D3C89C.4000206@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Marc Zyngier napsal(a):
>>>>>>"Daniel" = Daniel Smolik <marvin@mydatex.cz> writes:
> 
> 
> Daniel> se@14,400000: ttyS0 at MMIO 0x1fff1400000 (irq = 7) is a SAB82532 V3.2
>                       ^^^^^
> Daniel> Console: ttyS2 (SAB82532)
>                  ^^^^^
> Daniel> SUNSAB baud:115200 quot:0
> 
> Ok, I managed to reproduce it on my own setup. Looks like the kernel
> insists on having the first serial port as a console, even if it know
> is has to be the third... Of course, as ttyS2 has not been probed yet,
> it all goes to Nowhereland...
> 
> I'll try to cook up a patch during the week-end if the weather is bad
> enough. In the meantime, you should be able to boot with
> "console=ttyS0 -p". At least, you'll have your console messages on the
> RSC console, and you'll probably be able to remote login.
> 
> 	M.
Yes you are right. Now it boots.


		Dan
PS: in Prague is bad weather too :-)

