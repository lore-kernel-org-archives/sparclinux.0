From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 02 Jan 2011 00:49:33 +0000
Subject: Re: [PATCH v2 0/9] sparc: unify sparc/boot/piggyback
Message-Id: <AANLkTimnZzc_19EJvPJY1SH=7aVDkKRB-W_jqLM4zORy@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110101205701.GA4544@merkur.ravnborg.org>
In-Reply-To: <20110101205701.GA4544@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Jan 2, 2011 at 07:57, Sam Ravnborg <sam@ravnborg.org> wrote:
> I decided to complete the unification of piggyback.
> This was inspired by comments from Julian Calaby.

=)

> The patchset documents my findings while reverse engineering
> piggyback. And some limited refactoring also increased
> readability a lot.
> piggyback now takes an argument that tell if this is for
> sparc or sparc64 and uses this info to adjust behaviour
> as sparc and sparc64 differs in a few places.
>
> With these additions we can now use the same piggyback for
> both sparc and sparc64.

Yay!

> My testing turned out that piggyback_64 was broken on my x86 box,
> because it was hardcoded to assume a big-endian host.
> I also found a few code-spots that assuemd the host was big-endian.
> All cases are fixed to be endian neutral.
>
> Julian Calaby acknowledged that piggyback_64 had endian troubles.

Well, in as much as it'd never been fixed like _32 had.

> This is boot tested on my sparc box.
> I have only build tested the sparc64 bits!

I'll try to get my box running in the near future and give you an
update on this.

That said, I know that my old endian fixed version of piggyback_64
works, so I'll do a quick check first to ensure that your version
produces the same output.

Thanks,

-- 

Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
