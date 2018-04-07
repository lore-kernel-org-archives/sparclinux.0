From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 07 Apr 2018 21:37:24 +0000
Subject: Re: [git pull] sparc syscall stuff
Message-Id: <CA+55aFyzdWyGZoczjCQE0rK1Bp9fq54DHNv-TqEeBvZ-C00VtQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180407204414.GC30522@ZenIV.linux.org.uk>
In-Reply-To: <20180407204414.GC30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>

On Sat, Apr 7, 2018 at 1:44 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Conflicts in arch/sparc/kernel/sys_sparc32.c are not hard to resolve,
> but keep in mind that casts to u64 are needed there.  I'd pushed a variant of
> resolution into #test-merge.

You say "keep in mind that casts to u64 are needed there", but then
you seem to be missing them yourself in your test merge (see
[f]truncate64).

I only noticed because I decided to check my merge against yours. I
strive to always do the merge resolution, but if people give me a test
merge, I then double-check against it after-the-fack.

Hmm?

           Linus
