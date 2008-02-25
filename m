From: David Miller <davem@davemloft.net>
Date: Mon, 25 Feb 2008 03:48:22 +0000
Subject: Re: [PATCH][SPARC64] fix section mismatchs from dr_cpu_data
Message-Id: <20080224.194822.194168200.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080222203229.GE7154@uranus.ravnborg.org>
In-Reply-To: <20080222203229.GE7154@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 22 Feb 2008 21:32:29 +0100

> [SPARC64] fix section mismatchs from dr_cpu_data
> 
> Fix following warnings:
> WARNING: vmlinux.o(.text+0x4b258): Section mismatch in reference from the function dr_cpu_data() to the function .devinit.text:mdesc_fill_in_cpu_data()
> WARNING: vmlinux.o(.text+0x4b290): Section mismatch in reference from the function dr_cpu_data() to the function .cpuinit.text:cpu_up()
> 
> mdesc_fill_in_cpu_data() is only used during early init and for
> cpu hotplug so the __cpuinit annotation is the correct choice.
> We have the call chain:
> dr_cpu_data() => dr_cpu_configure() => mdesc_fill_in_cpu_data()
> 
> dr_cpu_data() is used only during early init and for cpu
> hotplug. So annotating them all __cpuinit solves the
> section mismatch and should be correct.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: David S. Miller <davem@davemloft.net>
> ---
> 
> Please review before you apply.
> I am not 100% sure if my assumptions are correct.
> 
> 	Sam
> 

It does look good, applied, thanks Sam.
