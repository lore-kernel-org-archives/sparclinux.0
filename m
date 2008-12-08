From: Robert Reif <reif@earthlink.net>
Date: Mon, 08 Dec 2008 01:53:40 +0000
Subject: Re: [PATCH] use sparc64 version of prom/printf.c
Message-Id: <493C7E24.8020405@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <493C1616.6080206@earthlink.net>
In-Reply-To: <493C1616.6080206@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sam Ravnborg wrote:
> Hi Robert.
>
> On Sun, Dec 07, 2008 at 01:29:42PM -0500, Robert Reif wrote:
>   
>> Use sparc64 version of prom/printf.c.
>>
>> The only differences for sparc32 is that prom_printf is no longer 
>> exported for modules which should be OK.
>>     
>
> cyber200fb uses prom_prinf and can be built as a module.
> >From Kconfig:
>
> config FB_CYBER2000
>         tristate "CyberPro 2000/2010/5000 support"
>         depends on FB && PCI && (BROKEN || !SPARC64)
>
> So it looks to me we should keep the EXPORT.
>
> 	Sam
>
>   
Since this is the only driver that can use prom_printf in a module
and it appears that the only sparc system that uses it is an unreleased
version of the java station, wouldn't it be better to change the
prom_printf to a printk in this driver?

I didn't see this problem because I don't compile with pci support
because it's one of the things I have to disable to get a kernel
small enough to actually load.
