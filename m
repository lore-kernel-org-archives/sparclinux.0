From: Julian Calaby <julian.calaby@gmail.com>
Date: Fri, 30 Sep 2011 12:48:53 +0000
Subject: Re: [PATCH 3/4] sparc32,leon: Add support for KGDB when SMP and
Message-Id: <CAGRGNgX+TmTS4iqVzMAPekT9ysfovVVDk3-qhXULX6cg9vpD5Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1317381744-24862-3-git-send-email-konrad@gaisler.com>
In-Reply-To: <1317381744-24862-3-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi Konrad,

Another minor comment:

On Fri, Sep 30, 2011 at 21:24, Konrad Eisele <konrad@gaisler.com> wrote:
> diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> index a11db95..380753e 100644
> --- a/kernel/debug/gdbstub.c
> +++ b/kernel/debug/gdbstub.c
> @@ -946,7 +946,8 @@ int gdb_serial_stub(struct kgdb_state *ks)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ptr =3D remcom_out_buffer;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*ptr++ =3D 'T';
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ptr =3D pack_hex_byte(ptr, ks->signo);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ptr +=3D strlen(strcpy(ptr, "thread:"));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcpy(ptr, "thread:");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ptr +=3D strlen(ptr);

This looks like it should go in a different patch.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
