From: Mikael Starvik <mikael.starvik@axis.com>
Date: Fri, 30 Aug 2013 04:21:19 +0000
Subject: Re: [Query] CPUFreq: Does these machines have separate clock domains for CPUs?
Message-Id: <D9E0917B-058A-4F22-87EF-15F26ED46F35@axis.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
In-Reply-To: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Cris are also UP

29 aug 2013 kl. 12:16 skrev "Viresh Kumar" <viresh.kumar@linaro.org>:

> Hi,
> 
> I have been doing some CPUFreq cleanup work and
> wanted to know if the below mentioned machines have separate
> clock domains for their CPUs or all share the same domain?
> 
> So, that we can use some generic routines for these drivers which
> would eventually do:
> 
> cpumask_setall(policy->cpus);
> 
> And I wanted to make sure that this doesn't break them.. :)
> 
> ......
> 
> The drivers are:
> 
> drivers/cpufreq/at32ap-cpufreq.c
> drivers/cpufreq/blackfin-cpufreq.c
> drivers/cpufreq/cris-artpec3-cpufreq.c
> drivers/cpufreq/cris-etraxfs-cpufreq.c
> drivers/cpufreq/davinci-cpufreq.c
> drivers/cpufreq/e_powersaver.c
> drivers/cpufreq/elanfreq.c
> drivers/cpufreq/longhaul.c
> drivers/cpufreq/loongson2_cpufreq.c
> drivers/cpufreq/pmac32-cpufreq.c
> drivers/cpufreq/powernow-k6.c
> drivers/cpufreq/powernow-k7.c
> drivers/cpufreq/pxa2xx-cpufreq.c
> drivers/cpufreq/pxa3xx-cpufreq.c
> drivers/cpufreq/sc520_freq.c
> drivers/cpufreq/sh-cpufreq.c
> drivers/cpufreq/sparc-us2e-cpufreq.c
> drivers/cpufreq/sparc-us3-cpufreq.c
> 
> --
> Viresh
