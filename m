From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 17 Nov 2018 03:51:55 +0000
Subject: Re: [PATCH net-next 0/6] Remove VLAN.CFI overload
Message-Id: <CAADnVQKzo_85bUPXnaqds0MxzrOu_BJwnZx25CbsNrjV=DHC3w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl> <20181110.134758.693752342395888727.davem@davemloft.net>
In-Reply-To: <20181110.134758.693752342395888727.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "David S. Miller" <davem@davemloft.net>
Cc: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Network Development <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Daniel Borkmann <daniel@iogearbox.net>, jhogan@kernel.org, linux-mips <linux-mips@linux-mips.org>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, paul.burton@mips.com, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org

On Sat, Nov 10, 2018 at 1:48 PM David Miller <davem@davemloft.net> wrote:
>
> From: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Date: Sat, 10 Nov 2018 19:58:29 +0100
>
> > Fix BPF code/JITs to allow for separate VLAN_PRESENT flag
> > storage and finally move the flag to separate storage in skbuff.
> >
> > This is final step to make CLAN.CFI transparent to core Linux
> > networking stack.
> >
> > An #ifdef is introduced temporarily to mark fragments masking
> > VLAN_TAG_PRESENT. This is removed altogether in the final patch.
>
> Daniel and Alexei, please review.

It was on my todo list.
All reviews got delayed due to LPC.

I guess too late to comment now.
Anyhow I don't see the value in this patch set.
Seems like code churn.

Michal, could you please explain the reasoning?
