From: Denys Vlasenko <vda.linux@googlemail.com>
Date: Wed, 25 Jun 2008 15:24:57 +0000
Subject: Re: [3/10 PATCH] inline wake_up_bit
Message-Id: <200806251724.57689.vda.linux@googlemail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806240136200.27784@engineering.redhat.com> <200806251617.40871.vda.linux@googlemail.com> <Pine.LNX.4.64.0806251031330.7542@engineering.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0806251031330.7542@engineering.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, davem@davemloft.net

On Wednesday 25 June 2008 16:36, Mikulas Patocka wrote:
> > On Tuesday 24 June 2008 07:57, Mikulas Patocka wrote:
> >> Inline wake_up_bit. The function just pases arguments around.
> >>
> >> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> >>
> >>   int __wait_on_bit_lock(wait_queue_head_t *, struct wait_bit_queue *, int (*)(void *), unsigned);
> >> -void wake_up_bit(void *, int);
> >>   int out_of_line_wait_on_bit(void *, int, int (*)(void *), unsigned);
> >
> >> +static __always_inline void wake_up_bit(void *word, int bit)
> >> +{
> >> +	__wake_up_bit(bit_waitqueue(word, bit), word, bit);
> >> +}
> >
> > So now every call to wake_up_bit(word, bit) now is converted to:
> >
> > __wake_up_bit(bit_waitqueue(word, bit), word, bit);
> >
> > which is in turn converted to (looking into your next patch):
> >
> > {
> >       wait_queue_head_t *wq = bit_waitqueue(word, bit);
> >       struct wait_bit_key key = __WAIT_BIT_KEY_INITIALIZER(word, bit);
> >       if (waitqueue_active(wq))
> >               __wake_up(wq, TASK_NORMAL, 1, &key);
> > }
> >
> > which is in turn converted to (looking into your other patch):
> >
> > {
> >       wait_queue_head_t *wq = bit_waitqueue(word, bit);
> >       struct wait_bit_key key = __WAIT_BIT_KEY_INITIALIZER(word, bit);
> >       if (waitqueue_active(wq))
> >               {
> >                      unsigned long flags;
> >                      spin_lock_irqsave(&qw->lock, flags);
> >                      __wake_up_common(wq, TASK_NORMAL, 1, 0, &key);
> >                      spin_unlock_irqrestore(&wq->lock, flags);
> >               }
> > }
> >
> > And you know what? This is likely not the end yet! It's possible
> > spin_lock_irqXXX, __wake_up_common, waitqueue_active or bit_waitqueue
> > are inlines - I didn't check.
> > --
> > vda
> 
> Yes, that's 0.2% code size increase

...In just 17 callsites in entire kernel.

> (or none increase, if drop  
> inline-__wake_up_bit.patch and apply only the other patches).

Now this is a better approach - to actually see how many
callsites are there, and inlining only where makes sense.
But in practice it's hard to do and also is changing all the time
during development. What is optimal today won't be optimal in
2.6.45 :)

Ingo's suggestion to talk to gcc people to remedy
insane call convention sounds as a more workable solution.

BTW, i386 uses regparm call convention, is similar trick
possible for sparc64?

> To me it  
> seems crazy, how this code was refactored again and again over time, up to 
> 8 levels of functions (including passing a pointer to a method). In 2.0.x 
> kernel series, it was just a single call to wake up a queue.

Yes, probably... If you can simplify it, everyone will be glad.
--
vda
