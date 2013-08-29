From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Thu, 29 Aug 2013 22:41:28 +0000
Subject: Re: [Query] CPUFreq: Does these machines have separate clock domains for CPUs?
Message-Id: <20130829224127.GA15841@blackmetal.musicnaut.iki.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
In-Reply-To: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On Thu, Aug 29, 2013 at 03:45:58PM +0530, Viresh Kumar wrote:
> I have been doing some CPUFreq cleanup work and
> wanted to know if the below mentioned machines have separate
> clock domains for their CPUs or all share the same domain?
[...]
> drivers/cpufreq/loongson2_cpufreq.c

Loongson2 is UP only.

A.
