From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 16 Apr 2018 02:03:32 +0000
Subject: Re: [RFC PATCH 0/3] Dealing with the aliases of SI_USER
Message-Id: <87tvsb29hn.fsf@xmission.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
        <20180412172051.GK16141@n2100.armlinux.org.uk>
        <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
        <20180413094211.GN16141@n2100.armlinux.org.uk>
        <CA+55aFwoThxqUeAZSsMhf--ODyhGkmOENH5R6=4+CuaopFx9eA@mail.gmail.com>
        <20180413170827.GB16308@e103592.cambridge.arm.com>
        <20180413175407.GO16141@n2100.armlinux.org.uk>
        <CA+55aFyya6B9_aq8ZSrZT-S-BGbpbDgFvDff5z8upDirpcoiHA@mail.gmail.com>
        <20180413184522.GD16308@e103592.cambridge.arm.com>
        <CA+55aFwMUQbALx60b3JDrTcWVSBS7imS+zCYEMz8NOs=6rE6+A@mail.gmail.com>
        <20180415131206.GR16141@n2100.armlinux.org.uk>
        <87604sa2fu.fsf_-_@xmission.com>
        <CA+55aFw1gmfFH1o+oWMo4TnU5hEczAOiY1g=eMxqYZmy9JqDYw@mail.gmail.com>
In-Reply-To: <CA+55aFw1gmfFH1o+oWMo4TnU5hEczAOiY1g=eMxqYZmy9JqDYw@mail.gmail.com>
        (Linus Torvalds's message of "Sun, 15 Apr 2018 11:16:04 -0700")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dmitry V. Levin" <ldv@altlinux.org>, sparclinux <sparclinux@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, linux-arch <linux-arch@vger.kernel.org>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> (
>
> On Sun, Apr 15, 2018 at 8:56 AM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> Would you consider the patchset below for -rc2?
>
> Ugh.

The point of this series is to squash the potential for regressions even
from the weird broken code that fills in fields for si_code 0 that do
not match SI_USER.

The copy_siginfo_to_user32 never handled that so we don't need to worry
about that.  All of the signals that abuse si_code 0 go through
force_sig_info so signalfd can not catch them.  Which means that only
copy_siginfo_to_user needs to be worried about.

Last time I was benchmarking I could not see a difference between
copying the entire siginfo and only a small part so I don't see
the point of optimizing now.

For an actual cleanup I intend to go farther than you are proposing and
convert everthing to the set of helper functions I have added to
kernel/signal.c force_sig_fault, force_sig_mceerr, force_sig_bnderr,
force_sig_pkuerr.

When I am done there will be maybe 5 instances of clear_siginfo outside
of those helper functions.  At which point I won't care if we remove
clear_siginfo and just use memset.  That is a real improvement
that looks something like: "105 files changed, 933 insertions(+), 1698 deletions(-)"
That is my end goal with all of this.

You complained to me about regressions and you are right with the
current handling of FPE_FIXME TRAP_FIXME the code is not bug compatible
with old versions of linux, and people have noticed.

What this patchset represents is the bare minimum needed to convert
copy_siginfo_to_user to a copy_to_user, and remove the possibility
of regressions.

To that end I need to ensure every struct siginfo in the entire
kernel is memset to 0.  A structure initializer is absolutely
not enough.  So I don't mind people thinking clear_siginfo is necessary.


To that end clear_siginfo where it does not take the size of
struct siginfo as a parameter is much less suceptible to typos,
and allows me to ensure every instance of struct siginfo is fully
initialized.

I fully intend to remove practically every instance of struct siginfo
from the architecture specific code, and use the aforementioned helpers.
The trouble is that some of the architecture code need refactoring
for that to happen.  Even your proposed init_siginfo can't be widely
used as a common pattern is to fill in siginfo partially in the
code with si_code and si_signo being filled in almost last.

So in short.  I intend to remove most of these clear_siginfo calls when
I remove the siginfos later.  This series is focused on making
copy_siginfo_to_user simple enough we don't need to use siginfo_layout,
and thus can be fully backwards compatibile with ourselves and we won't
need to worry about regressions.  I have aimed to keep this simple
enough we can merge this after -rc1 because we don't want regressions.

Eric

ps.  I intend to place this change first in my series wether or not it makes
it into -rc2 so that I can be certain we remove any possible regressions
in behavior on the buggy architectures.  Then I can take my time and
ensure the non-trivial changes of refactoring etc are done carefully so
I don't introduce other bugs.  I need that so I can sleep at night.

pps.  I can look at some of your other suggestions but cleverness leads
to regressions, and if you are going to complain at me harshly when I
have been being careful and taking things seriously I am not
particularly willing to take unnecessary chances.
