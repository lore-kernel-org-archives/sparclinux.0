From: David Miller <davem@davemloft.net>
Date: Tue, 06 May 2014 03:48:06 +0000
Subject: Re: [PATCH] slab: Fix off by one in object max number tests.
Message-Id: <20140505.234806.682722563142395714.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140505.232550.1139149215179650645.davem@davemloft.net>
	<CA+55aFxSAy2ePfNzFyb7rQ+M6UFxW9rHCMEcQaVbc5zVeNAn-g@mail.gmail.com>
	<CA+55aFwi7YMSt2k+yES=6HetDxq0aQYSxdmmdbvbn6L9LzE3NQ@mail.gmail.com>
In-Reply-To: <CA+55aFwi7YMSt2k+yES=6HetDxq0aQYSxdmmdbvbn6L9LzE3NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com, sparclinux@vger.kernel.org, hannes@cmpxchg.org, cl@linux.com, penberg@kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 May 2014 20:46:32 -0700

> On Mon, May 5, 2014 at 8:32 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I guess I'll apply both patches directly.
> 
> Applied and pushed out. Davem, I hope this means current -git works
> for you on sparc64 again?

Yes it absoultely should, and I'll double check to make sure.
