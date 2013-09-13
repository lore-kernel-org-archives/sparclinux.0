From: David Miller <davem@davemloft.net>
Date: Fri, 13 Sep 2013 21:46:20 +0000
Subject: Re: [PATCH 042/228] cpufreq: sparc: use cpufreq_table_validate_and_show()
Message-Id: <20130913.174620.1338104286620840125.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <cover.1379063063.git.viresh.kumar@linaro.org>
 <454f6bb0c5fa53654e694c82db6ca758410826f5.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <454f6bb0c5fa53654e694c82db6ca758410826f5.1379063063.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 13 Sep 2013 18:29:48 +0530

> Lets use cpufreq_table_validate_and_show() instead of calling
> cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().
> 
> Cc: David S. Miller <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: David S. Miller <davem@davemloft.net>
