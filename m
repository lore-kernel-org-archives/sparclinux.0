From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 31 Jan 2015 16:25:43 +0000
Subject: Re: linux-next: libahci_platform has undefined symbol on sparc
Message-Id: <54CD0207.2090306@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1422710050.3030.17.camel@opteya.com>
In-Reply-To: <1422710050.3030.17.camel@opteya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yann Droneaud <ydroneaud@opteya.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Tejun Heo <tj@kernel.org>
Cc: linux-next@vger.kernel.org, linux-ide@vger.kernel.org, sparclinux@vger.kernel.org

Hi,

On 01/31/2015 02:14 PM, Yann Droneaud wrote:
> Hi,
> 
> I've seen another issue regarding commit c7d7ddee7e24eedde6149eefbcfbfbc7125b9ff0
> ("ata: libahci: Allow using multiple regulators") from linux-next:
> This commit modify ahci_platform_get_resources to use of_platform_device_create().
> 
> Unfortunately, it seems that of_platform_device_create() is not
> available on sparc (see CONFIG_OF_ADDRESS), so when built for sparc,
> the module libahci_platform.ko is rejected by modpost:
> 
>   ERROR: "of_platform_device_create" [drivers/ata/libahci_platform.ko] undefined!
>   ../scripts/Makefile.modpost:91: recipe for target '__modpost' failed
>   make[2]: *** [__modpost] Error 1
>   src/linux/Makefile:1120: recipe for target 'modules' failed

Ah yes we had the same problem in simplefb, the example code for using
of_platform_device came from simplefb, and already had the fix, but it look
like Gregory did not include the bits fixing this in the ahci_platform code

Gregory, can you please submit a follow up patch fixing this? See simplefb.c
for the easiest way to fix this.

Regards,

Hans
