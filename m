From: William Lee Irwin III <wli@holomorphy.com>
Date: Fri, 21 Jan 2005 22:49:57 +0000
Subject: Re: Sparc32 long long division patch
Message-Id: <20050121224957.GQ8896@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <41D1D929.8090004@wp.pl>
In-Reply-To: <41D1D929.8090004@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 28 Dec 2004 23:07:37 +0100 Krzysztof Helt <krzysztof.h1@wp.pl> wrote:
>> I discovered a bug in multiply/division trap code for sun4m CPUs. This
>> bug comes from not quite correct register declaration for inline
>> assembly.

On Fri, Jan 21, 2005 at 02:27:38PM -0800, David S. Miller wrote:
> Good catch Krzysztof.  I've applied your patch to both 2.4.x and 2.6.x
> I think it's still not %100 accurate, and could be cleaned up even
> further.  The only reason this code is the way it is, is so that
> we can generate calls to the library functions with "." prefixes in
> the symbol name which are hard to generate using normal C function
> calls.
> So the idea I have is to just make stubs with C callable names that
> just jump to the real routines.  So we'd have something like this:
[...]
> Then we don't need any of this fancy inline assembler.

I'll hold out for the final version, then.


-- wli
