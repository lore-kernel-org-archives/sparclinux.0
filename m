From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Sun, 04 Jan 2009 08:20:49 +0000
Subject: Re: [PATCH] sparc: Merge sparc_ksyms_{32,64}.c
Message-Id: <646765f40901040020wfb76dc3sd64935f1729e2729@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4960225E.1000801@gmail.com>
In-Reply-To: <4960225E.1000801@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Jan 4, 2009 at 13:43, Julian Calaby <julian.calaby@gmail.com> wrote:
> sparc: Merge sparc_ksyms_{32,64}.c
>
> Signed-off-by: Julian Calaby <julian.calaby@gmail.com>
>
> ---
>
> Sorry about the formatting of this patch, I can't seem to convince git to
> recognise that sparc_ksyms.c is modified from sparc_ksyms_64.c
>
> Sigh.
>
> Furthermore, this is a rather mechanical patch that produces a huge set of
> ifdefs - I've shuffled some of the code to reduce these, but..... - so I'm
> not going to be surprised if you ask me to re-do it.
>
> Oh, and this also changes the order of the declarations in both SPARC32 and
> SPARC64, but it shouldn't be an issue.
>
> Anyway, this has been built on SPARC64 and an equivalent patch has been boot
> tested on SPARC64.

Sigh.

There's some other cleanups I have to do before I should really do
this ... so don't apply this for now, and I'll send this, and my other
patch for today in a series in a couple of days.

Thanks for understanding =)

-- 

Julian Calaby

Email: julian.calaby@gmail.com
