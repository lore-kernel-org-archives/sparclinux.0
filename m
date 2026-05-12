Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AF319005E
	for <sparclinux@vger.kernel.org>; Tue, 12 May 2026 05:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778562199; cv=none; b=SfvNji9lpEx+JP04A19Qz5DXMM0rQlDp8wuapaHK3pzLOZ2Cqmp8YnP1dGj0Acrox3MG9YC93h/+VKrxnGcm3uc7tW08xRnmcaSdE2L0XmZG+fT6F2ntSnL0ZGYLW1uatcNb0cf9XvGln9KnzZPQUB2nqbo0q2wijx6KNv8Rnac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778562199; c=relaxed/simple;
	bh=D1OJNejxkvxy3cWv/oTpb95aKTcd0y8wty80pbr25qU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ot3U6AhDcTRCDZvMQhExpxWVtuAW0YsRc3hBWlarLnJ10QDyBZvzQUVhpJxm46Uoa5Us8h5LCOt59OfrUR86ioQ3p72uTsuJUD9xmDO5yf9UNy+JRXCOQgLsErWPncrLYmyHRVwQP4tNYTyTVn8Eocx0VE+g0F8bUaNn7+MZUVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=On/xyttW; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="On/xyttW"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so12409125eec.0
        for <sparclinux@vger.kernel.org>; Mon, 11 May 2026 22:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778562197; x=1779166997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lj+6e5SGMgmwImq7p/7V+JKRxYZxl8f8f8WRjGE4pzo=;
        b=On/xyttW3OENLGisSRxn9KdOelwC9Rum7sRMelOheUPcycZf50WhxvwE2X6ppY8His
         DF6JzE5SiDGo06v2rCyKj/uXgCkR7RQkRvrs+tKFM5tv2ibW3dZKvxXbZJ30pRD8+O4+
         POauqy2DILZo6N43fkyGn3wKhl4QiVYo9oJtoO8bj5mr5k3Nm5iFSNvjDGmDon2IwNwl
         6Q21J7a+URZEX3c/zVovRjbvNJJMlpEcZyXXFbxVWzY/DZDfH5tu7ZOjYiGk3H4al+fd
         wMIDMnHTLiq4Et5oc6lT/2sN1GJpSy/sUIEBHMW9R8yQJu12xkZvdnRc8uWuQZKJXQ5P
         nh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778562197; x=1779166997;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lj+6e5SGMgmwImq7p/7V+JKRxYZxl8f8f8WRjGE4pzo=;
        b=Mav3hDp6zqz7RznRxGMDB9eXoxRUy05w+0NNrYu6vkYW9eOw7hFakA2WYZl2qY1A+I
         Kqzq3JzwH1YwTSr7Ua88hY3wagz684nQVeO1gwIJ8wf7jKDOQpeSddyZBAdTO5OrDPSx
         3jybnDPkWg/VTVhI2bSWYLvLqE7WQiXAJE0lIudA2S95mbp+coKYP6+l4GRuyA2fOf2m
         MpCAw6b2v/urVfOgfpO/zo6cv6cGmGTL2koH9epbDrEmOWkWn8k9dv7P043ydIMpS23Y
         VWvXfCcDihTuAGvZ9eDXkfyOcxBm+6nWsSmEkbwzL9qhxjd5SmL8kWUPtMP8aJB34Re6
         qggA==
X-Forwarded-Encrypted: i=1; AFNElJ+7e/C8wlUvEQL+SpsnrjTejVE20tTUEAoqUu1edX9MZTePk8brB2HyueQz3/k7zdFHhCmxOJwKpJrh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr8btm6F22oEV56lbAYCYbtNAXqXBBc/p5tRjEOWAMeOHgXTwx
	PcIH+a28PqlCr62Sy0L2KSWe9Ujd9kMCqB/YURQxqEbl250mponH7WQj
