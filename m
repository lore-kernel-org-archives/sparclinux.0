From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 14 Jan 2021 23:09:24 +0000
Subject: Re: Old platforms: bring out your dead
Message-Id: <CAMo8Bf+geJqaaTkwaRyMUZPJgGC1ELXTdnYGq92UNnaaz2CFVg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net> <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
 <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
 <1be37673-db0e-f09d-68c8-f929be4019ab@physik.fu-berlin.de> <CAK8P3a1+SdAW8VKnvMdXNVcpR-ykNdPoqLqb59uxzB+jNFJRtg@mail.gmail.com>
In-Reply-To: <CAK8P3a1+SdAW8VKnvMdXNVcpR-ykNdPoqLqb59uxzB+jNFJRtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Linus Walleij <linus.walleij@linaro.org>, Gerhard Pircher <gerhard_pircher@gmx.net>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Arnd,

On Thu, Jan 14, 2021 at 1:25 PM Arnd Bergmann <arnd@kernel.org> wrote:
> | arch/mips/Kconfig:config HIGHMEM
> | arch/xtensa/Kconfig:config HIGHMEM
>
> AFAICT On MIPS (prior to MIPS32r3) and xtensa, you have at
> most 512MB in the linear map, so the VMSPLIT_2G or VMSPLIT_4G_4G
> tricks won't work.

Regarding xtensa this was done to minimize difference between
MMUv2 and MMUv3 virtual memory layouts. MMUv2 has been
obsoleted more than 10 years ago, and MMUv3 is much more
flexible and can do e.g. 4GB linear map. The only piece of xtensa
MMUv2 hardware that I have has 96MB of DRAM which fits into
its linear mapping. So maybe it's time to do a cleanup and
rearrange virtual memory layout to eliminate the need of highmem.

> I have no idea who uses xtensa systems with lots of memory on
> modern kernels.

We definitely use it for development internally at Cadence/Tensilica,
mainly on simulators, but also on FPGA boards (e.g. on KC705 we
can use all of the 1GB onboard DRAM).
In the last few years we've had a few support requests for linux on
xtensa cores with MMU, but AFAICT none of them had to deal with
more than 512MB of onboard memory.

-- 
Thanks.
-- Max
