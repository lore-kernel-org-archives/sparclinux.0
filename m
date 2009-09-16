From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Sep 2009 11:42:20 +0000
Subject: Re: [PATCH 0/3] /proc/kmem cleanups and hwpoison bits
Message-Id: <10f740e80909160442w470f70cao28a3b6de3e5689b4@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090915021851.168285585@intel.com>
	 <20090915120939.bcc571e1.kamezawa.hiroyu@jp.fujitsu.com>
	 <20090915082200.GA2588@localhost>
	 <Pine.LNX.4.64.0909151057020.26095@sister.anvils>
	 <10f740e80909160201l4834369s75e63fe8df0991aa@mail.gmail.com>
	 <Pine.LNX.4.64.0909161211100.12659@sister.anvils>
In-Reply-To: <Pine.LNX.4.64.0909161211100.12659@sister.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Cc: Wu Fengguang <fengguang.wu@intel.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Andrew Morton <akpm@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>, Nick Piggin <npiggin@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-m68k@vger.kernel.org, sparclinux@vger.kernel.org

On Wed, Sep 16, 2009 at 13:26, Hugh Dickins <hugh.dickins@tiscali.co.uk> wr=
ote:
> On Wed, 16 Sep 2009, Geert Uytterhoeven wrote:
>> On Tue, Sep 15, 2009 at 12:16, Hugh Dickins <hugh.dickins@tiscali.co.uk>=
 wrote:
>> > Warning: it may be rubbish, it may just be a hack which appeared to
>> > work for me the last time I tried, on a particular address range of a
>> > particular set of configurations of a particular set of architectures
>> > (x86_32, x86_64, powerpc64). =C2=A0I've never thought it through enoug=
h to
>> > consider submitting, but it _might_ contain something useful for you
>> > to factor into your own efforts.
>> >
>> > Sorry for chucking it over the wall to you in this way, but I guess
>> > that's better than just sitting quietly on it for a few more years.
>> >
>> > Certainly-Not-Signed-off-by: Hugh Dickins <hugh.dickins@tiscali.co.uk>
>
> I think that gives a good idea of the status of this patch:
> I'm not making any policy decisions here or submitting to any tree.

OK, that was my understanding, too.

But I thought it would hurt to verify. You never know who's gonna take
your patch and (try to) sneak it in ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
							    -- Linus Torvalds
