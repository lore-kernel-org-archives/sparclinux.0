From: Frank Scheiner <frank.scheiner@web.de>
Date: Wed, 24 Feb 2021 12:29:25 +0000
Subject: Re: Newer kernels fail to boot on a U450?
Message-Id: <69171194-4f65-f355-7fc4-4cf9b519c059@web.de>
List-Id: <sparclinux.vger.kernel.org>
References: <6cb1a2ea-c228-abbf-7aa7-0046799eff1e@ilande.co.uk>
In-Reply-To: <6cb1a2ea-c228-abbf-7aa7-0046799eff1e@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Mark,

On 24.02.21 12:14, Mark Cave-Ayland wrote:
> [...]
> I then asked them to work backwards through a collection of historical
> debian-ports ISOs that I own until we found one that would boot. The
> results were as follows:
>
>
> debian-10.0.0-sparc64-NETINST-1.iso (kernel 5.9.0-1-sparc64, grub) - FAILS
> debian-9.0-sparc64-NETINST-1.iso (kernel 4.14.0-3-sparc64, SILO) - FAILS
> debian-7.7.0-sparc-netinst.iso (kernel 3.2.0-4-sparc64, SILO) - FAILS
> debian-6.0.4-sparc-netinst.iso (kernel 2.6.32-5-sparc64, SILO) - WORKS
>
>
> Having eliminated the change of bootloader from SILO to grub as the
> problem, it really seems as if something in the kernel broke booting on
> a U450 between versions 2.6.32 and 3.2.0. I should add that these ISOs
> all boot fine under qemu-system-sparc64 which is a U5 machine, so the
> newer kernels are not completely broken.

I have checked my logs and (probably) the last time I used my Ultra
Enterprise 450 - 2018-04-21 - it was running a kernel v4.15.4:

```
root@e450:~# uname -a
Linux e450 4.15.0-1-sparc64-smp #1 SMP Debian 4.15.4-1 (2018-02-18)
sparc64 GNU/Linux
```

...successfully (incl. `openssl`, `7za` and STREAM benchmarks for half
an hour or so). And according to my netboot configuration it was booted
with GRUB - from the "[...]2.02+dfsg1-3" package. Looks like I didn't
test with any later GRUB version/package.

 From my experience, US II (and derived versions like IIi and IIe)
is/was still working well at that time, though US III and IIIi sometimes
had problems, though not sure if that is due to the processor or the
other components on the respective system boards.

> Do people still run newer kernels on older hardware? If there is
> interest, I may be able to get some more diagnostic information. In
> particular I'd be curious to know if Oracle do any routine testing of
> newer kernels on machines such as the U450 and whether anyone there can
> reproduce the problem.

I did run "newer" (to that time) kernels on older hardware, with the one
from the 4.19.0-5 versioned limux-image package being the latest one
used according to my configuration. But I don't have a log of this one
with US II or IIIi. I have logged crashes with that on v480 and v490 though.

I have a successful log of a 280R with two US IIIs running a kernel v4.16.5:

```
root@280r:~# uname -a
Linux 280r 4.16.0-1-sparc64-smp #1 SMP Debian 4.16.5-1 (2018-04-29)
sparc64 GNU/Linux
```

...together with the benchmarks I mentioned earlier. This one was also
netbooted with GRUB, but at that time from the "[...]2.02+dfsg1-4" package.

Cheers,
Frank
