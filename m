From: Nick Alcock <nix@esperi.org.uk>
Date: Fri, 27 May 2016 13:43:01 +0000
Subject: Re: [4.1.x -- 4.6.x and probably HEAD] Reproducible unprivileged panic/TLB BUG on sparc via a stack-
Message-Id: <87pos739cq.fsf@esperi.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <87fut34unx.fsf@esperi.org.uk> <87twhj3ag0.fsf@esperi.org.uk>
	<33bce6ca-696c-9ec4-2567-83fed24323c3@physik.fu-berlin.de>
In-Reply-To: <33bce6ca-696c-9ec4-2567-83fed24323c3@physik.fu-berlin.de> (John
	Paul Adrian Glaubitz's message of "Fri, 27 May 2016 15:34:32 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org, Sparc kernel list <sparclinux@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Florian Weimer <fweimer@redhat.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>

On 27 May 2016, John Paul Adrian Glaubitz outgrape:

> Hi Nick!
>
> On 05/27/2016 03:19 PM, Nick Alcock wrote:
>> So I've been working on a patch series (see below) that applies GCC's
>> -fstack-protector{-all,-strong} to almost all of glibc bar the dynamic
>> linker. In trying to upstream it, one review commenter queried one
>> SPARC-specific patch in the series; the absence of this patch triggers a
>> BUG in the SPARC kernel when glibc is tested as an unprivileged user, on
>> all versions tested from Oracle UEK 4.1 right up to 4.6.0, at least on
>> the ldoms I have access to and presumably on bare hardware too.
>
> I apologize for hijacking this thread but since you are mentioning glibc,
> there are actually a couple of tests in the glibc testsuite [1].

At least one of those failures is spurious:

FAIL: nptl/tst-cond11
original exit status 1
clock = 0
Timed out: killed the child process

You want to pass in a higher TIMEOUTFACTOR to the make check run, and
that problem at least should go away. (The TIMEOUTFACTOR you need
depends on how sluggish your test machine is.)