X-Gm-Gg: Acq92OEbsIy1ypMSxVytD4J0TwJDv/oHBFAdayzw/gSaZmU+u2xArTv8onDAB+kz1ii
	TO3uX7JVv1atNcYah/ntDqYDWM6WeL5ZqLqEmNDMGnAYIW3dOF+EEBfh0DePED2EajPXmd54edM
	MywdRGAPuEphcre0twCe6lkae84YGRKBQuWDEaCTrAReOEi0hUrLaPxeHiwAAneZu/9JC3VftcU
	muIW1PTwJmRf/uLUP0xXGsc/XCphQsApYcH0RZH/eRvErpVdoklTKmwlRigfH0UbmXt0OfrGtok
	qVDnsQTygFPTARkJ6IfnFAUGoUQES7gfoMHpSeqJxegN5nctmdmlG4o19XwbXBQ2II3K1juKEbE
	gYWIGZGhqq+WZtWBUJkjfimQ5GU0Wr5CG+pFMwJroF/YugnRbe8VF8oX5OXAtlIYc7Kr3LRAHLh
	AYE6QbbVsyKqZr4aXnZuFAuakgWhMZAQ==
X-Received: by 2002:a05:693c:2d8a:b0:2f1:6252:f8fe with SMTP id 5a478bee46e88-2ffd51c6804mr1038825eec.3.1778562196529;
        Mon, 11 May 2026 22:03:16 -0700 (PDT)
Received: from [192.168.21.192] ([67.170.89.46])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e3e285sm19352438eec.27.2026.05.11.22.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 22:03:15 -0700 (PDT)
Message-ID: <088e6cfa-0167-4748-af6c-458ade2f303a@gmail.com>
Date: Mon, 11 May 2026 22:03:14 -0700
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: the stuttering regression in 7.0: should I have done something
 different
Content-Language: en-US
From: Tony Rodriguez <unixpro1970@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Thorsten Leemhuis <regressions@leemhuis.info>
References: <ffb44522-f01c-4be3-849d-27dc17fbca7f@leemhuis.info>
 <D5D19776-C809-4284-9417-F9A860877B98@gmail.com>
 <1c165caf-36b4-4673-97fd-ed86bef17b88@leemhuis.info>
 <3332123b-9e11-4895-9ab3-1707fba5815c@gmail.com> <871pfj9cmj.ffs@tglx>
 <a7a0d78b-435e-43c8-b436-5e7f4dd39dee@gmail.com>
In-Reply-To: <a7a0d78b-435e-43c8-b436-5e7f4dd39dee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

  On 5/10/26 02:29 PM,  Thomas Gleixner wrote:

> Can you apply the debug patch below, which will disable tracing once it
> hits the hung task detector and then retrieve the trace? 
As requested, I applied your debug patch to v7.1‑rc3 and captured the 
trace output.
On the SPARC64 S7‑2 system the machine becomes unresponsive and produces 
many thousands of
lines of trace data that do not appear to terminate. Posting the full 
output inline
or as an attachment may be impractical, so I’ve included the key 
sections below.

If you prefer the complete trace, please let me know the best way to 
provide it. Guessing the kernel

mailing isn't best to attach that?


A) Output with avahi-daemon and avahi-utils installed
(This shows avahi and systemd activity before the hang.)

Note: The system is using the standard Debian-provided avahi and systemd 
packages.
No custom scripts or modifications are in place.

BOOT_IMAGE=/boot/vmlinuz-7.1.0-rc3-test01 
root=UUID=ce937a4b-126a-41bd-a54b-03a424421086 ro console=ttyHV0,9600n81 
systemd.log_level=info systemd.show_status=1 
systemd.journald.forward_to_console=0 plymouth.enable=0 ignore_loglevel 
loglevel=8 ftrace_dump_on_oops=1 hung_task_panic=1

[    1.206192] printk: log_buf_len individual max cpu contribution: 4096 
bytes
[    1.219999] printk: log_buf_len total cpu_extra contributions: 520192 
bytes
[    1.233883] printk: log_buf_len min size: 131072 bytes
[    1.249357] printk: log buffer data + meta data: 1048576 + 4456448 = 
5505024 bytes
[    1.264204] printk: early log buf free: 126896(96%)
[    1.328220] Dentry cache hash table entries: 8388608 (order: 13, 
67108864 bytes, linear)
[    1.371366] Inode-cache hash table entries: 4194304 (order: 12, 
33554432 bytes, linear)
[    1.387117] Sorting __ex_table...
[    1.394073] Built 1 zonelists, mobility grouping on.  Total pages: 
16545911
[    1.407711] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    1.434383] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=128, Nodes=1
[    1.467254] ftrace: allocating 36740 entries in 72 pages
[    1.477580] ftrace: allocated 72 pages with 2 groups
[    1.487945]
     1.516665] **     **
