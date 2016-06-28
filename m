From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 28 Jun 2016 10:37:19 +0000
Subject: Re: [PATCH] sparc64: sparc64_defconfig: convert to use libata PATA drivers
Message-Id: <CAGRGNgX8OtTL-jN6ya0Who5Z2QAS7YqQutO4aEPCqYRO8pA9mQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1467030232-10027-1-git-send-email-b.zolnierkie@samsung.com>
In-Reply-To: <1467030232-10027-1-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Meelis,

On Tue, Jun 28, 2016 at 8:27 PM, Meelis Roos <mroos@linux.ee> wrote:
>> The Ultra 5 uses a CMD64x controller.
>>
>> That said, last time I tried to get that machine working, I couldn't
>> partition the disk due to bugs in that driver.
>
> Yes, Ultra 5 uses CMD64x. This has worked well for me on U5 for ages.
> The debug messages have also been there as long as I remember. The
> controller is limited to 128GiB disks in DMA mode so I have used up to
> 120G disks only and have not tried any bigger ones.

Oh, the last time I tried, I had trouble partitioning the disk due to
it seemingly not writing beyond the first sector. I'll have to try
again.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
