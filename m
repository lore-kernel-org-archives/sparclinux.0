From: Pekka Enberg <penberg@kernel.org>
Date: Tue, 06 May 2014 04:04:16 +0000
Subject: Re: [PATCH] slab: Fix off by one in object max number tests.
Message-Id: <CAOJsxLG2hjY4YLnmT+-uu=5S687z73FD9eRLEeZtRJrA8icBHg@mail.gmail.com>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, Sam Ravnborg <sam@ravnborg.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, sparclinux@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Christoph Lameter <cl@linux.com>

On Tue, May 6, 2014 at 6:32 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, May 5, 2014 at 8:25 PM, David Miller <davem@davemloft.net> wrote:
>>
>>> Sam Ravnborg <sam@ravnborg.org> wrote:
>>>>
>>>> There is a related patch in this area which I think is not yet applied.
>>>>
>>>> See: https://lkml.org/lkml/2014/4/18/28
>>>>
>>>> Maybe this is related.
>>>
>>> Thanks, I'm testing with that patch added as well.
>>
>> I can confirm that this fixes my problems completely.
>
> Ugh. That patch has been out two weeks already. Pekka?

Sorry, I missed that completely.

> I guess I'll apply both patches directly.

Thanks!
