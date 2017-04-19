From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 19 Apr 2017 17:21:39 +0000
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-Id: <20170419172139.hipylcdsarhvnsby@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
In-Reply-To: <20170419131341.76bc7634@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, Apr 19, 2017 at 01:13:41PM -0400, Steven Rostedt wrote:
> On Thu, 21 Apr 2016 13:48:42 +0200
> Petr Mladek <pmladek@suse.com> wrote:
>=20
> > printk() takes some locks and could not be used a safe way in NMI conte=
xt.
>=20
> I just found a problem with this solution. It kills ftrace dumps from
> NMI context :-(
>=20
> [ 1295.168495]    <...>-67423  10dNh1 382171111us : do_raw_spin_lock <-_r=
aw_spin_lock
> [ 1295.168495]    <...>-67423  10dNh1 382171111us : sched_stat_runtime: c=
omm=CC1 pidg423 runtime=96858 [ns] vruntime=11924198270 [ns]
> [ 1295.168496]    <...>-67423  10dNh1 382171111us : lock_acquire: fffffff=
f81c5c940 read rcu_read_lock
> [ 1295.168497]
> [ 1295.168498] Lost 4890096 message(s)!
> [ 1296.805063] ---[ end Kernel panic - not syncing: Hard LOCKUP
> [ 1296.811553] unchecked MSR access error: WRMSR to 0x83f (tried to write=
 0x00000000000000f6) at rIP: 0xffffffff81046fc7 (native_apic_msr_write+0x27=
/0x40)
> [ 1296.811553] Call Trace:
> [ 1296.811553]  <NMI>
>=20
> I was hoping to see a cause of a hard lockup by enabling
> ftrace_dump_on_oops. But as NMIs now have a very small buffer that
> gets flushed, we need to find a new way to print out the full ftrace
> buffer over serial.
>=20
> Thoughts?

early_printk ;-)
