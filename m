From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 06 May 2014 03:46:32 +0000
Subject: Re: [PATCH] slab: Fix off by one in object max number tests.
Message-Id: <CA+55aFwi7YMSt2k+yES=6HetDxq0aQYSxdmmdbvbn6L9LzE3NQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20140505.165756.1229178386133288960.davem@davemloft.net>
	<20140505210507.GA5130@ravnborg.org>
	<20140505.170855.814445464231092040.davem@davemloft.net>
	<20140505.232550.1139149215179650645.davem@davemloft.net>
	<CA+55aFxSAy2ePfNzFyb7rQ+M6UFxW9rHCMEcQaVbc5zVeNAn-g@mail.gmail.com>
In-Reply-To: <CA+55aFxSAy2ePfNzFyb7rQ+M6UFxW9rHCMEcQaVbc5zVeNAn-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, sparclinux@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>

On Mon, May 5, 2014 at 8:32 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I guess I'll apply both patches directly.

Applied and pushed out. Davem, I hope this means current -git works
for you on sparc64 again?

                Linus
