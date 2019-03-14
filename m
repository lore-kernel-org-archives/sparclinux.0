From: David Miller <davem@davemloft.net>
Date: Thu, 14 Mar 2019 17:27:17 +0000
Subject: Re: [PATCH 4/7] sparc64: Update cpufreq transition notifier to handle multiple CPUs
Message-Id: <20190314.102717.1146763900493083907.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
        <f4eb2ed1e473ca9bb4c0a9ace27d816f4840f531.1552545525.git.viresh.kumar@linaro.org>
In-Reply-To: <f4eb2ed1e473ca9bb4c0a9ace27d816f4840f531.1552545525.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: viresh.kumar@linaro.org
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, vincent.guittot@linaro.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 14 Mar 2019 12:12:50 +0530

> The cpufreq core currently calls the cpufreq transition notifier
> callback once for each affected CPU. This is going to change soon and
> the cpufreq core will call the callback only once for each cpufreq
> policy. The callback must look at the newly added field in struct
> cpufreq_freqs, "cpus", which contains policy->related_cpus (both
> online/offline CPUs) and perform per-cpu actions for them if any.
> 
> This patch updates sparc64_cpufreq_notifier() to use the new "cpus" field
> and update per-cpu data for all the related CPUs.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: David S. Miller <davem@davemloft.net>
