From: David Miller <davem@davemloft.net>
Date: Mon, 13 Feb 2017 02:49:22 +0000
Subject: Re: [PATCH] perf: Fix CONFIG_KPROBE_EVENTS and CONFIG_UPROBE_EVENTS typos
Message-Id: <20170212.214922.919964003280067525.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170212211449.25976-1-anton@ozlabs.org>
In-Reply-To: <20170212211449.25976-1-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: anton@ozlabs.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Anton Blanchard <anton@ozlabs.org>
Date: Mon, 13 Feb 2017 08:14:49 +1100

> From: Anton Blanchard <anton@samba.org>
> 
> Fix some incorrect Kconfig options, they should be CONFIG_KPROBE_EVENT
> and CONFIG_UPROBE_EVENT.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: David S. Miller <davem@davemloft.net>
