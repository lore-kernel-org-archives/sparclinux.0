From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 16 Mar 2017 00:58:19 +0000
Subject: change uprobe_events default ? Was: [PATCH] perf: Rename CONFIG_[UK]PROBE_EVENT to CONFIG_[UK]PROBE_
Message-Id: <20170316005817.GA6805@ast-mbp.thefacebook.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170216060050.20866-1-anton@ozlabs.org>
In-Reply-To: <20170216060050.20866-1-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anton Blanchard <anton@ozlabs.org>
Cc: davem@davemloft.net, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Feb 16, 2017 at 05:00:50PM +1100, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> We have uses of CONFIG_UPROBE_EVENT and CONFIG_KPROBE_EVENT as
> well as CONFIG_UPROBE_EVENTS and CONFIG_KPROBE_EVENTS. Consistently
> use the plurals.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

this rename made me notice that UPROBE_EVENTS still defaults to 'n'.
this is key feature that all distros enable, so having default 'n'
is kinda saying that it's not something that should be turned on
or used widely. which is obviously not the case.
imo it's time to change it to 'y'.
Thoughts?

