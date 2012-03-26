From: Kautuk Consul <consul.kautuk@gmail.com>
Date: Mon, 26 Mar 2012 15:36:42 +0000
Subject: Re: [PATCH 20/20 v2] sparc/mm/fault_64.c: Port OOM changes to do_sparc64_fault
Message-Id: <CAFPAmTQLVSnujH+yWh+oePLvg1BcaW1LuP3tOWpYhsSRmdQ5JQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1332698348-2253-1-git-send-email-consul.kautuk@gmail.com>
	<20120325.150452.2130364052890102881.davem@davemloft.net>
In-Reply-To: <20120325.150452.2130364052890102881.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: paul.gortmaker@windriver.com, mingo@elte.hu, joe@perches.com, a.p.zijlstra@chello.nl, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Mar 25, 2012 at 3:04 PM, David Miller <davem@davemloft.net> wrote:
> From: Kautuk Consul <consul.kautuk@gmail.com>
> Date: Sun, 25 Mar 2012 13:59:08 -0400
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 perf_sw_event(PERF_COUNT_SW_PA=
GE_FAULTS_MAJ,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 1, regs, address);
>
> Improperly indented still.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 perf_sw_event(PERF_COUNT_SW_PA=
GE_FAULTS_MIN,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 1, regs, address);
>
> Likewise.

I didn't understand what you were saying as I use gmaiil so I could not "se=
e"
what you meant exactly.
I have sent a v3 for this.
