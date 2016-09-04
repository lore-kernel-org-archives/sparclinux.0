From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 04 Sep 2016 06:44:22 +0000
Subject: Re: sparc: bpf_jit: Move four assignments in bpf_jit_compile()
Message-Id: <CAGRGNgX1Y2AeaF38Lw1NaM+NvWkmALrVcqx-DL72ot-kcSCmBA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a6afaf8a-837e-6cc3-fdec-3a37f0e731d5@users.sourceforge.net>
 <CAGRGNgUxt+qgiDHQ7qQ3a7QEJ3xZ4rRTW6RN8fTLNK6E6pgWTw@mail.gmail.com>
 <ec58924c-25d6-e525-fb8a-35bdbf6a8f12@users.sourceforge.net> <20160903.233256.116565014024856604.davem@davemloft.net>
In-Reply-To: <20160903.233256.116565014024856604.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, sparclinux <sparclinux@vger.kernel.org>, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Rabin Vincent <rabin@rab.in>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel-janitors <kernel-janitors@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

Hi David,

On Sun, Sep 4, 2016 at 4:32 PM, David Miller <davem@davemloft.net> wrote:
>
> Markus, I'm really not going to consider any of these changes.
>
> And your replies to the feedback you were given disappoint me even
> more.
>
> Please don't submit any more sparc patches until you can get you act
> in gear and not waste everyone's time.

In Markus' defence, he does occasionally write okay patches, (for
example the kmalloc(a * b) => kmalloc_array(a, b) changes get my small
tick of approval) however he also submits a lot of patches which are
little more than moving stuff around pointlessly.

I really wish he'd concentrate on the former rather than the latter.

He's not another Nick Krause.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
