From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 04 Sep 2016 05:00:22 +0000
Subject: Re: sparc: bpf_jit: Move four assignments in bpf_jit_compile()
Message-Id: <ec58924c-25d6-e525-fb8a-35bdbf6a8f12@users.sourceforge.net>
List-Id: <sparclinux.vger.kernel.org>
References: <566ABCD9.1060404@users.sourceforge.net>
 <ab4a20b2-16be-c3b2-58a7-fe7db39ab559@users.sourceforge.net>
 <2179bf7c-9878-adf7-da97-2746d5aa3d34@users.sourceforge.net>
 <CAGRGNgWXdzvfL4wdM2uQr7DRbJgCuY0O-jRmSGhqfbPBZGS2Aw@mail.gmail.com>
 <a6afaf8a-837e-6cc3-fdec-3a37f0e731d5@users.sourceforge.net>
 <CAGRGNgUxt+qgiDHQ7qQ3a7QEJ3xZ4rRTW6RN8fTLNK6E6pgWTw@mail.gmail.com>
In-Reply-To: <CAGRGNgUxt+qgiDHQ7qQ3a7QEJ3xZ4rRTW6RN8fTLNK6E6pgWTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julian Calaby <julian.calaby@gmail.com>
Cc: sparclinux <sparclinux@vger.kernel.org>, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Rabin Vincent <rabin@rab.in>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors <kernel-janitors@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

> Does this change improve the resulting binary?

I hope so. - I propose to give the refactorings "Reduce scope of variable"
and "Extract a function" (and the corresponding consequences) another look.


> I.e. does it make it smaller or faster?

It is generally possible that a specific code generation variant will also affect
the run time properties you mentioned.


> Otherwise this change is useless churn - you're making the code more
> complicated, longer and harder to read for practically no benefit.

I imagine that there other reasons you could eventually accept
for this use case, aren't there?

Regards,
Markus
