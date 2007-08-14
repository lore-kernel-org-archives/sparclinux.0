From: "jiaqi zhang" <zation.busy@gmail.com>
Date: Tue, 14 Aug 2007 20:38:53 +0000
Subject: Re: Physical cpu number on UltrasparcT1
Message-Id: <a8e8903d0708141338j311631a2t74a638e589e2dc82@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a8e8903d0708131434j1c1e2b81m5f3fb6e9c6d1a0ab@mail.gmail.com>
In-Reply-To: <a8e8903d0708131434j1c1e2b81m5f3fb6e9c6d1a0ab@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I've checked the ALOM manual and found no useful clues there. If ALOM
knows it, can I simply get the information from ALOM? Or should I have
to ask hypervisor directly?
Since my kernel is 2.6.20, which does not support your multi-core
arrangement for sparc64 yet, it lacks the mdesc files.

Thanks!

On 8/14/07, David Miller <davem@davemloft.net> wrote:
> From: "jiaqi zhang" <zation.busy@gmail.com>
> Date: Tue, 14 Aug 2007 10:51:31 +1200
>
>
> The kernel groups cpus into scheduling groups depending upon
> whether they share execution resources or cache.
>
> You can look at the files under /sys/devices/system/cpu/cpu${ID}/topology/
> to see this information.
>
> This determination is made using the machine description which the
> hypervisor passes on down to the kernel.  It is a binary datastructure
> which, among other things, provides a graph describing the mapping from
> virtual cpus to physical chip resources such as caches and execution
> units.
>
> This datastructure is parsed and managed in arch/sparc64/kernel/mdesc.c,
> in particular you might find mdesc_fill_in_cpu_data() useful.
>
> See?  When you describe what you're trying to accomplish then I can
> give you a useful and coherent answer.
>
