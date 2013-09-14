From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Sat, 14 Sep 2013 04:13:41 +0000
Subject: Re: [PATCH 012/228] cpufreq: sparc: call cpufreq_frequency_table_get_attr()
Message-Id: <CAKohpokM=5W+qAtCgurtiZvMV2A98xD_M2908Veop0pjD2-FSQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <56edbe14da9944ad026497bc1a0dc4aaa283d506.1379063063.git.viresh.kumar@linaro.org>
 <20130913.174711.268706749518726971.davem@davemloft.net>
In-Reply-To: <20130913.174711.268706749518726971.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 14 September 2013 03:17, David Miller <davem@davemloft.net> wrote:
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Fri, 13 Sep 2013 18:29:18 +0530
>
>> This exposes frequency table of driver to cpufreq core and is required for core
>> to guess what the index for a target frequency is, when it calls
>> cpufreq_frequency_table_target(). And so this driver needs to expose it.
>>
>> Cc: David S. Miller <davem@davemloft.net>
>> Cc: sparclinux@vger.kernel.org
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Wait a second, later in this series you add the put_attr() call claiming
> it's a fix.
>
> But you're the one adding the "bug" here.
>
> So if you are going to add a get_attr() call you should be adding the
> necessary put_attr() call in the same patch.  Otherwise this patch
> introduces a bug.

Yeah, my mistake.. It was required to be added at both places for
very few drivers and so made this mistake..

I will merge both of those patches together..
