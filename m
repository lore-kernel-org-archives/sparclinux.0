From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 15 Apr 2018 18:16:04 +0000
Subject: Re: [RFC PATCH 0/3] Dealing with the aliases of SI_USER
Message-Id: <CA+55aFw1gmfFH1o+oWMo4TnU5hEczAOiY1g=eMxqYZmy9JqDYw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
 <20180412172051.GK16141@n2100.armlinux.org.uk> <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
 <20180413094211.GN16141@n2100.armlinux.org.uk> <CA+55aFwoThxqUeAZSsMhf--ODyhGkmOENH5R6=4+CuaopFx9eA@mail.gmail.com>
 <20180413170827.GB16308@e103592.cambridge.arm.com> <20180413175407.GO16141@n2100.armlinux.org.uk>
 <CA+55aFyya6B9_aq8ZSrZT-S-BGbpbDgFvDff5z8upDirpcoiHA@mail.gmail.com>
 <20180413184522.GD16308@e103592.cambridge.arm.com> <CA+55aFwMUQbALx60b3JDrTcWVSBS7imS+zCYEMz8NOs=6rE6+A@mail.gmail.com>
 <20180415131206.GR16141@n2100.armlinux.org.uk> <87604sa2fu.fsf_-_@xmission.com>
In-Reply-To: <87604sa2fu.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Martin <Dave.Martin@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dmitry V. Levin" <ldv@altlinux.org>, sparclinux <sparclinux@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, linux-arch <linux-arch@vger.kernel.org>

(

On Sun, Apr 15, 2018 at 8:56 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Would you consider the patchset below for -rc2?

Ugh.

I have an irrational dislike of "clear_siginfo()". It's a nasty broken
interface, which just mis-spells "memset()", and makes it non-obvious
that you could clear it other ways too (eg "kzalloc()" or whatever).

And this series brings in a lot of new users.

Honestly, both "clear_siginfo()" and "copy_siginfo()" are crazy
interfaces. They may have made sense when converting code, but not so
much now.

If we want to have a function that initializes a siginfo, I think it
should _actually_ initialize it, and at least take the two fields that
a siginfo has to have to be valid: si_signo and si_code.

So I'd rather see a patch that does something like this:

  -             clear_siginfo(info);
  -             info->si_signo = sig;
  -             info->si_errno = 0;
  -             info->si_code = SI_USER;
  -             info->si_pid = 0;
  -             info->si_uid = 0;
  +             init_siginfo(info, sig, SI_USER);

which at least makes that function be *worth* something, not just a
bad spelling of memset. It's not just the removal of pointless "set to
zero", it's the whole concept of "this function actually makes a valid
siginfo", which is lacking in the existing function.

(Yeah, yeah, si_errno is "generic" too and always part of a siginfo,
but nobody cares. It's pretty much always set to zero, it would be
stupid to add that interface to the "init_siginfo()" function. So just
clearing it is fine, the one or two places that want to set it to some
silly value can do it themselves).

Then your series would incidentally also:

 (a) make for fewer lines overall, rather than add lines

 (b) make it clear that we always initialize si_code, which now *must*
be a valid value with all the recent siginfo changes.

Hmm?

The other thing we should do is to get rid of the stupid padding.
Right now "struct siginfo" is pointlessly padded to 128 bytes. That is
completely insane, when it's always just zero in the kernel.

So put that _pad[] thing inside #ifndef __KERNEL__, and make
copy_siginfo_to_user() write the padding zeroes when copying to user
space. The reason for the padding is "future expansion", so we do want
to tell the user space that it's maybe up to 128 bytes in size, but if
we don't fill it all, we shouldn't waste time and memory on clearing
the padding internally.

I'm certainly *hoping* nobody depends on the whole 128 bytes in
rt_sigqueueinfo(). In theory you can fill it all (as long as si_code
is negative), but the man-page only says "si_value", and the compat
function doesn't copy any more than that either, so any user that
tries to fill in more than si_value is already broken. In fact, it
might even be worth enforcing that in rt_sigqueueinfo(), just to see
if anybody plays any games..

On x86-64, without the pointless padding, the size of 'struct siginfo'
inside the kernel would be 48 bytes. That's quite a big difference for
something that is often allocated on the kernel stack.

So I'm certainly willing to make those kinds of changes, but let's
make them real *improvements* now, ok? Wasn't that the point of all
the cleanups in the end?

                       Linus
