From: Petr Mladek <pmladek@suse.com>
Date: Fri, 11 Dec 2015 12:41:59 +0000
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and make it configurable
Message-Id: <20151211124159.GB3729@pathway.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-5-git-send-email-pmladek@suse.com>
 <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri 2015-12-11 12:10:02, Geert Uytterhoeven wrote:
> On Wed, Dec 9, 2015 at 2:21 PM, Petr Mladek <pmladek@suse.com> wrote:
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -866,6 +866,28 @@ config LOG_CPU_MAX_BUF_SHIFT
> >                      13 =3D>   8 KB for each CPU
> >                      12 =3D>   4 KB for each CPU
> >
> > +config NMI_LOG_BUF_SHIFT
> > +       int "Temporary per-CPU NMI log buffer size (12 =3D> 4KB, 13 =3D=
> 8KB)"
> > +       range 10 21
> > +       default 13
> > +       depends on PRINTK && HAVE_NMI
>=20
> Symbol NMI_LOG_BUF_SHIFT does not exist if its dependencies are not met.

=C5h, the NMI buffer is enabled on arm via NEED_PRINTK_NMI.

The buffer is compiled when CONFIG_PRINTK_NMI is defined. I am going
to fix it the following way:


diff --git a/init/Kconfig b/init/Kconfig
index efcff25a112d..61cfd96a3c96 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -870,7 +870,7 @@ config NMI_LOG_BUF_SHIFT
 	int "Temporary per-CPU NMI log buffer size (12 =3D> 4KB, 13 =3D> 8KB)"
 	range 10 21
 	default 13
-	depends on PRINTK && HAVE_NMI
+	depends on PRINTK_NMI
 	help
 	  Select the size of a per-CPU buffer where NMI messages are temporary
 	  stored. They are copied to the main log buffer in a safe context


Thanks a lot for report,
Petr
