From: Chris Newport <crn@netunix.com>
Date: Wed, 05 Dec 2007 03:40:20 +0000
Subject: Re: Sun4d interrupt handling?
Message-Id: <Pine.LNX.4.60.0712050328530.10566@mailgate.netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <f43fc5580712041237n5f89d583y4a5e1572b22bdbaf@mail.gmail.com>
In-Reply-To: <f43fc5580712041237n5f89d583y4a5e1572b22bdbaf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



Sun4d has NEVER worked properly in SMP, the 2.2.x kernels worked in UP.
It has not been properly maintained for at least 5 years and there seems
to be little prospect of fixing the bitrot due to a lack of interested
maintainers.

I had a few stabs at fixing it around 4 years ago but the problems were
beyond my level of kernel competance. AFAIK nobody has touched it since,
my notes are available if someone would like to try.

These machines are not plentiful and are rather old so I am not holding
out much hope. <B-).


On Tue, 4 Dec 2007, Blue Swirl wrote:

> Date: Tue, 4 Dec 2007 22:37:57 +0200
> From: Blue Swirl <blauwirbel@gmail.com>
> To: sparclinux@vger.kernel.org
> Subject: Sun4d interrupt handling?
> 
> Hi,
>
> I'm adding Sun4d support to Qemu and I was wondering if there are any
> docs for Sun4d, especially interrupt handling (SBI, BW, counters, SMP
> issues, boards). Any pointers?
>
> Looking at Linux sources, it seems that SBI handles SBus interrupts
> and then BW masks all interrupt sources. Is BW CPU specific?
>
> It looks like basic hardware (CPU+MMU, zs, esp, lance, eeprom,
> counter) is already implemented in Qemu and IO-UNIT is not very
> different from IOMMU.
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
