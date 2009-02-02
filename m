From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Mon, 02 Feb 2009 14:27:57 +0000
Subject: Re: Sunfire V880 and 480R 2.6.27.x startup hangs
Message-Id: <20090202142757.GB4824@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jan 30, 2009 at 04:00:10PM -0800, David Miller wrote:
> > [   47.553935] calling  of_bus_driver_init+0x0/0x12c
> > [   47.610180] Setting up of bus
> > [   47.645596] In bus_register().
> > [   47.682056] Doing kobject_set_name()
> > [   47.724764] kset_register()
> 
> I suspect it's hanging in uevent generation, let's verify that.
> Something really weird is going on in your box, I wonder if the bug is
> surfacing because of all of the non-standard options you have enabled
> in your build such as cgroups and stuff like that.

I CC this to the debian sparc people, as the config is derived from
their default sparc kernel config. If I remember correctly, I only used
"make oldconfig" to get to the newer kernel. Maybe one of those guys can
comment on the sparc configuration choices.

I was curious, so I took vanilla kernel 2.6.27.13 from the net, 
did a "make menuconfig" with only saving (not changeing anything) the config.
This config I will put on: 
http://www.iwr.uni-heidelberg.de/ftp/linux/sparc-boot/config-2.6.27.13-20090202.txt/config-2.6.27.13-20090202.txt

> Anyways, add this patch on top of your tree and please send the tail
> of the new output.

Here is the output with all patches and that default build of 2.6.27.13:

In bus_register().
Doing kobject_set_name()
kset_register()
kset_register: kset_init()
kset_register: kset_add_internal()
kset_register: kobject_uevent()
[halt sent]
[halt sent]
[halt sent]
[halt sent]

> One thing you might want to try to do when it hangs is go:
> 
> 1) Send a 'break' over the console then immediately type '8'.
>    This will increase the kernel log level.
> 
> 2) Send a 'break' then 'p', this will dump the current cpu's
>    registers.
> 
> 3) Send a 'break' then 'y', this will give a brief backtrace
>    on all cpus.
> 
> 4) Send a 'break' then 't', this will dump the state of all
>    processes on the system.
> 
> Unfortunately, none of those will work if the cpu handling console
> interrupts has cpu interrupts disabled for whatever reason :-/ But it
> is definitely worth a try.

Tried, but as you feared, no output was produced (see above).
Any further ideas ?
If time permits, I probably should start compiling all kernels from 2.6.26.5
on to find the first non working kernel.

Thanks, Hermann

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
