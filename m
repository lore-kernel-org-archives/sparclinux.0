From: Sekhar Nori <nsekhar@ti.com>
Date: Thu, 29 Aug 2013 10:39:44 +0000
Subject: Re: [Query] CPUFreq: Does these machines have separate clock domains for CPUs?
Message-Id: <521F2220.5030403@ti.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
 <521F2112.5070501@ti.com>
 <CAKohponHDZB37UsacYpmaJPb2-P3b_CJ51e7o=X+D3M68GcdEQ@mail.gmail.com>
In-Reply-To: <CAKohponHDZB37UsacYpmaJPb2-P3b_CJ51e7o=X+D3M68GcdEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 29 August 2013 04:00 PM, Viresh Kumar wrote:
> On 29 August 2013 15:53, Sekhar Nori <nsekhar@ti.com> wrote:
>> On DaVinci (DA850), there is an async domain available to keep some
>> peripheral clocks insulated from cpu frequency changes. But there are a
>> bunch of other clocks which do get affected by CPU frequency change
>> (they need to run at a fixed ratio to CPU frequency).
> 
> My question wasn't about how peripherals are getting clocks.. but how
> CPUs are getting them..
> 
> Does all CPUs share clock line in Davinci? i.e. if we change freq of one
> cpu then freq of other one also gets changed?
> 
> Or they are capable of running at different frequencies?

I get it now. All DaVinci devices are UP only.

Thanks,
Sekhar
