From: Julian Calaby <julian.calaby@gmail.com>
Date: Fri, 30 Dec 2011 12:44:28 +0000
Subject: Re: [PATCH] sparc32: remove unused file: include/asm/pgtsun4.h
Message-Id: <CAGRGNgWtx4d9Opt+RFG9cb-xGj0Eg7KwbmrgdjKugdwgfgvWew@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20111230123521.GA4478@merkur.ravnborg.org>
In-Reply-To: <20111230123521.GA4478@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Sam,

I understand if this isn't used at all, but this seems to be Sun4C
stuff, so why isn't it used - are these defines defined elsewhere?
(I'd look myself, but I'm not at home)

Thanks,

Julian Calaby

On Fri, Dec 30, 2011 at 23:35, Sam Ravnborg <sam@ravnborg.org> wrote:
> From d1b5b3bdc351b423e2e9ca24ded8cbabf61e4474 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Fri, 30 Dec 2011 13:32:16 +0100
> Subject: [PATCH] sparc32: remove unused file: include/asm/pgtsun4.h
>
> sun4 is no longer supported and this file is unused.
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> =A0arch/sparc/include/asm/pgtsun4.h | =A0171 ----------------------------=
----------
> =A01 files changed, 0 insertions(+), 171 deletions(-)
> =A0delete mode 100644 arch/sparc/include/asm/pgtsun4.h

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
