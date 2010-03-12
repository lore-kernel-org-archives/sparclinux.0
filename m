From: Sean MacLennan <smaclennan@pikatech.com>
Date: Fri, 12 Mar 2010 17:31:58 +0000
Subject: Re: [PATCH 22/27] drivers/i2c/of: don't use deprecated field in
Message-Id: <20100312123158.7ed9d9a0@lappy.seanm.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20100311181604.13103.30088.stgit@angua>
	<20100311182349.13103.39322.stgit@angua>
In-Reply-To: <20100311182349.13103.39322.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: alsa-devel@alsa-project.org, gregkh@suse.de, linux-ide@vger.kernel.org, James.Bottomley@suse.de, linux-i2c@vger.kernel.org, sparclinux@vger.kernel.org, jeremy.kerr@canonical.com, sfr@canb.auug.org.au, linux-scsi@vger.kernel.org, jgarzik@pobox.com, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, ben-linux@fluff.org, monstr@monstr.eu, linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, dwmw2@infradead.org, davem@davemloft.net

On Thu, 11 Mar 2010 11:23:49 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> .name, .match_table and .owner are duplicated in both
> of_platform_driver and device_driver, so the of_platform_driver
> copies will be removed soon.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

i2c-ibm_iic
Acked-by: Sean MacLennan <smaclennan@pikatech.com>
