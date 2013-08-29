From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 29 Aug 2013 10:42:06 +0000
Subject: Re: [Query] CPUFreq: Does these machines have separate clock domains for CPUs?
Message-Id: <CAKohponHDZB37UsacYpmaJPb2-P3b_CJ51e7o=X+D3M68GcdEQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
 <521F2112.5070501@ti.com>
In-Reply-To: <521F2112.5070501@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 29 August 2013 15:53, Sekhar Nori <nsekhar@ti.com> wrote:
> On DaVinci (DA850), there is an async domain available to keep some
> peripheral clocks insulated from cpu frequency changes. But there are a
> bunch of other clocks which do get affected by CPU frequency change
> (they need to run at a fixed ratio to CPU frequency).

My question wasn't about how peripherals are getting clocks.. but how
CPUs are getting them..

Does all CPUs share clock line in Davinci? i.e. if we change freq of one
cpu then freq of other one also gets changed?

Or they are capable of running at different frequencies?

--
viresh
