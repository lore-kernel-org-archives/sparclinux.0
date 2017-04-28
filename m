From: Steven Rostedt <rostedt@goodmis.org>
Date: Fri, 28 Apr 2017 14:16:59 +0000
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-Id: <20170428101659.7cd879e7@gandalf.local.home>
List-Id: <sparclinux.vger.kernel.org>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170427121458.2be577cc@gandalf.local.home>
 <20170428013532.GB383@jagdpanzerIV.localdomain>
 <20170428125725.GA3452@pathway.suse.cz>
In-Reply-To: <20170428125725.GA3452@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 28 Apr 2017 14:57:25 +0200
Petr Mladek <pmladek@suse.com> wrote:


> Of course, if the problem is reproducible, the easiest solution
> is to use bigger main log buffer, for example boot with
> log_buf_len2M.

Of course that may not be enough. Especially when I have a machine with
240 CPUs. But it also has a ton of RAM, I could easily do
log_buf_len2G

-- Steve
