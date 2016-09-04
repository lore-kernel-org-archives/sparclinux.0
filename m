From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 04 Sep 2016 05:45:04 +0000
Subject: Re: sparc: bpf_jit: Move four assignments in bpf_jit_compile()
Message-Id: <1af7e987-0233-f972-6c00-6d5e00898188@users.sourceforge.net>
List-Id: <sparclinux.vger.kernel.org>
References: <566ABCD9.1060404@users.sourceforge.net>
 <ab4a20b2-16be-c3b2-58a7-fe7db39ab559@users.sourceforge.net>
 <2179bf7c-9878-adf7-da97-2746d5aa3d34@users.sourceforge.net>
 <CAGRGNgWXdzvfL4wdM2uQr7DRbJgCuY0O-jRmSGhqfbPBZGS2Aw@mail.gmail.com>
 <a6afaf8a-837e-6cc3-fdec-3a37f0e731d5@users.sourceforge.net>
 <CAGRGNgUxt+qgiDHQ7qQ3a7QEJ3xZ4rRTW6RN8fTLNK6E6pgWTw@mail.gmail.com>
 <ec58924c-25d6-e525-fb8a-35bdbf6a8f12@users.sourceforge.net>
 <CAGRGNgWAx69N81e_9Ay3N2m03ZAa14ckW+62tHZSJ+4oky6VPA@mail.gmail.com>
In-Reply-To: <CAGRGNgWAx69N81e_9Ay3N2m03ZAa14ckW+62tHZSJ+4oky6VPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julian Calaby <julian.calaby@gmail.com>
Cc: sparclinux <sparclinux@vger.kernel.org>, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Rabin Vincent <rabin@rab.in>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors <kernel-janitors@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

>> I hope so. - I propose to give the refactorings "Reduce scope of variable"
>> and "Extract a function" (and the corresponding consequences) another look.
> 
> So you _think_ it does. Come back with real proof.

Which test environments would you find acceptable for further clarification?


> I must also point out that these sorts of optimisations are things the
> compiler does automatically when compiling this code.

Do you take this detail for granted?


> Therefore it's highly likely that this change will make absolutely
> no difference whatsoever.

I find this outcome unlikely.


> (And no it won't improve compile speed in any justifiable way)

This was not a goal of my update suggestion for the function "bpf_jit_compile".


>> It is generally possible that a specific code generation variant will also affect
>> the run time properties you mentioned.
> 
> It's _possible_? Come back with benchmarks.

Which code generation variant would be useful to be clarified further?

Should we avoid to compare software things similar to "apples" and "oranges"
(while these fruits can make more fun)?   ;-)


> I must also point out that this is a "slow path" i.e. as long as it's
> not stupidly inefficient, the speed doesn't matter that much.

Can this execution path become warmer (or even "hot") for some other use cases?


> This change isn't going to improve the speed of this function by any amount
> that matters.

This is also possible.


> Unless you have some pretty damn good proof that these changes improve things,
> there is absolutely no reason to take them as-is

Would you care for a better source code structure?


> - you are making the code longer

Yes. - This is true for the suggested update in this function.


> and more difficult to read for no benefit

I proposed specific benefits for this software module.


> and wasting everyone's time in the process.

I assume that a few contributors can take the presented ideas for further considerations.
Will their value evolve a bit more later?

Regards,
Markus
