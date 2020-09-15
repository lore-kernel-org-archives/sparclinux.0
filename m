From: Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 15 Sep 2020 02:49:17 +0000
Subject: Re: [PATCH v2 3/4] sparc64: remove mm_cpumask clearing to fix kthread_use_mm race
Message-Id: <1600138100.0flxk0qjzs.astroid@bobo.none>
List-Id: <sparclinux.vger.kernel.org>
References: <20200914045219.3736466-1-npiggin@gmail.com>
        <20200914045219.3736466-4-npiggin@gmail.com>
        <1600066040.vnmz9nxhwt.astroid@bobo.none>
        <CADxRZqxkB9tzO+nf56vFfvdYBooo1rqEbst=QGZQJA3jWhKLYw@mail.gmail.com>
In-Reply-To: <CADxRZqxkB9tzO+nf56vFfvdYBooo1rqEbst=QGZQJA3jWhKLYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatoly Pugachev <matorola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>, "David S . Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, Peter Zijlstra <peterz@infradead.org>, Sparc kernel list <sparclinux@vger.kernel.org>

Excerpts from Anatoly Pugachev's message of September 14, 2020 8:23 pm:
> On Mon, Sep 14, 2020 at 10:00 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> Excerpts from Nicholas Piggin's message of September 14, 2020 2:52 pm:
>>
>> [...]
>>
>> > The basic fix for sparc64 is to remove its mm_cpumask clearing code. The
>> > optimisation could be effectively restored by sending IPIs to mm_cpumask
>> > members and having them remove themselves from mm_cpumask. This is more
>> > tricky so I leave it as an exercise for someone with a sparc64 SMP.
>> > powerpc has a (currently similarly broken) example.
>>
>> So this compiles and boots on qemu, but qemu does not support any
>> sparc64 machines with SMP. Attempting some simple hacks doesn't get
>> me far because openbios isn't populating an SMP device tree, which
>> blows up everywhere.
>>
>> The patch is _relatively_ simple, hopefully it shouldn't explode, so
>> it's probably ready for testing on real SMP hardware, if someone has
>> a few cycles.
> 
> Nick,
> 
> applied this patch to over 'v5.9-rc5' tag , used my test VM (ldom)
> with 32 vcpus.
> Machine boot, stress-ng test ( run as
> "stress-ng --cpu 8 --io 8 --vm 8 --vm-bytes 2G --fork 8 --timeout 15m" )
> finishes without errors.
> 

Thank you very much Anatoly.

Thanks,
Nick
