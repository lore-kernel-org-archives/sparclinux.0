From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 12 May 2013 15:28:29 +0000
Subject: Re: [PATCH] arch: sparc: kernel: use devm_ioremap_resource()
Message-Id: <20130512152829.GA17866@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1368367807-1263-1-git-send-email-laurent.navet@gmail.com>
In-Reply-To: <1368367807-1263-1-git-send-email-laurent.navet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Navet <laurent.navet@gmail.com>
Cc: davem@davemloft.net, daniel@gaisler.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, May 12, 2013 at 04:10:07PM +0200, Laurent Navet wrote:
> Replace a call to deprecated devm_request_and_ioremap by devm_ioremap_resource.
> 
> Found with coccicheck and this semantic patch:
>  scripts/coccinelle/api/devm_request_and_ioremap.cocci.
> 
> Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
> ---
>  arch/sparc/kernel/leon_pci_grpci1.c |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/sparc/kernel/leon_pci_grpci1.c b/arch/sparc/kernel/leon_pci_grpci1.c
> index 7739a54..6df26e3 100644
> --- a/arch/sparc/kernel/leon_pci_grpci1.c
> +++ b/arch/sparc/kernel/leon_pci_grpci1.c
> @@ -536,11 +536,9 @@ static int grpci1_of_probe(struct platform_device *ofdev)
>  
>  	/* find device register base address */
>  	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
> -	regs = devm_request_and_ioremap(&ofdev->dev, res);
> -	if (!regs) {
> -		dev_err(&ofdev->dev, "io-regs mapping failed\n");
> -		return -EADDRNOTAVAIL;
> -	}
> +	regs = devm_ioremap_resource(&ofdev->dev, res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);

This looks bogus. The function return an int - not a pointer.

	Sam
