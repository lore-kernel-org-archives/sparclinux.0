From: Julian Calaby <julian.calaby@gmail.com>
Date: Mon, 27 Jun 2016 23:18:59 +0000
Subject: Re: [PATCH] sparc64: sparc64_defconfig: convert to use libata PATA drivers
Message-Id: <CAGRGNgUzCDkXvq3YvihUoh87NFNWOUnqCUbWMAa09oj8N2vskw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1467030232-10027-1-git-send-email-b.zolnierkie@samsung.com> <6e328063b70b3fe60b4dd962c1616260@triadic.us>
In-Reply-To: <6e328063b70b3fe60b4dd962c1616260@triadic.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alexmcwhirter@triadic.us
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, sparclinux <sparclinux@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, sparclinux-owner@vger.kernel.org

Hi Alex,

On Tue, Jun 28, 2016 at 2:38 AM,  <alexmcwhirter@triadic.us> wrote:
> On 2016-06-27 08:23, Bartlomiej Zolnierkiewicz wrote:
>
>> If you have affected hardware please test.  Thank you.
>
>
> For what it's worth, I've been using libata on sparc64 for roughly two years
> with no issues to report. All of my PATA machines have ALI controllers, not
> sure if any other controllers were ever used in sparc gear.

The Ultra 5 uses a CMD64x controller.

That said, last time I tried to get that machine working, I couldn't
partition the disk due to bugs in that driver.

I believe the Ultra 10 uses the same motherboard so it's likely also
affected. I believe these were in the first generation of "PC" like
SPARC workstations.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
