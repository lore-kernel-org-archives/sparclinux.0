From: Friedrich Oslage <bluebird@porno-bullen.de>
Date: Mon, 18 Aug 2008 18:20:00 +0000
Subject: Re: [BUG] Kernel panic on heavy disk activity with esp_scsi
Message-Id: <1219083600.26567.10.camel@lya.porno-bullen.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-Ww0hI5RtBuSoFy0152BA"
List-Id: <sparclinux.vger.kernel.org>
References: <1210367903.21472.14.camel@lya.porno-bullen.de>
In-Reply-To: <1210367903.21472.14.camel@lya.porno-bullen.de>
To: sparclinux@vger.kernel.org


--=-Ww0hI5RtBuSoFy0152BA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'm afraid I can't trigger the problem anymore...

I have been running 2.6.24 since then, now that I switched to 2.6.25.2
again it doesn't happen any more. I also tried 2.6.27-rc3 - no luck.

I don't know how, but you must have fixed it using some black magic,
thanks! ;)

Anyway, I'll keep trying and in case I every get it again I'll send you
the debug output.

Cheers,
Friedrich

Am Mittwoch, den 13.08.2008, 20:52 -0700 schrieb David Miller:
>=20
> Can you run and trigger this problem with the following debugging
> patch applied?  Just give me the first one tha triggers.
>=20
> Thanks!
>=20
> diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
> index 62a4618..41ec3e4 100644
> --- a/drivers/scsi/esp_scsi.c
> +++ b/drivers/scsi/esp_scsi.c
> @@ -1717,6 +1717,16 @@ again:
>  			       esp->host->unique_id,
>  			       (unsigned long long)esp_cur_dma_addr(ent, cmd),
>  			       esp_cur_dma_len(ent, cmd));
> +			{
> +				int i;
> +				printk("esp%d: tgt[%d] lun[%d] scsi_cmd [ ",
> +				       esp->host->unique_id, cmd->device->id,
> +				       cmd->device->lun);
> +				for (i =3D 0; i < cmd->cmd_len; i++)
> +					printk("%02x ", cmd->cmnd[i]);
> +				printk("]\n");
> +				esp_dump_cmd_log(esp);
> +			}
>  			esp_schedule_reset(esp);
>  			return 0;
>  		}
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=-Ww0hI5RtBuSoFy0152BA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkipvVAACgkQknxn9PmJ76WyBgCgmtdHW4e/ZxrYC1H628NH+1MZ
oNgAnApU2RcuUUc5RySIrn1IlG089sR1
=5Vgm
-----END PGP SIGNATURE-----

--=-Ww0hI5RtBuSoFy0152BA--

