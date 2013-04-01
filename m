From: David Miller <davem@davemloft.net>
Date: Mon, 01 Apr 2013 16:58:30 +0000
Subject: Re: [PATCH 6/9] cpufreq: Don't check if cpu is online/offline for cpufreq callbacks
Message-Id: <20130401.125830.1655034418750471341.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1364820620.git.viresh.kumar@linaro.org>
        <cover.1364820620.git.viresh.kumar@linaro.org>
        <cd771cb37feb4e79172548ed342ad194ee31a384.1364820620.git.viresh.kumar@linaro.org>
In-Reply-To: <cd771cb37feb4e79172548ed342ad194ee31a384.1364820620.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: viresh.kumar@linaro.org
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org, lethal@linux-sh.org, trenn@suse.de, bp@alien8.de, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon,  1 Apr 2013 18:27:46 +0530

> cpufreq layer doesn't call cpufreq driver's callback for any offline cpu and so
> checking that isn't useful.
> 
> Lets get rid of it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

For sparc bits:

Acked-by: David S. Miller <davem@davemloft.net>