[    1.529690] ** trace_printk() being used. Allocating extra memory.  **
[    1.542707] **     **
[    1.555727] ** This means that this is a DEBUG kernel and it is     **
[    1.487945]
[    1.490630] **********************************************************
[    1.503647] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    1.516665] **     **
[    1.529690] ** trace_printk() being used. Allocating extra memory.  **
[    1.542707] **     **
[    1.555727] ** This means that this is a DEBUG kernel and it is     **
[    1.568743] ** unsafe for production use.      **
[    1.581778] **     **
[    1.594794] ** If you see this message and you are not debugging    **
[    1.607811] ** the kernel, report this immediately to your vendor!  **
[    1.620828] **     **
[    1.633847] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    1.646880] **********************************************************
[  OK  ] Started avahi-daemon.service - Avahi mDNS/DNS-SD Stack.
[  248.416424] INFO: task systemd:1 blocked for more than 120 seconds.
[  248.428721]       Not tainted 7.1.0-rc3-test01 #2
[  248.438087] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  248.453706] task:systemd         state:D stack:20312 pid:1  tgid:1    
  ppid:0      task_flags:0x400100 flags:0x208000101000000
[  248.476970] Call Trace:
[  248.481829] [<0000000000fd993c>] schedule+0x1c/0x180
[  248.491728] [<0000000000fe1a10>] schedule_timeout+0x90/0x100
[  248.503017] [<0000000000fda5b0>] __wait_for_common+0xb0/0x180
[  248.514472] [<0000000000fda7a0>] wait_for_completion_state+0x20/0x60
[  248.527151] [<0000000000527234>] __wait_rcu_gp+0x114/0x1e0
[  248.538089] [<000000000052d9c8>] synchronize_rcu_normal.part.0+0x48/0x60
[  248.551452] [<000000000052f860>] synchronize_rcu_normal+0xc0/0xe0
[  248.563605] [<0000000000532820>] synchronize_rcu+0xe0/0x140
[  248.574720] [<00000000005285c4>] rcu_sync_enter+0x44/0x140
[  248.585650] [<0000000000fdf114>] percpu_down_write+0x14/0x240
[  248.597105] [<000000000057ef20>] cgroup_procs_write_start+0x1c0/0x240
[  248.609956] [<000000000057f8d0>] __cgroup_procs_write+0x30/0x1c0
[  248.621939] [<000000000057fab4>] cgroup_procs_write+0x14/0x40
[  248.633393] [<0000000000577910>] cgroup_file_write+0x90/0x160
[  248.644851] [<00000000008b536c>] kernfs_fop_write_iter+0x14c/0x240
[  248.657182] [<00000000007e7210>] vfs_write+0x210/0x460
[  248.667496] INFO: task (systemd-hostn):1968 blocked for more than 120 
seconds.
[  248.681833]       Not tainted 7.1.0-rc3-test01 #2
[  248.691196] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  248.706831] task:(systemd-hostn) state:D stack:25352 pid:1968 
tgid:1968  ppid:1      task_flags:0x400100 flags:0x408000102000000
[  248.730091] Call Trace:
[  248.734952] [<0000000000fd993c>] schedule+0x1c/0x180
[  248.744843] [<0000000000fd9b2c>] schedule_preempt_disabled+0xc/0x20
[  248.757352] [<0000000000fdca0c>] __mutex_lock.constprop.0+0x58c/0xf00
[  248.770184] [<0000000000fdd490>] __mutex_lock_slowpath+0x10/0x20
[  248.782166] [<0000000000fdd4d0>] mutex_lock+0x30/0x40
[  248.792243] [<000000000057f34c>] cgroup_kn_lock_live+0x4c/0x120
[  248.804040] [<000000000057f8b8>] __cgroup_procs_write+0x18/0x1c0
[  248.816021] [<000000000057fab4>] cgroup_procs_write+0x14/0x40
[  248.827476] [<0000000000577910>] cgroup_file_write+0x90/0x160
[  248.838946] [<00000000008b536c>] kernfs_fop_write_iter+0x14c/0x240
[  248.851269] [<00000000007e7210>] vfs_write+0x210/0x460
[  248.861500] [<00000000007e75d0>] ksys_write+0x50/0xe0
[  248.871579] [<00000000007e7674>] sys_write+0x14/0x40
[  248.881469] [<00000000004062b4>] linux_sparc_syscall+0x34/0x44
[  248.893098] INFO: task (systemd-hostn):1968 is blocked on a mutex 
likely owned by task systemd:1.
[  248.910809] Kernel panic - not syncing: hung_task: blocked tasks
[  248.922783] CPU: 48 UID: 0 PID: 677 Comm: khungtaskd Not tainted 
7.1.0-rc3-test01 #2 VOLUNTARY
[  248.940151] Call Trace:
[  248.945010] [<0000000000436fcc>] dump_stack+0x8/0x18
[  248.954902] [<00000000004293a4>] vpanic+0xfc/0x33c
[  248.964453] [<0000000000429608>] panic+0x24/0x30
[  248.973648] [<00000000005a8158>] watchdog+0x238/0x840
[  248.983725] [<00000000004af254>] kthread+0x114/0x160
[  248.993622] [<00000000004060f0>] ret_from_fork+0x24/0x34
[  249.004209] [<0000000000000000>] 0x0
[  249.019116] Dumping ftrace buffer:
[  249.025666] ---------------------------------
[  249.034534]   <idle>-0         0d.... 1836659us : 
clockevents_program_event: Successfully programmed 4000000 4000000
[  249.055418]   <idle>-0         0d.h.. 1845926us : timer_interrupt: 
Invoking handler tick_handle_periodic+0x0/0xa0
[  249.075895]   <idle>-0         0d.h.. 1845938us : 
clockevents_program_event: Successfully programmed 8000000 4000000
[  249.096899]   <idle>-0         0d.h.. 1849938us : timer_interrupt: 
Invoking handler tick_handle_periodic+0x0/0xa0
[  249.117390]   <idle>-0         0d.h.. 1849940us : 
clockevents_program_event: Successfully programmed 12000000 4000000
[  249.138563]   <idle>-0         0d.h.. 1853940us : timer_interrupt: 
Invoking handler tick_handle_periodic+0x0/0xa0
[  249.159053]   <idle>-0         0d.h.. 1853942us : 
clockevents_program_event: Successfully programmed 16000000 4000000
[  249.180226]   <idle>-0         0d.h.. 1857942us : timer_interrupt: 
Invoking handler tick_handle_periodic+0x0/0xa0
[  249.200718]   <idle>-0         0d.h.. 1857943us : 
clockevents_program_event: Successfully programmed 20000000 40000

