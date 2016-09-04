From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 04 Sep 2016 07:18:55 +0000
Subject: Re: sparc: bpf_jit: Move four assignments in bpf_jit_compile()
Message-Id: <CAGRGNgVMtZ_dJYSrn+uVTxc6B8Fd+1RZY6dOkDdv9sVALii4vw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a6afaf8a-837e-6cc3-fdec-3a37f0e731d5@users.sourceforge.net>
 <CAGRGNgUxt+qgiDHQ7qQ3a7QEJ3xZ4rRTW6RN8fTLNK6E6pgWTw@mail.gmail.com>
 <ec58924c-25d6-e525-fb8a-35bdbf6a8f12@users.sourceforge.net>
 <20160903.233256.116565014024856604.davem@davemloft.net> <CAGRGNgX1Y2AeaF38Lw1NaM+NvWkmALrVcqx-DL72ot-kcSCmBA@mail.gmail.com>
 <d9e83d28-296e-00bc-a18c-66fca51c3adf@users.sourceforge.net>
In-Reply-To: <d9e83d28-296e-00bc-a18c-66fca51c3adf@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: David Miller <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Rabin Vincent <rabin@rab.in>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel-janitors <kernel-janitors@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

Hi Markus,

On Sun, Sep 4, 2016 at 5:07 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>> I really wish he'd concentrate on the former rather than the latter.
>
> I am on the way for such a software development adventure.
> There are further improvement opportunities to consider besides the main route,
> aren't there?

You're missing the point here. Find something useful to change.

People are going through the kernel finding functions that should be
static for example - this is useful as it provides better
documentation for those functions (static = not used outside this
file) and fixes errors reported by GCC and static code checkers. Those
changes are useful.

Another useful change would be ensuring that every struct that has a
bool member is kzalloc'd instead of kmalloc'd as this eliminates a
possible source of undefined behaviour. (A bool is effectively a u8
with behaviour defined for when that value is 0 or 1, kmalloc'd memory
can have any data in it, therefore it's possible and likely that a
kmalloc'd struct with a bool member will end up with some value for
that member that isn't 0 or 1. kzalloc eliminates this possibility.)

Moving four assignments because you think they might improve stuff is
just annoying people.

>> He's not another Nick Krause.
>
> Are you going to remember me under an other nickname anyhow?

Nick Krause submitted patches that make yours look good. At least yours compile.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
