From: Anton Blanchard <anton@samba.org>
Date: Thu, 16 Feb 2017 05:59:54 +0000
Subject: Re: [PATCH] perf: Fix CONFIG_KPROBE_EVENTS and CONFIG_UPROBE_EVENTS typos
Message-Id: <20170216165954.7cdc23e3@kryten>
List-Id: <sparclinux.vger.kernel.org>
References: <20170212211449.25976-1-anton@ozlabs.org>
        <20170213065152.GA30715@gmail.com>
In-Reply-To: <20170213065152.GA30715@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@kernel.org>
Cc: davem@davemloft.net, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Ingo,

> So the names should be fixed, it should be CONFIG_UPROBE_EVENTS and 
> CONFIG_KPROBE_EVENTS throughout the code. It's CONFIG_PERF_EVENTS and 
> CONFIG_PROBE_EVENTS after all and lives in kernel/events/ - all
> plural.
> 
> I didn't notice the misnomer when merging these bits.

Ok, patch to follow.

Anton
