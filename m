From: David Miller <davem@davemloft.net>
Date: Wed, 11 Dec 2013 21:59:27 +0000
Subject: Re: [PATCH 10/10] tilo: allocate kernel memory dynamically on sun4u
Message-Id: <20131211.165927.2191170874527669463.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1386458819-6590-11-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1386458819-6590-11-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 8 Dec 2013 14:31:23 +0200

> Hi,
> 
> On Sun, Dec 08, 2013 at 01:26:59AM +0200, Aaro Koskinen wrote:
>> Allocate memory for kernel image dynamically on sun4u. This allows to
>> boot bigger modern day kernels.
>> 
>> External root image is not yet supported, but this can be workarounded
>> by embedding the rootfs into the kernel with CONFIG_INITRAMFS_SOURCE.
> 
> It seems it's possible to pass the ramdisk straight from TILO image with:
> 
> 	image_table[kernel_number].root_start = (unsigned)orig_code +
> 		image_table[ROOT_IMAGE].packed_start + 0x400000;
> 
> There are also some other minor issues in the patches, I'll post an
> updated series maybe after next week.

Your changes otherwise look fine to me, I especially appreciate the
portability fixes (HOSTCC, endianness, etc.)

Thanks.