B) This is without avahi-daemon and avahi-utils  installed.  Just to 
rule out a possible confiict with avahi.

BOOT_IMAGE=/boot/vmlinuz-7.1.0-rc3-test01 
root=UUID=ce937a4b-126a-41bd-a54b-03a424421086 ro console=ttyHV0,9600n81 
systemd.log_level=info systemd.show_status=1 
systemd.journald.forward_to_console=0 plymouth.enable=0 ignore_loglevel 
loglevel=8 ftrace_dump_on_oops=1 hung_task_panic=1

[  OK  ] Reached target graphical.target - Graphical Interface.
[  310.338420] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  310.350060] rcu:     3-...!: (259 GPs behind) 
idle=bb6c/1/0x4000000000000000 softirq=1081/1081 fqs=0
[  310.367759] rcu:     27-...!: (313 GPs behind) 
idle=55cc/1/0x4000000000000000 softirq=284/286 fqs=0
[  310.385298] rcu:     34-...!: (261 GPs behind) 
idle=3a64/1/0x4000000000000000 softirq=524/524 fqs=0
[  310.402834] rcu:     46-...!: (261 GPs behind) 
idle=743c/1/0x4000000000000000 softirq=258/259 fqs=0
[  310.420366] rcu:     (detected by 73, t=5275 jiffies, g=5933, q=80255 
ncpus=128)
[  310.434745]   CPU[  3]: TSTATE[00000000f0001206] 
TPC[00000000010d8694] TNPC[00000000010d8698] TASK[cc1:14002]
[  310.434759]              TPC[10d8694] O7[8f32fc] I7[89d438] RPC[8a4bac]
[  310.434866]   CPU[ 27]: TSTATE[00000099f0001202] 
TPC[00000000010f09f0] TNPC[00000000008dc138] TASK[cc1:13964]
[  310.434875]              TPC[10f09f0] O7[8dc130] I7[8dcea0] RPC[8dc90c]
[  310.434965]   CPU[ 34]: TSTATE[00000044f0001202] 
TPC[0000000000b687d8] TNPC[0000000000b687dc] TASK[cc1:13408]
[  310.434973]              TPC[b687d8] O7[b68754] I7[b668c8] RPC[8af5e0]
[  310.435065]   CPU[ 46]: TSTATE[00000044f0001206] 
TPC[00000000008cf138] TNPC[00000000008cf13c] TASK[cc1:13823]
[  310.435073]              TPC[8cf138] O7[8cf0dc] I7[8ce048] RPC[11152c0]
[  310.435103] rcu: rcu_sched kthread timer wakeup didn't happen for 
5274 jiffies! g5933 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
[  310.588885] rcu:     Possible timer handling issue on cpu=66 
timer-softirq=248
[  310.602770] rcu: rcu_sched kthread starved for 5320 jiffies! g5933 
f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=66
[  310.623249] rcu:     Unless rcu_sched kthread gets sufficient CPU 
time, OOM is now expected behavior.
[  310.641135] rcu: RCU grace-period kthread stack dump:
[  310.651207] task:rcu_sched       state:I stack:26936 pid:15 tgid:15  
   ppid:2      task_flags:0x208040 flags:0x07000000
