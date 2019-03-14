From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 14 Mar 2019 11:15:18 +0000
Subject: Re: [PATCH 0/7] cpufreq: Call transition notifier only once for each policy
Message-Id: <20190314110318.on5bfau32tjsxnuz@vireshk-i7>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
 <CAJZ5v0gER+aJaQmk89VSVBtHgQ+WPDdAxUW6eJ4JCB=emC85dg@mail.gmail.com>
 <20190314101606.2aodwz5mzvstau6c@vireshk-i7>
 <CAJZ5v0jiumt_nvhc3Bv_b94Xq22h5vTwDPeM1qo+6bzChn58FQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jiumt_nvhc3Bv_b94Xq22h5vTwDPeM1qo+6bzChn58FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Russell King <linux@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, kvm@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On 14-03-19, 11:55, Rafael J. Wysocki wrote:
> On Thu, Mar 14, 2019 at 11:16 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> But some of them need to combine the new cpumask with
> cpu_online_mask() to get what would be policy->cpus effectively.  That
> would be avoidable if you passed the policy pointer to them.

Right, that's what I also thought after your previous email. Will pass
the policy pointer instead.

-- 
viresh
