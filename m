From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Aug 2010 01:31:50 +0000
Subject: Re: [GIT] Sparc
Message-Id: <AANLkTikQ1dGw0aO10_ZwmVEc-JAVhB==3HS7SrWycE49@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100817.180325.104051399.davem@davemloft.net>
In-Reply-To: <20100817.180325.104051399.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Aug 17, 2010 at 6:03 PM, David Miller <davem@davemloft.net> wrote:
>
> Among other things, this fixes the rwsem signedness issue we
> were discussing earlier today.

Your commit message is missing the C rules for hex constants. It says

  "hex constants are unsigned unless explicitly casted or negated."

and that's not true.

The rule is that hex constants are signed _except_ if they don't fit
in a signed.

So with a 32-bit 'int', 0x123 is signed, but 0x80000000 is unsigned.

So the reason (-0x00010000) is signed is _not_ because of the
negation, but simply because 0x00010000 fits in a signed int. So for
example, the constant (-0xf0000000) is still unsigned, despite the
negation.

So to make something signed, you need to either cast it, make sure it
fits in a signed int, use the 'l' postfix (which also makes it long,
of course), or use a decimal representation. So

   #define X 4294901760

is a _signed_ constant with same value as 0xffff0000 (but it's "signed
long", because the rules for decimal numbers and hex numbers are
different: a decimal number is always signed and because it doesn't
fit in 'int' it will extend to 'long'. A hex number is first done as
unsigned, and only extended to long if it doesn't fit in that.

To make things _really_ confused, sometimes the types actually depend
on whether you're compiling with the c90 standards. A decimal constant
is _always_ signed in traditional C - it goes from 'int' to 'long',
and stays 'long' even if it doesn't fit (ie with a 32-bit long,
2147483648 is of type 'long' even though it doesn't fit in 'long' and
is negative). But in c90, it does from 'int' to 'long' to 'unsigned
long'.

Or maybe it was the other way around. I forget.

Confused yet?

The basic rule becomes: never _ever_ overflow 'int' in a constant,
without specifying the exact type you want. That way you avoid all the
subtle cases.

                     Linus
