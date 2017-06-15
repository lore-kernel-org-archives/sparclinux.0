From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 15 Jun 2017 15:20:01 +0000
Subject: Re: [v1 0/2] Early boot timestamp fixes
Message-Id: <20170615152001.GB7646@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jun 15, 2017 at 10:40:57AM -0400, Pavel Tatashin wrote:
> Guenter Roeck reported a problem that was introduced by early boot
> timestamp changes. Where: tick_get_frequency() returns 0.
> 
> Guenter Roeck: could you please test if these patches fix the issue?
> 
My tests pass with those patches applied, so

Tested-by: Guenter Roeck <linux@roeck-us.net>

My current sparc64 tests are

sparc64_defconfig sun4u "TI UltraSparc IIi"
sparc64_defconfig sun4v "Fujitsu Sparc64 IV"

with both SMP and non-SMP configuration variants.

Do you happen know which CPU variants supported by qemu would test
all affected code branches ? Or, in other words, what would be
an optimal combination of CPU / machine type to test ?

Thanks,
Guenter

> Pavel Tatashin (2):
>   sparc64: use prom interface to get %stick frequency
>   sparc64: broken %tick frequency on spitfire cpus
> 
>  arch/sparc/kernel/time_64.c |   34 ++++++++++++++++++++++++++++------
>  1 files changed, 28 insertions(+), 6 deletions(-)
> 
