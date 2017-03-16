From: Arnaldo Carvalho de Melo <acme@kernel.org>
Date: Thu, 16 Mar 2017 12:31:54 +0000
Subject: Re: change uprobe_events default ? Was: [PATCH] perf: Rename CONFIG_[UK]PROBE_EVENT to CONFIG_[UK]PR
Message-Id: <20170316123154.GT12825@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20170216060050.20866-1-anton@ozlabs.org>
 <20170316005817.GA6805@ast-mbp.thefacebook.com>
 <20170316010651.GP12825@kernel.org>
 <20170316064055.GA7130@gmail.com>
In-Reply-To: <20170316064055.GA7130@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Anton Blanchard <anton@ozlabs.org>, David Miller <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Hemant Kumar <hemant@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>, Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, alexander.shishkin@linux.intel.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Em Thu, Mar 16, 2017 at 07:40:55AM +0100, Ingo Molnar escreveu:
> 
> * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > Added more people to the CC list.
> > 
> > Em Wed, Mar 15, 2017 at 05:58:19PM -0700, Alexei Starovoitov escreveu:
> > > On Thu, Feb 16, 2017 at 05:00:50PM +1100, Anton Blanchard wrote:
> > > > We have uses of CONFIG_UPROBE_EVENT and CONFIG_KPROBE_EVENT as
> > > > well as CONFIG_UPROBE_EVENTS and CONFIG_KPROBE_EVENTS. Consistently
> > > > use the plurals.
> >  
> > > this rename made me notice that UPROBE_EVENTS still defaults to 'n'.
> > > this is key feature that all distros enable, so having default 'n'
> > > is kinda saying that it's not something that should be turned on
> > > or used widely. which is obviously not the case.
> > > imo it's time to change it to 'y'.
> > > Thoughts?
> > 
> > Agreed, I also found it strange that it was disabled by default when I
> > recently did a 'make oldconfig' :-\
> 
> Agreed, someone please send a patch (or feel free to include it in the perf 
> tooling tree) to switch the default around.

Ok, will collect the agreements as Acked-by tags and put it in
perf/core.

- Arnaldo
