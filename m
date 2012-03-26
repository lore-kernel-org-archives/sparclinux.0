From: Kautuk Consul <consul.kautuk@gmail.com>
Date: Mon, 26 Mar 2012 15:35:56 +0000
Subject: Re: [PATCH 19/20 v2] sparc/mm/fault_32.c: Port OOM changes to do_sparc_fault
Message-Id: <CAFPAmTT6pcjzi8WsM+r3izreGiuNaK5c4NkDav=6+wFj55QF4Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1332698315-2218-1-git-send-email-consul.kautuk@gmail.com>
	<20120325.150422.2000357641354896689.davem@davemloft.net>
In-Reply-To: <20120325.150422.2000357641354896689.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: paul.gortmaker@windriver.com, mingo@elte.hu, joe@perches.com, a.p.zijlstra@chello.nl, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Mar 25, 2012 at 3:04 PM, David Miller <davem@davemloft.net> wrote:
> From: Kautuk Consul <consul.kautuk@gmail.com>
> Date: Sun, 25 Mar 2012 13:58:35 -0400
>
>> + =A0 =A0 unsigned int flags =3D (FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KI=
LLABLE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (write ? FAULT_FLAG_WRITE : 0));
>
> Still indented wrong, it should be:
>
> =A0 =A0 =A0 =A0unsigned int flags =3D (FAULT_FLAG_ALLOW_RETRY | FAULT_FLA=
G_KILLABLE |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(write ? FAULT=
_FLAG_WRITE : 0));
>
> The second line must have the openning parenthesis line up with
> the column after the openning parenthesis on the first line. =A0Do
> not use only tabs to indent this stuff, line it up properly.
>
> You need to use tabs and spaces to line it up. =A0Use something like
> emacs's C-mode to help you if you can't do it right by hand.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 perf_sw_event(PERF_COUNT_SW_PA=
GE_FAULTS_MAJ,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 1, regs, address);
>
> Still wrong, for the same exact reason.
>
> I went out of my way to reply to your private email (which I usually
> ignore, you should never email developers privately) and you didn't
> even listen to the feedback I gave you.


I use gmail which did not show me the indentation which you wanted.
I understand what you said now and have sent a v3 for this.
