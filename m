From: Ingo Molnar <mingo@kernel.org>
Date: Mon, 13 Feb 2017 06:51:52 +0000
Subject: Re: [PATCH] perf: Fix CONFIG_KPROBE_EVENTS and CONFIG_UPROBE_EVENTS typos
Message-Id: <20170213065152.GA30715@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170212211449.25976-1-anton@ozlabs.org>
In-Reply-To: <20170212211449.25976-1-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anton Blanchard <anton@ozlabs.org>
Cc: davem@davemloft.net, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


* Anton Blanchard <anton@ozlabs.org> wrote:

> From: Anton Blanchard <anton@samba.org>
> 
> Fix some incorrect Kconfig options, they should be CONFIG_KPROBE_EVENT
> and CONFIG_UPROBE_EVENT.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/sparc/configs/sparc64_defconfig | 2 +-
>  tools/perf/util/probe-file.c         | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)

So the names should be fixed, it should be CONFIG_UPROBE_EVENTS and 
CONFIG_KPROBE_EVENTS throughout the code. It's CONFIG_PERF_EVENTS and 
CONFIG_PROBE_EVENTS after all and lives in kernel/events/ - all plural.

I didn't notice the misnomer when merging these bits.

Thanks,

	Ingo
