From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 13 Feb 2011 23:22:13 +0000
Subject: Re: Sparc Stress Testing
Message-Id: <AANLkTinHq=qvc9rCJfqNC+F95HY=3uAsE0auEL38pJ8i@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <AANLkTi=A-kVN8Z6oaonp-8xVO3E07oHRbJaf_GW=wUGR@mail.gmail.com>
In-Reply-To: <AANLkTi=A-kVN8Z6oaonp-8xVO3E07oHRbJaf_GW=wUGR@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Bernhard,

[Re-adding CCs]

On Sat, Feb 12, 2011 at 02:02, Bernhard R. Link <brlink@debian.org> wrote:
> * Julian Calaby <julian.calaby@gmail.com> [110209 23:43]:
>> I'm using my Ultra 1e with Debian Testing as a starting point before
>> moving on to newer kernels (it's running a Debian patched 2.6.32)
>
> On my Ultra I have some lock-up interestingly every time there is a new
> libc package to upgrade (Though perhaps it needs some other upgrade
> first because after an reboot it can complete). As this machine has two
> processors, I see something in syslog about one kernel thread hanging
> somewhere but can still use the second to shut it down (though
> everything including a sync hangs, so it's no clean shutdown).

I haven't experienced that, but it could be a SMP related issue - I
only have UP boxes.

I would suspect that this is a bug in libc, but it could be perfectly
reasonable code in libc tickling some obscure bug in the sparc64 SMP
code.

> I don't know if that helps you or is something unrelated, just as little
> additional point of information.

I suspect that your bug is different to mine - but that said, they
symptoms match up enough that it *could* be the same issue. That said,
it will be an absolute pain to debug. Hopefully I can debug it and we
can make some form of fix.

Does anyone have any tips for debugging hard lockups on Sparc? Please
note that I *don't* have a monitor for the box and am currently
working over a serial console.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
