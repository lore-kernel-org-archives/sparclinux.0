From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 14 Mar 2019 06:54:46 +0000
Subject: [PATCH 0/7] cpufreq: Call transition notifier only once for each policy
Message-Id: <cover.1552545525.git.viresh.kumar@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rafael Wysocki <rjw@rjwysocki.net>, Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Russell King <linux@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Currently we call the cpufreq transition notifiers once for each CPU of
the policy->cpus cpumask, which isn't that efficient. This patchset
tries to simplify that by adding another field in struct cpufreq_freqs,
cpus, so the callback has all the information available with a single
call for each policy.

I have tested this on arm64 platform and is compile tested for other
platforms. This has gone through 0-day testing as well, I have pushed my
branch over a week back to the public tree which gets tested by 0-day
bot.

FWIW, it maybe possible to make the callback implementation more
efficient now that they are called only once for each policy, but this
patchset only did the minimum amount of changes to make sure we don't
end up breaking otherwise working code.

--
viresh

Viresh Kumar (7):
  cpufreq: Pass policy->related_cpus to transition notifiers
  ARM: smp: Update cpufreq transition notifier to handle multiple CPUs
  ARM: twd: Update cpufreq transition notifier to handle multiple CPUs
  sparc64: Update cpufreq transition notifier to handle multiple CPUs
  x86/tsc: Update cpufreq transition notifier to handle multiple CPUs
  KVM: x86: Update cpufreq transition notifier to handle multiple CPUs
  cpufreq: Call transition notifiers only once for each policy

 arch/arm/kernel/smp.c       | 23 ++++++++++++++---------
 arch/arm/kernel/smp_twd.c   |  9 ++++++---
 arch/sparc/kernel/time_64.c | 28 ++++++++++++++++------------
 arch/x86/kernel/tsc.c       | 31 ++++++++++++++++++++-----------
 arch/x86/kvm/x86.c          | 31 ++++++++++++++++++++-----------
 drivers/cpufreq/cpufreq.c   | 19 ++++++++++---------
 include/linux/cpufreq.h     |  2 +-
 7 files changed, 87 insertions(+), 56 deletions(-)

-- 
2.21.0.rc0.269.g1a574e7a288b
