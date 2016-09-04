From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 04 Sep 2016 05:16:34 +0000
Subject: Re: sparc: bpf_jit: Move four assignments in bpf_jit_compile()
Message-Id: <CAGRGNgWAx69N81e_9Ay3N2m03ZAa14ckW+62tHZSJ+4oky6VPA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <566ABCD9.1060404@users.sourceforge.net> <ab4a20b2-16be-c3b2-58a7-fe7db39ab559@users.sourceforge.net>
 <2179bf7c-9878-adf7-da97-2746d5aa3d34@users.sourceforge.net>
 <CAGRGNgWXdzvfL4wdM2uQr7DRbJgCuY0O-jRmSGhqfbPBZGS2Aw@mail.gmail.com>
 <a6afaf8a-837e-6cc3-fdec-3a37f0e731d5@users.sourceforge.net>
 <CAGRGNgUxt+qgiDHQ7qQ3a7QEJ3xZ4rRTW6RN8fTLNK6E6pgWTw@mail.gmail.com> <ec58924c-25d6-e525-fb8a-35bdbf6a8f12@users.sourceforge.net>
In-Reply-To: <ec58924c-25d6-e525-fb8a-35bdbf6a8f12@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: sparclinux <sparclinux@vger.kernel.org>, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Rabin Vincent <rabin@rab.in>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors <kernel-janitors@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

Hi Markus,

On Sun, Sep 4, 2016 at 3:00 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>> Does this change improve the resulting binary?
>
> I hope so. - I propose to give the refactorings "Reduce scope of variable"
> and "Extract a function" (and the corresponding consequences) another look.

So you _think_ it does. Come back with real proof.

I must also point out that these sorts of optimisations are things the
compiler does automatically when compiling this code. Therefore it's
highly likely that this change will make absolutely no difference
whatsoever. (And no it won't improve compile speed in any justifiable
way)

>> I.e. does it make it smaller or faster?
>
> It is generally possible that a specific code generation variant will also affect
> the run time properties you mentioned.

It's _possible_? Come back with benchmarks.

I must also point out that this is a "slow path" i.e. as long as it's
not stupidly inefficient, the speed doesn't matter that much. This
change isn't going to improve the speed of this function by any amount
that matters.

>> Otherwise this change is useless churn - you're making the code more
>> complicated, longer and harder to read for practically no benefit.
>
> I imagine that there other reasons you could eventually accept
> for this use case, aren't there?

Unless you have some pretty damn good proof that these changes improve
things, there is absolutely no reason to take them as-is - you are
making the code longer and more difficult to read for no benefit and
wasting everyone's time in the process.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