[  310.673256] Call Trace:
[  310.678113] [<0000000000fd993c>] schedule+0x1c/0x180
[  310.688017] [<0000000000fe19f0>] schedule_timeout+0x70/0x100
[  310.699294] [<0000000000530064>] rcu_gp_fqs_loop+0x104/0x4e0
[  310.710578] [<0000000000535474>] rcu_gp_kthread+0x134/0x180
[  310.721686] [<00000000004af254>] kthread+0x114/0x160
[  310.731588] [<00000000004060f0>] ret_from_fork+0x24/0x34
[  310.742169] [<0000000000000000>] 0x0
[  310.749288] rcu: Stack dump where RCU GP kthread last ran:
[  310.760431]   CPU[ 66]: TSTATE[00000044f0001204] 
TPC[0000000000988ccc] TNPC[0000000000988cd0] TASK[cc1:13619]
[  310.780027]              TPC[988ccc] O7[cc5ab8] I7[989064] RPC[98901c]
[  373.795586] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  373.807192] rcu:     3-...!: (259 GPs behind) idle=cef8/0/0x0 
softirq=1081/1081 fqs=1 (false positive?)
[  373.825415] rcu:     27-...!: (313 GPs behind) idle=5d60/0/0x0 
softirq=284/286 fqs=1 (false positive?)
[  373.843469] rcu:     34-...!: (261 GPs behind) idle=4088/0/0x0 
softirq=524/524 fqs=1 (false positive?)
[  373.861522] rcu:     46-...!: (261 GPs behind) idle=7a78/0/0x0 
softirq=258/259 fqs=1 (false positive?)
[  373.879591] rcu:     (detected by 98, t=21140 jiffies, g=5933, 
q=98416 ncpus=128)
[  373.894056]   CPU[  3]: TSTATE[0000004411081605] 
TPC[000000000043d524] TNPC[000000000043d528] TASK[swapper/3:0]
[  373.894061]              TPC[arch_cpu_idle+0x84/0xc0] 
O7[arch_cpu_idle+0x70/0xc0] I7[default_idle_call+0x30/0x160] 
RPC[do_idle+0x104/0x1e0]
RPC[do_idle+0x104/0x1e0]
[  373.894138]   CPU[ 27]: TSTATE[0000004411081605] 
TPC[000000000043d524] TNPC[000000000043d528] TASK[swapper/27:0]
[  373.894142]              TPC[arch_cpu_idle+0x84/0xc0] 
O7[arch_cpu_idle+0x70/0xc0] I7[default_idle_call+0x30/0x160] 
RPC[do_idle+0x104/0x1e0]
[  373.894209]   CPU[ 34]: TSTATE[0000004411081605] 
TPC[000000000043d524] TNPC[000000000043d528] TASK[swapper/34:0]
[  373.894214]              TPC[arch_cpu_idle+0x84/0xc0] 
O7[arch_cpu_idle+0x70/0xc0] I7[default_idle_call+0x30/0x160] 
RPC[do_idle+0x104/0x1e0]
[  373.894280]   CPU[ 46]: TSTATE[0000004411081605] 
TPC[000000000043d524] TNPC[000000000043d528] TASK[swapper/46:0]
[  373.894284]              TPC[arch_cpu_idle+0x84/0xc0] 
O7[arch_cpu_idle+0x70/0xc0] I7[default_idle_call+0x30/0x160] 
RPC[do_idle+0x104/0x1e0]
[  373.894303] rcu: rcu_sched kthread timer wakeup didn't happen for 
15744 jiffies! g5933 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
[  374.097545] rcu:     Possible timer handling issue on cpu=66 
timer-softirq=248
[  374.111434] rcu: rcu_sched kthread starved for 15800 jiffies! g5933 
f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=66
[  374.132103] rcu:     Unless rcu_sched kthread gets sufficient CPU 
time, OOM is now expected behavior.
[  374.149976] rcu: RCU grace-period kthread stack dump:
[  374.160042] task:rcu_sched       state:I stack:26936 pid:15 tgid:15  
   ppid:2      task_flags:0x208040 flags:0x07000000
