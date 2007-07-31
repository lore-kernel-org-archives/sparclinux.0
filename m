From: "Ollie Wild" <aaw@google.com>
Date: Tue, 31 Jul 2007 05:10:43 +0000
Subject: Re: [SPARC32] NULL pointer derefference
Message-Id: <65dd6fd50707302210y5b79a70di58eb2d46f3958025@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707300301340.32210@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707300301340.32210@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, wli@holomorphy.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, davem@davemloft.net

On 7/29/07, Mark Fortescue <mark@mtfhpc.demon.co.uk> wrote:
> Hi All,
>
> Unfortunatly Sparc32 sun4c low level memory management apears to be
> incompatible with commit b6a2fea39318e43fee84fa7b0b90d68bed92d2ba
> mm: variable length argument support.

I feel like I ought to help out with this since it's my change which
broke things, but I don't have access to a Sparc32 box.  Does anyone
have a remotely rebootable machine I can use?

Ollie
