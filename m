From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 28 Dec 2004 22:18:28 +0000
Subject: Re: Sparc32 long long division patch
Message-Id: <20041228221828.GL771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <41D1D929.8090004@wp.pl>
In-Reply-To: <41D1D929.8090004@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Dec 28, 2004 at 11:07:37PM +0100, Krzysztof Helt wrote:
> I discovered a bug in multiply/division trap code for sun4m CPUs. This
> bug comes from not quite correct register declaration for inline
> assembly.  According to GCC manual , it is not enough to declare a
> variable (register) as output only if it is an input variable as well. A
> special definitions "0" to "9" should match input variables and output
> variables. Due to this, GCC produced incorrect assembly code for muldiv
> trap function and division results were incorrect. The attached patch
> fixes this. I attached also a small program to test this bug.

Wow, I'm going to have to look at the generated assembly.

I'll send this along to marcelo and akpm later on today.


-- wli
