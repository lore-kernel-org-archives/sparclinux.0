From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 24 Feb 2021 13:01:33 +0000
Subject: Re: Newer kernels fail to boot on a U450?
Message-Id: <edd947e8-7e27-c002-018d-f3070d47fef1@ilande.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <6cb1a2ea-c228-abbf-7aa7-0046799eff1e@ilande.co.uk>
In-Reply-To: <6cb1a2ea-c228-abbf-7aa7-0046799eff1e@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 24/02/2021 12:29, Frank Scheiner wrote:

> Hi Mark,
> 
> On 24.02.21 12:14, Mark Cave-Ayland wrote:
>> [...]
>> I then asked them to work backwards through a collection of historical
>> debian-ports ISOs that I own until we found one that would boot. The
>> results were as follows:
>>
>>
>> debian-10.0.0-sparc64-NETINST-1.iso (kernel 5.9.0-1-sparc64, grub) - FAILS
>> debian-9.0-sparc64-NETINST-1.iso (kernel 4.14.0-3-sparc64, SILO) - FAILS
>> debian-7.7.0-sparc-netinst.iso (kernel 3.2.0-4-sparc64, SILO) - FAILS
>> debian-6.0.4-sparc-netinst.iso (kernel 2.6.32-5-sparc64, SILO) - WORKS
>>
>>
>> Having eliminated the change of bootloader from SILO to grub as the
>> problem, it really seems as if something in the kernel broke booting on
>> a U450 between versions 2.6.32 and 3.2.0. I should add that these ISOs
>> all boot fine under qemu-system-sparc64 which is a U5 machine, so the
>> newer kernels are not completely broken.
> 
> I have checked my logs and (probably) the last time I used my Ultra
> Enterprise 450 - 2018-04-21 - it was running a kernel v4.15.4:
> 
> ```
> root@e450:~# uname -a
> Linux e450 4.15.0-1-sparc64-smp #1 SMP Debian 4.15.4-1 (2018-02-18)
> sparc64 GNU/Linux
> ```
> 
> ...successfully (incl. `openssl`, `7za` and STREAM benchmarks for half
> an hour or so). And according to my netboot configuration it was booted
> with GRUB - from the "[...]2.02+dfsg1-3" package. Looks like I didn't
> test with any later GRUB version/package.
> 
>  From my experience, US II (and derived versions like IIi and IIe)
> is/was still working well at that time, though US III and IIIi sometimes
> had problems, though not sure if that is due to the processor or the
> other components on the respective system boards.

Hi Frank,

Thanks for the information! Do you have a display on your U450 at all? The U450 we 
were trying to rescue was headless (i.e. connect via serial only) so the only 
differences I can see might either be the display or the fact that the boot was 
occurring from the CDROM rather than a local disk installation.

Next time you have the U450 fired up, I'd be interested to find out if it is possible 
to boot directly from the latest debian ports CDROM for comparison.


ATB,

Mark.
