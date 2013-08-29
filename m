From: Sekhar Nori <nsekhar@ti.com>
Date: Thu, 29 Aug 2013 10:35:14 +0000
Subject: Re: [Query] CPUFreq: Does these machines have separate clock domains for CPUs?
Message-Id: <521F2112.5070501@ti.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
In-Reply-To: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 29 August 2013 03:45 PM, Viresh Kumar wrote:
> Hi,
> 
> I have been doing some CPUFreq cleanup work and
> wanted to know if the below mentioned machines have separate
> clock domains for their CPUs or all share the same domain?

On DaVinci (DA850), there is an async domain available to keep some
peripheral clocks insulated from cpu frequency changes. But there are a
bunch of other clocks which do get affected by CPU frequency change
(they need to run at a fixed ratio to CPU frequency).

Thanks,
Sekhar
