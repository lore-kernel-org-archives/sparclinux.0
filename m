From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 22 Jan 2008 14:58:21 +0000
Subject: Re: [PATCH v2] create modalias file in sysfs for bus of_platform
Message-Id: <20080123015821.f416bf29.sfr@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Wed__23_Jan_2008_01_58_21_+1100_BfTte/nrslbIWIR."
List-Id: <sparclinux.vger.kernel.org>
References: <20080122142109.GA12967@aepfle.de>
	<20080122144053.GA13019@aepfle.de>
In-Reply-To: <20080122144053.GA13019@aepfle.de>
To: Olaf Hering <olaf@aepfle.de>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org

--Signature=_Wed__23_Jan_2008_01_58_21_+1100_BfTte/nrslbIWIR.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Olaf,

Thanks for doing this.  Patches to drivers/of should also be cc'd to the
Sparc guys as they share this stuff with is, now.

Also, drivers/macintosh/macio_sysfs.c does this for itself, so that
should probably be removed.

On Tue, 22 Jan 2008 15:40:53 +0100 Olaf Hering <olaf@aepfle.de> wrote:
>
> Create /sys/bus/of_platform/devices/*/modalias file to allow autoloading
> of modules. modalias files are already present for many other bus types.
>=20
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
>=20
> ---
>  drivers/of/device.c |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -86,7 +86,20 @@ static ssize_t dev_show_devspec(struct d
>  	return sprintf(buf, "%s", ofdev->node->full_name);
>  }
> =20
> +static ssize_t dev_show_modalias(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct of_device *ofdev =3D to_of_device(dev);
> +	ssize_t len =3D 0;
> +
> +	len =3D of_device_get_modalias(ofdev, buf, PAGE_SIZE);

Should you pass (PAGE_SIZE - 1 (or 2)) here?

> +	buf[len] =3D '\n';
> +	buf[len+1] =3D 0;
> +	return len+1;
> +}
> +
>  static DEVICE_ATTR(devspec, S_IRUGO, dev_show_devspec, NULL);
> +static DEVICE_ATTR(modalias, S_IRUGO, dev_show_modalias, NULL);
> =20
>  /**
>   * of_release_dev - free an of device structure when all users of it are=
 finished.
> @@ -116,6 +129,11 @@ int of_device_register(struct of_device=20
>  		return rc;
> =20
>  	rc =3D device_create_file(&ofdev->dev, &dev_attr_devspec);
> +	if (rc) {
> +		device_unregister(&ofdev->dev);
> +		return rc;
> +	}
> +	rc =3D device_create_file(&ofdev->dev, &dev_attr_modalias);
>  	if (rc)
>  		device_unregister(&ofdev->dev);
> =20
> @@ -126,6 +144,7 @@ EXPORT_SYMBOL(of_device_register);
>  void of_device_unregister(struct of_device *ofdev)
>  {
>  	device_remove_file(&ofdev->dev, &dev_attr_devspec);
> +	device_remove_file(&ofdev->dev, &dev_attr_modalias);
>  	device_unregister(&ofdev->dev);
>  }
>  EXPORT_SYMBOL(of_device_unregister);

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__23_Jan_2008_01_58_21_+1100_BfTte/nrslbIWIR.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHlgSTTgG2atn1QN8RAipgAKCT28Cz0alYneY3sqKQtXUDy6VbuQCfcC56
2bWB17hcPVbrWsouj80uTJk=
=VNaj
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Jan_2008_01_58_21_+1100_BfTte/nrslbIWIR.--