[  374.182088] Call Trace:
[  374.186950] [<0000000000fd993c>] schedule+0x1c/0x180

  [  374.196844] [<0000000000fe19f0>] schedule_timeout+0x70/0x100
[  374.208132] [<0000000000530064>] rcu_gp_fqs_loop+0x104/0x4e0
[  374.219420] [<0000000000535474>] rcu_gp_kthread+0x134/0x180
[  374.230538] [<00000000004af254>] kthread+0x114/0x160
[  374.240433] [<00000000004060f0>] ret_from_fork+0x24/0x34
[  374.251009] [<0000000000000000>] 0x0
[  374.258131] rcu: Stack dump where RCU GP kthread last ran:
[  374.269126]   CPU[ 66]: TSTATE[0000004411081605] 
TPC[000000000043d524] TNPC[000000000043d528] TASK[swapper/66:0]
[  374.289376]              TPC[arch_cpu_idle+0x84/0xc0] 
O7[arch_cpu_idle+0x70/0xc0] I7[default_idle_call+0x30/0x160] 
RPC[do_idle+0x104/0x1e0]
[  395.314730] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  395.326335] rcu:     3-...!: (260 GPs behind) idle=d8c8/0/0x0 
softirq=1081/1081 fqs=0 (false positive?)
[  395.344552] rcu:     27-...!: (314 GPs behind) idle=5da8/0/0x0 
softirq=284/286 fqs=0 (false positive?)
[  395.362602] rcu:     34-...!: (262 GPs behind) idle=4670/0/0x0 
softirq=524/524 fqs=0 (false positive?)
[  395.380667] rcu:     46-...!: (262 GPs behind) idle=7b00/0/0x0 
softirq=258/259 fqs=0 (false positive?)
[  395.398729] rcu:     (detected by 54, t=5275 jiffies, g=5937, q=96560 
ncpus=128)
[  395.413016]   CPU[  3]: TSTATE[0000004411081605] 
TPC[000000000043d524] TNPC[000000000043d528] TASK[swapper/3:0]
[  395.413022]              TPC[arch_cpu_idle+0x84/0xc0] 
O7[arch_cpu_idle+0x70/0xc0] I7[default_idle_call+0x30/0x160] 
RPC[do_idle+0x104/0x1e0]
[  395.413106]   CPU[ 27]: TSTATE[0000004411081605] 
TPC[000000000043d524] TNPC[000000000043d528] TASK[swapper/27:0]
[  395.413111]              TPC[arch_cpu_idle+0x84/0xc0] 
O7[arch_cpu_idle+0x70/0xc0] I7[default_idle_call+0x30/0x160] 
RPC[do_idle+0x104/0x1e0]
[  395.413178]   CPU[ 34]: TSTATE[0000004411081605] 
TPC[000000000043d524] TNPC[000000000043d528] TASK[swapper/34:0]
[  395.413183]              TPC[arch_cpu_idle+0x84/0xc0] 
O7[arch_cpu_idle+0x70/0xc0] I7[default_idle_call+0x30/0x160] 
RPC[do_idle+0x104/0x1e0]
[  395.413249]   CPU[ 46]: TSTATE[0000004411081605] 
TPC[000000000043d524] TNPC[000000000043d528] TASK[swapper/46:0]
[  395.413254]              TPC[arch_cpu_idle+0x84/0xc0] 
O7[arch_cpu_idle+0x70/0xc0] I7[default_idle_call+0x30/0x160] 
RPC[do_idle+0x104/0x1e0]
[  395.413273] rcu: rcu_sched kthread timer wakeup didn't happen for 
5274 jiffies! g5937 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
[  395.616352] rcu:     Possible timer handling issue on cpu=66 
timer-softirq=248
[  395.630237] rcu: rcu_sched kthread starved for 5330 jiffies! g5937 
f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=66
[  395.650718] rcu:     Unless rcu_sched kthread gets sufficient CPU 
time, OOM is now expected behavior.
[  395.668597] rcu: RCU grace-period kthread stack dump:
[  395.678674] task:rcu_sched       state:I stack:26936 pid:15 tgid:15  
   ppid:2      task_flags:0x208040 flags:0x07000000
