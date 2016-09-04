From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 04 Sep 2016 05:59:39 +0000
Subject: Re: sparc: bpf_jit: Move four assignments in bpf_jit_compile()
Message-Id: <CAGRGNgWgf--hWusUadBQWeC64Rt3srwGqxLLdLzDv1dMXC_kxw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <566ABCD9.1060404@users.sourceforge.net> <ab4a20b2-16be-c3b2-58a7-fe7db39ab559@users.sourceforge.net>
 <2179bf7c-9878-adf7-da97-2746d5aa3d34@users.sourceforge.net>
 <CAGRGNgWXdzvfL4wdM2uQr7DRbJgCuY0O-jRmSGhqfbPBZGS2Aw@mail.gmail.com>
 <a6afaf8a-837e-6cc3-fdec-3a37f0e731d5@users.sourceforge.net>
 <CAGRGNgUxt+qgiDHQ7qQ3a7QEJ3xZ4rRTW6RN8fTLNK6E6pgWTw@mail.gmail.com>
 <ec58924c-25d6-e525-fb8a-35bdbf6a8f12@users.sourceforge.net>
 <CAGRGNgWAx69N81e_9Ay3N2m03ZAa14ckW+62tHZSJ+4oky6VPA@mail.gmail.com> <1af7e987-0233-f972-6c00-6d5e00898188@users.sourceforge.net>
In-Reply-To: <1af7e987-0233-f972-6c00-6d5e00898188@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: sparclinux <sparclinux@vger.kernel.org>, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Rabin Vincent <rabin@rab.in>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors <kernel-janitors@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

Hi Markus,

On Sun, Sep 4, 2016 at 3:45 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>>> I hope so. - I propose to give the refactorings "Reduce scope of variable"
>>> and "Extract a function" (and the corresponding consequences) another look.
>>
>> So you _think_ it does. Come back with real proof.
>
> Which test environments would you find acceptable for further clarification?

Compiling it on GCC for Sparc, obviously.

>> I must also point out that these sorts of optimisations are things the
>> compiler does automatically when compiling this code.
>
> Do you take this detail for granted?

I trust that the GCC developers have done their work well.

>> Therefore it's highly likely that this change will make absolutely
>> no difference whatsoever.
>
> I find this outcome unlikely.

Then provide proof.

>> (And no it won't improve compile speed in any justifiable way)
>
> This was not a goal of my update suggestion for the function "bpf_jit_compile".

I'm looking for some glimmer of usefullness in this patch. I'm not seeing any.

>>> It is generally possible that a specific code generation variant will also affect
>>> the run time properties you mentioned.
>>
>> It's _possible_? Come back with benchmarks.
>
> Which code generation variant would be useful to be clarified further?
>
> Should we avoid to compare software things similar to "apples" and "oranges"
> (while these fruits can make more fun)?   ;-)

Write a benchmark that exercises this function. Measure the time it
took without this change, measure the time it took with this change,
is there a difference.

You cannot expect people to take you seriously if you're proposing
performance changes without any actual ability or interest in
producing performance related data to go along with them.

>> I must also point out that this is a "slow path" i.e. as long as it's
>> not stupidly inefficient, the speed doesn't matter that much.
>
> Can this execution path become warmer (or even "hot") for some other use cases?

That is for you to prove.

>> This change isn't going to improve the speed of this function by any amount
>> that matters.
>
> This is also possible.
>
>
>> Unless you have some pretty damn good proof that these changes improve things,
>> there is absolutely no reason to take them as-is
>
> Would you care for a better source code structure?

You're essentially saying "I think doing things this way is better"
and providing _nothing_ else. I think that things are perfectly fine
the way they are. Convince me with data or something else. Was this
suggested by some expert? Is this part of some big tree-wide effort to
do this that was started by some expert? Did someone do this to some
other driver and you're applying the same fix elsewhere?

>> - you are making the code longer
>
> Yes. - This is true for the suggested update in this function.
>
>
>> and more difficult to read for no benefit
>
> I proposed specific benefits for this software module.

What benefits? You have not proved that this change produces any
useful benefits.

>> and wasting everyone's time in the process.
>
> I assume that a few contributors can take the presented ideas for further considerations.
> Will their value evolve a bit more later?

I am subscribed to four fairly high traffic mailing lists and I read
hundreds of patches each week. You are the only person proposing
changes like these ones as you are (as far as I know) the only person
who thinks they have any value.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
