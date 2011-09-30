From: Julian Calaby <julian.calaby@gmail.com>
Date: Fri, 30 Sep 2011 12:50:24 +0000
Subject: Re: [PATCH 0/4] sparc32,leon: Uart polling support, KGDB with SPARC32 SMP.
Message-Id: <CAGRGNgWdDdm9iuLDZGjMi7NzkwnAttEWaqUd56EeyH76xQ59yA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1317381862-24939-1-git-send-email-konrad@gaisler.com>
In-Reply-To: <1317381862-24939-1-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi Konrad,

On Fri, Sep 30, 2011 at 21:24, Konrad Eisele <konrad@gaisler.com> wrote:
> I have some patches that are used by SPARC_LEON to connect to
> KGDB.
> 0001-apbuart-add-polling-callbacks-to-apbuart-driver.patch adds polling f=
unctions
> =A0to apbuart.c
> 0002-apbuart-add-support-for-virtual-KGDB-GRMON-channel.patch is a bit sp=
ecial: when
> =A0the user doesnt have a hardware serial device he can use the debug mon=
itor GRMON
> =A0as a tunnel. GRMON will poll a memory region to put/get characters.
> 0003-sparc32-leon-Add-support-for-KGDB-when-SMP-and-SPARC.patch this adds=
 KGDB when
> =A0SMP is enabled. Inplemented only for SPARC_LEON, on other SPARC32 plat=
forms KGDB
> =A0wont still be enabled.

Stupid question: is there a fourth patch? The subject line implies
there might be.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