[  395.700722] Call Trace:
[  395.705582] [<0000000000fd993c>] schedule+0x1c/0x180
[  395.715474] [<0000000000fe19f0>] schedule_timeout+0x70/0x100
[  395.726758] [<0000000000530064>] rcu_gp_fqs_loop+0x104/0x4e0
[  395.738043] [<0000000000535474>] rcu_gp_kthread+0x134/0x180
[  395.749158] [<00000000004af254>] kthread+0x114/0x160
[  395.759054] [<00000000004060f0>] ret_from_fork+0x24/0x34
[  395.769643] [<0000000000000000>] 0x0
[  395.776763] rcu: Stack dump where RCU GP kthread last ran:
[  395.787741]   CPU[ 66]: TSTATE[0000004411081605] 
TPC[000000000043d524] TNPC[000000000043d528] TASK[swapper/66:0]
[  395.808014]              TPC[arch_cpu_idle+0x84/0xc0] 
O7[arch_cpu_idle+0x70/0xc0] I7[default_idle_call+0x30/0x160] 
RPC[do_idle+0x104/0x1e0]

>
> If that's not possible as the system is unresponsive, then please add
> 'ftrace_dump_on_oops' on the kernel command line or enable it after boot
> in /proc/sys/kernel and let the kernel panic when it hits the hung task
> detector fail.
>
> Thanks,
>
>          tglx
> ---
> --- a/arch/sparc/kernel/time_64.c
> +++ b/arch/sparc/kernel/time_64.c
> @@ -732,8 +732,10 @@ void __irq_entry timer_interrupt(int irq
>       if (unlikely(!evt->event_handler)) {
>           printk(KERN_WARNING
>                  "Spurious SPARC64 timer interrupt on cpu %d\n", cpu);
> -    } else
> +    } else {
> +        trace_printk("Invoking handler %pS\n", evt->event_handler);
>           evt->event_handler(evt);
> +    }
>         irq_exit();
>   --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -248,6 +248,7 @@ static void hung_task_info(struct task_s
>        * accordingly
>        */
>       if (sysctl_hung_task_warnings || hung_task_call_panic) {
> +        tracing_off();
>           if (sysctl_hung_task_warnings > 0)
>               sysctl_hung_task_warnings--;
>           pr_err("INFO: task %s:%d blocked%s for more than %ld 
> seconds.\n",
> --- a/kernel/time/clockevents.c
> +++ b/kernel/time/clockevents.c
> @@ -370,18 +370,22 @@ int clockevents_program_event(struct clo
>           delta = min(delta, (int64_t) dev->max_delta_ns);
>           cycles = ((u64)delta * dev->mult) >> dev->shift;
>           if (!dev->set_next_event((unsigned long) cycles, dev)) {
> +            trace_printk("Successfully programmed %lld %lld\n", 
> expires, delta);
>               dev->next_event_forced = 0;
>               return 0;
>           }
>       }
>   -    if (dev->next_event_forced)
> +    if (dev->next_event_forced) {
> +        trace_printk("Skipping %lld %lld\n", expires, delta);
>           return 0;
> +    }
>         if (dev->set_next_event(dev->min_delta_ticks, dev)) {
>           if (!force || clockevents_program_min_delta(dev))
>               return -ETIME;
>       }
> +    trace_printk("Force programmed min delta %lld %lld\n", expires, 
> delta);
>       dev->next_event_forced = 1;
>       return 0;
>   } 
