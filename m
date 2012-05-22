From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 22 May 2012 23:19:06 +0000
Subject: Re: [PATCH 1/5] sparc32: whitespace cleanup in head_32.S
Message-Id: <CAGRGNgXmtY9u59iYdJxw3vXLEgzt-5ffVAbc9PtFfzaMjt+__A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1337717443-11904-1-git-send-email-sam@ravnborg.org>
In-Reply-To: <1337717443-11904-1-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi Sam,

On Wed, May 23, 2012 at 6:10 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> =A0arch/sparc/kernel/head_32.S | =A0 24 ++++++++++++------------
> =A01 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
> index a0f5c20..4710aaf 100644
> --- a/arch/sparc/kernel/head_32.S
> +++ b/arch/sparc/kernel/head_32.S
> @@ -659,7 +659,7 @@ sun4u_5:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.asciz "write"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.align =A04
> =A0sun4u_6:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .asciz =A0"\n\rOn sun4u you have to use Ult=
raLinux (64bit) kernel\n\rand not a 32bit sun4[cdem] version\n\r\n\r"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .asciz =A0"\n\rOn sun4u you have to use Ult=
raLinux (64bit) kernel\n\rand not a 32bit sun4[cdem] version\n\r\n\r"

We should probably drop the 'c' from this message.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
