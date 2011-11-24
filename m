From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 24 Nov 2011 18:50:10 +0000
Subject: Re: [PATCH] i2c-ali1535: enable SPARC support
Message-Id: <20111124195010.61f7770b@endymion.delvare>
List-Id: <sparclinux.vger.kernel.org>
References: <4ECE2410.7040608@geomatys.fr>
In-Reply-To: <4ECE2410.7040608@geomatys.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "corentin.labbe" <corentin.labbe@geomatys.fr>
Cc: sparclinux@vger.kernel.org, linux-i2c@vger.kernel.org

Hi Corentin,

On Thu, 24 Nov 2011 12:01:36 +0100, corentin.labbe wrote:
> Hello
> 
> The i2c-ali1535 driver don't work on SPARC, this is because it assumes that ioport address are 16bits wide (address stored with an unsigned short).
> But on SPARC arch, ioports are mapped in memory and so are stored with an unsigned long.
> 
> This patch corrects this by using pci_resource_start for getting IOMEM base address, then reading the SMBBA of the i2c busse and using together for I/O access.
> 
> I like to thanks Jean DELVARE for reviewing of my patch.

Apparently I wasn't good enough, see below :(

> 
> Thanks
> 
> Signed-off-by: LABBE Corentin <corentin.labbe@geomatys.fr>
> 
> ---
> --- drivers/i2c/busses/i2c-ali1535.c.orig	2011-06-15 18:02:56.000000000 +0200
> +++ drivers/i2c/busses/i2c-ali1535.c	2011-11-24 12:00:05.000000000 +0100
> @@ -132,7 +132,8 @@
>  #define	ALI1535_SMBIO_EN	0x04	/* SMB I/O Space enable		*/
> 
>  static struct pci_driver ali1535_driver;
> -static unsigned short ali1535_smba;
> +static unsigned long ali1535_smba;
> +static unsigned short ali1535_offset;
> 
>  /* Detect whether a ALI1535 can be found, and initialize it, where necessary.
>     Note the differences between kernels with the old PCI BIOS interface and
> @@ -149,15 +150,28 @@ static int __devinit ali1535_setup(struc
>  		- We can use the addresses
>  	*/
> 
> +	retval = pci_enable_device(dev);
> +	if (retval) {
> +		dev_err(&dev->dev, "ALI1535_smb can't enable device\n");
> +		goto exit;
> +	}

This overrides the initialization of retval to -ENODEV, which other
error paths below were relying on. I'm sorry for asking you to return
the error value from pci_enable_device(), I did not realize it would
have this side effect.

OTOH I am just seeing that the call to acpi_check_region() already
broke this months ago... So it needs to be fixed anyway.

> +
>  	/* Determine the address of the SMBus area */
> -	pci_read_config_word(dev, SMBBA, &ali1535_smba);
> -	ali1535_smba &= (0xffff & ~(ALI1535_SMB_IOSIZE - 1));
> -	if (ali1535_smba = 0) {
> +	pci_read_config_word(dev, SMBBA, &ali1535_offset);
> +	dev_info(&dev->dev, "ALI1535_smb is at offset 0x%04x\n", ali1535_offset);

Was it really meant as dev_info, not dev_dbg?

> +	ali1535_offset &= (0xffff & ~(ALI1535_SMB_IOSIZE - 1));
> +	if (ali1535_offset = 0) {
>  		dev_warn(&dev->dev,
>  			"ALI1535_smb region uninitialized - upgrade BIOS?\n");
>  		goto exit;
>  	}
> 
> +	if ((pci_resource_flags(dev, 0) & IORESOURCE_IO) = 0) {
> +		dev_err(&dev->dev, "ALI1535_smb bar 0 is not IORESOURCE_IO\n");
> +		goto exit;
> +	}
> +	ali1535_smba = pci_resource_start(dev, 0) + ali1535_offset;
> +	
>  	retval = acpi_check_region(ali1535_smba, ALI1535_SMB_IOSIZE,
>  				   ali1535_driver.name);
>  	if (retval)
> @@ -165,7 +179,7 @@ static int __devinit ali1535_setup(struc
> 
>  	if (!request_region(ali1535_smba, ALI1535_SMB_IOSIZE,
>  			    ali1535_driver.name)) {
> -		dev_err(&dev->dev, "ALI1535_smb region 0x%x already in use!\n",
> +		dev_err(&dev->dev, "ALI1535_smb region 0x%lx already in use!\n",
>  			ali1535_smba);
>  		goto exit;
>  	}
> @@ -196,7 +210,7 @@ static int __devinit ali1535_setup(struc
>  	*/
>  	pci_read_config_byte(dev, SMBREV, &temp);
>  	dev_dbg(&dev->dev, "SMBREV = 0x%X\n", temp);
> -	dev_dbg(&dev->dev, "ALI1535_smba = 0x%X\n", ali1535_smba);
> +	dev_dbg(&dev->dev, "ALI1535_smba = 0x%lx\n", ali1535_smba);
> 
>  	retval = 0;
>  exit:
> @@ -499,7 +513,7 @@ static int __devinit ali1535_probe(struc
>  	ali1535_adapter.dev.parent = &dev->dev;
> 
>  	snprintf(ali1535_adapter.name, sizeof(ali1535_adapter.name),
> -		"SMBus ALI1535 adapter at %04x", ali1535_smba);
> +		"SMBus ALI1535 adapter at %04x", ali1535_offset);
>  	return i2c_add_adapter(&ali1535_adapter);
>  }
> 

Other than this, the code looks OK. I'll fix the retval issue and
adjust your patch accordingly.

-- 
Jean Delvare
