From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 15 Feb 2005 20:01:12 +0000
Subject: Re: FPU context switching fix for SMP
Message-Id: <20050215200112.GZ13009@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <41f753cabb795@wp.pl>
In-Reply-To: <41f753cabb795@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Feb 15, 2005 at 09:40:57AM -0800, David S. Miller wrote:
> I've modified your patch to only do this in the SMP case.
> Here is how the two mechanisms work:
[...]
> The SMP case works in that each thread, when scheduled(), has
> it's PSR_EF flag cleared.
> This fork() bug takes away that invariant, which is why the
> problems arose.
> Thanks a lot Krzysztof.

Looks like you got this one wrapped up before I figured out what was
going on.

Thanks.


-- wli
