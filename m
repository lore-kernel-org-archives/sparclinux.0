From: daniel@gaisler.com
Date: Thu, 21 Apr 2011 18:46:14 +0000
Subject: Re: [PATCH 0/7] sparc32,leon: additional genirq patches
Message-Id: <20110421144614.83kcfn12hw4wk40k@webmail.bluegenesis.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4DADB2F4.6070402@gaisler.com>
In-Reply-To: <4DADB2F4.6070402@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Thu, 21 Apr 2011 11:09:23 -0700 (PDT), David Miller  wrote:
From: Sam Ravnborg <sam@ravnborg.org>
> Date: Wed, 20 Apr 2011 14:58:53 +0200
>
> > The issue with boot_cpu_id being cleared is btw not new - but
> > I should have caught that anyway. 
>
> It's partially another side effect of that awful behavioral change GCC
> made several years ago to "auto BSS" variables explicitly initialized
> to zero. 
>
> You used to be able to add an explicit zero initialization to force
> items into the data section. 

Yeah, ridiculous that change is, one could always use attribute section 
to force it into DATA but that is kind of complicated. I always thought 
I was stupid but now I know that the compiler changed its behaviour... 
thanks. Another problem is that "cleanup people" does not know of this 
and erase that only hint. 

  >
> This change has broken various things in the sparc32 port over the
> years. 
>
> Probably the thing to do is to initialize boot_cpu_id{,4} to some
> "invalid" value (like 0xff) in the kernel image and just make certain
> the the initialization happens early enough. 

That is basically what I've done in the next "[1..3] sparc32: 
boot_cpu_id patches". 

Daniel


