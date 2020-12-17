From: Andreas Larsson <andreas@gaisler.com>
Date: Thu, 17 Dec 2020 15:32:33 +0000
Subject: Re: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
Message-Id: <6a2c250a-2c7e-81c5-705a-5904c0fc91b8@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190307091514.2489338-1-arnd@arndb.de>
 <X9S28TcEXd2zghzp@elver.google.com> <87czzeg5ep.fsf@nanos.tec.linutronix.de>
 <CAK8P3a0LWjNgwm605TM4dKCsn078X7NC3sEfdBSgcMNEocQ5iA@mail.gmail.com>
 <CAJF2gTRLEbBfZJ7Y6UNOMq-cwG5OYRW=+8Pfauz6v6R8ntBjYA@mail.gmail.com>
 <CAK8P3a3+WaQNyJ6Za2qfu6=0mBgU1hApnRXrdp1b1=P7wwyRUg@mail.gmail.com>
 <20201215193800.GA1098247@ravnborg.org>
 <CAK8P3a24eAYjPTw_GvEC5H9nGODjeKCVLSmfpoNSvrzew5BX4Q@mail.gmail.com>
In-Reply-To: <CAK8P3a24eAYjPTw_GvEC5H9nGODjeKCVLSmfpoNSvrzew5BX4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>, Sam Ravnborg <sam@ravnborg.org>
Cc: Guo Ren <guoren@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Nick Desaulniers <ndesaulniers@google.com>, Davidlohr Bueso <dave@stgolabs.net>, Elena Reshetova <elena.reshetova@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, software@gaisler.com

On 2020-12-16 00:24, Arnd Bergmann wrote:
> On Tue, Dec 15, 2020 at 8:38 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>> On Tue, Dec 15, 2020 at 12:26:10PM +0100, Arnd Bergmann wrote:
>>>
>>> - Disable SMP support for sun4m/sun4d. From the historic git
>>>    tree, it's unclear how well this ever worked, and very few machines
>>>    of this class ever existed
>> Yeah, I have collection of sparc32 machines that I played around with
>> once. Including one sun4d that I brought from a friendly Linux fellow in
>> the UK. But somehow I lost interest as this is all very nice machines
>> but not useful for anything real work.
>>
>> I think we would be better served dropping support for sun4m and sun4d
>> from the kernel.
> 
> This seems appropriate as well to me.
> 
>> Last I suggested deleting sun4m/sun4d the argument to keep sun4m was that
>> QEMU supports sun4m - which is a good argument for sun4m. I dunno what
>> would be needed to migrate QEMU to LEON, see below.
> 
> "qemu-system-sparc -M help" shows a "leon3_generic" platform, apparently
> added in 2013. Do you think that would be sufficient?

We have only use QEMU for LEON3 on limited and simpler system
setups. For example the Zephyr SPARC arch + LEON3 BSP port we recently
submitted to the Linux Foundation Zephyr project run their test-suite
successfully on QEMU+LEON3. We will have to look into the QEMU for LEON
and Linux situation.

We mainly use TSIM that is our own high fidelity simulator.


>>> - Mark SMP for LEON as temporarily broken. As I see in the LEON
>>>    patch set, they have changes to enable compare-and-swap-atomic
>>>    instructions unconditionally, as all SMP Leons have those and
>>>    seem to require this support already for other things.
Regarding unconditional compare-and-swap-atomic instructions (CASA) for
LEON. I tried to get those into mainline under the LEON configuration
option but did not get OK for that at that time, with the feedback to do
it dynamically instead. I haven't come around to try to get an updated
patch doing probing instead into mainline yet. If the thought now is to
drop support for SMP for sparc32, maybe we can have the CASA
unconditionally on SMP configured kernels instead. Still we'd like to
have CASA usage even for non-SMP kernels for LEON systems that supports
it.


>> LEON on the other hand could have some nice future. They are right now
>> stuck on an older kernel and someone that was motivated should be able
>> to get LEON4 running on latest upstream.
>> We had it working in the past - but is was around the time I lost my
>> sparc interest and no-one jumped in to move it much more forward.

I would not say that we are stuck on an old kernel. It is rather that
for our official releases we stay on long term support kernels. We still
aim for kernels based on master to work on LEON. Right now we do have a
bit of backlog of things to get into upstream.


> My best guess from the public information I could find on LEON is that
> it keeps shifting away from Linux on LEON to other OSs, and to
> and to Linux on NOEL-V.

On the contrary. Our LEON users shows an increased interest in running
Linux, now that LEON-based systems gains in number of processors,
processor performance and memory. We are adding NOEL as a new processor
line. With NOEL we have a 64-bit architecture. We are not shifting from
LEON to NOEL. LEON is not going away.

>
> So even though the CPU itself will likely have a long life ahead of it
> with LEON5 only a year old, it's unclear how many more updates
> we'll see to the kernel from the current 4.9 based release.

Our latest release was indeed based on 4.9, but we have no plans to stay
there forever. We just tend to select long term support kernels for our
official releases. The next step will be to go to 5.4 if not 5.10.

We recently released a new Linux 4.9 toolchain where we stepped up to
GLIBC 2.31 and GCC 10.2. So we do not consider us stuck at old versions
of any of the involved software.

In addition, non-LTS users are running other mainline kernel versions
as well.


Best regards,

Andreas Larsson
Software Engineer
Cobham Gaisler
