From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Date: Sun, 04 Sep 2016 19:33:43 +0000
Subject: Re: [PATCH 2/4] sparc: bpf_jit: Move four assignments in bpf_jit_compile()
Message-Id: <87d1kjo3xk.fsf@miraculix.mork.no>
List-Id: <sparclinux.vger.kernel.org>
References: <566ABCD9.1060404@users.sourceforge.net>
        <ab4a20b2-16be-c3b2-58a7-fe7db39ab559@users.sourceforge.net>
        <2179bf7c-9878-adf7-da97-2746d5aa3d34@users.sourceforge.net>
        <CAGRGNgWXdzvfL4wdM2uQr7DRbJgCuY0O-jRmSGhqfbPBZGS2Aw@mail.gmail.com>
        <a6afaf8a-837e-6cc3-fdec-3a37f0e731d5@users.sourceforge.net>
        <CAGRGNgUxt+qgiDHQ7qQ3a7QEJ3xZ4rRTW6RN8fTLNK6E6pgWTw@mail.gmail.com>
In-Reply-To: <CAGRGNgUxt+qgiDHQ7qQ3a7QEJ3xZ4rRTW6RN8fTLNK6E6pgWTw@mail.gmail.com>
        (Julian Calaby's message of "Sun, 4 Sep 2016 14:44:42 +1000")
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Julian Calaby <julian.calaby@gmail.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, sparclinux <sparclinux@vger.kernel.org>, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Rabin Vincent <rabin@rab.in>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors <kernel-janitors@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

Julian Calaby <julian.calaby@gmail.com> writes:

> Otherwise this change is useless churn - you're making the code more
> complicated, longer and harder to read for practically no benefit.

He has been doing that for years now. And wasted maintainer resources
along the way, discussing all the pointless churn.  There are zero
indications that this will ever change from his side.

Do not feed.


Bj=C3=B8rn
