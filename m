From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 19 Aug 2004 14:12:25 +0000
Subject: Re: Sun4d progress
Message-Id: <20040819141225.GN11200@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.53.0408182135050.391@mailgate.netunix.com>
In-Reply-To: <Pine.LNX.4.53.0408182135050.391@mailgate.netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Aug 18, 2004 at 10:57:47PM +0100, C.Newport wrote:
>> Something odd is going on - Thomas claimed that 2.4.23-pre5 booted but
>> was unstable, which I cannot achieve. Maybe our environments are 
>> different, but I have built this 4 times with 2.4.22 and 2.4.27 on both
>> old and new compilers and the result is consistent. Maybe Thomas had
>> applied some other patch before these ?.

On Thu, Aug 19, 2004 at 02:47:17PM +0200, Thomas Bogendoerfer wrote:
> hmm, thinking about it, there is one hunk I usually throw out of that
> patch:
[...]
> Without that gcc 3.0.4 generates instructions, which btfixup couldn't
> resolve. I suspect there are some compiler troubles left, because the
> images I've build with gcc 3.3.3 aren't even working on my SS20 last
> time I tried ...

Okay, what gcc/binutils is everyone using and can we start slinging
binaries compiled from the same kernel compiled by different gcc's
around so I can diagnose this? Thanks.


-- wli
