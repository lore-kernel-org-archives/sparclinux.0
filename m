From: Raymond Burns <rayburns@comcast.net>
Date: Tue, 18 Jul 2006 04:33:24 +0000
Subject: Re: sparc32 git tree
Message-Id: <Pine.LNX.4.10.10607172146010.10727-100000@coalcreekmill.cm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <44BBB08C.3090004@mc.net>
In-Reply-To: <44BBB08C.3090004@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 17 Jul 2006, David Miller wrote:

> It's trying to register a node named "sbi@0,0" at the top-level
> of the SBUS hierarchy twice, which thus fails.
> 
> These things live in their own namespace, so let's just do the
> following to get them named uniquely:
> 

exactly what I was trying except wrapped in ifdef CONFIG_SPARC and
if (sparc_cpu_model = sun4d)

I was afraid it would be considered a hack.

Yours works fine by me.

with the sbus happy I've been following the serial port saga, 
(the <#4> looks scary)

zs@1,200000: ttyS0 at MMIO 0x200000 (irq = 12) is a zs
Console: ttyS0 (SunZilog zs0)
zs@1,200000: ttyS1 at MMIO 0x200004 (irq = 12) is a zs
Program terminated
Type  help  for more information
<#4> ok

the result persists despite patches including the last delayed
initialization you sent. sorry.

I need to reinable the early printk to see if there is actually an
oops in there.

Thanx
  Ray


