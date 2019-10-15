From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Oct 2019 16:40:07 +0000
Subject: Re: sparc64: hang from BUG: Bad page state, on older CPU & compiler
Message-Id: <CAHk-=wiW0xwg4ETaMovbmDug7Cf-gUrxH7FX7EnucktJF_Sj=g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <d2a51bfb-84e4-3ce7-ac48-7200b3a8d722@linux.ee>
In-Reply-To: <d2a51bfb-84e4-3ce7-ac48-7200b3a8d722@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Oct 15, 2019 at 4:48 AM Meelis Roos <mroos@linux.ee> wrote:
> 19.08.19 08:58 Linus Torvalds wrote:
> >
> > It does sound like we should just disable HAVE_FAST_GUP for sparc. And
> > yes, it's "only" an optimization, disabling it shouldn't bvreak
> > anything. get_user_pages_fast() will fall back on the regular
> > get_user_pages() logic if there is not fast-GUP.
>
> So yes, will we do this to get rid of that regression?

Ok, I'll just remove that HAVE_FAST_GUP - I was expecting it to come
through David, but I was also really hoping we'd have a guess as to
why it happens on some hardware and configurations but not others.

Weird.

             Linus
