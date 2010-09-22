From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Sep 2010 19:08:53 +0000
Subject: Re: [GIT] Sparc
Message-Id: <AANLkTi=pJUKRUQhpcVV8XAJF+BO1440v1Py5Opr34DR1@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100922.111019.200357319.davem@davemloft.net>
 <20100922183200.GC19804@ZenIV.linux.org.uk> <AANLkTi=DWk2_=wMqcM1jgJEuNRj_ni2OkM3osYCUg57Y@mail.gmail.com>
 <20100922185328.GD19804@ZenIV.linux.org.uk>
In-Reply-To: <20100922185328.GD19804@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Miller <davem@davemloft.net>, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 22, 2010 at 11:53 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Um, no. =A0You've *already* called get_signal_to_deliver(). =A0There had =
been
> no SIGSEGV in sight. =A0You happily went on to set a sigframe for e.g.
> SIGHUP, but ran out of stack. =A0At that point you get force_sigsegv()
> from handle_signal(). =A0_NOW_ you have a pending SIGSEGV

Ahh. Ok. Different case from the one I thought you were worried about.
And yeah, I guess that one does require us to mess with the low-level
asm code (although I do wonder if we could not make the whole
do_notify_resume + reschedule code be generic C code - it's a lot of
duplicated subtle asm as it is).

                   Linus
