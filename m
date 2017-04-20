From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Thu, 20 Apr 2017 03:31:12 +0000
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-Id: <20170420033112.GB542@jagdpanzerIV.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
In-Reply-To: <20170419131341.76bc7634@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello Steven,

On (04/19/17 13:13), Steven Rostedt wrote:
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

hmmm... a really tough one.

well, someone has to say this:
 the simplest thing is to have a bigger PRINTK_SAFE_LOG_BUF_SHIFT value :)


just thinking (well, sort of) out loud. the problem is that we can't tell if
we already hold any printk related locks ("printk related locks" is not even
well defined term). so printk from NMI can deadlock or it can be OK, we
never know. but looking and vprintk_emit() and console_unlock() it seems th=
at
we have some sort of a hint now, which is this_cpu_read(printk_context) - if
we are not in printk_safe context then we can say that _probably_ (and that=
's
a Russian roulette) doing "normal" printk() will work. that is a *very-very*
risky (and admittedly dumb) thing to assume, so we will move in a slightly
different direction. checking this_cpu_read(printk_context) only assures us
that we don't hold `logbuf_lock' on this CPU. and that is sort of something,
at least we can be sure that doing printk_deferred() from this CPU is safe.
printk_deferred() means that your NMI messages will end up in the logbuf,
which is a) bigger in size than per-CPU buffer and b) some other CPU can
immediately print those messages (hopefully).

we also switch to printk_safe mode for call_console_drivers() in
console_unlock(). but we can't make any solid assumptions there - serial
console lock can already be acquired, we don't have any markers for that.
it may be reasonable to assume that if we are not in printk_safe mode on
this CPU then serial console is not locked from this CPU, but there is
nothing that can assure us.

so at the moment what I can think of is something like

  -- check this_cpu_read(printk_context) in NMI prink

	-- if we are NOT in printk_safe on this CPU, then do printk_deferred()
	   and bypass `nmi_print_seq' buffer

	-- if we are in printk_safe
	  -- well... bad luck... have a bigger buffer.

		.... or there are some other options here, but I'd prefer
		not to list them, because people will hate me :)


so this shifts the purpose of `nmi_print_seq' buffer: use it only when
you can't use logbuf. otherwise, do printk_deferred().


need to think more.

	-ss
