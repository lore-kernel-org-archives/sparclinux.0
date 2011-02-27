From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 27 Feb 2011 13:12:19 +0000
Subject: Re: [PATCH] sparc64: fix unused-but-set-variable warnings
Message-Id: <20110227131219.GA26699@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110226085151.GA23117@merkur.ravnborg.org>
In-Reply-To: <20110226085151.GA23117@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Feb 26, 2011 at 11:41:12PM -0800, David Miller wrote:
> 
> Here is the patch I will push upstream, it passes sparc64_defconfig,
> sparc64_defconfig + CONFIG_SMP=n, allnoconfig, and allmodconfig builds.

Looks good.

> +	/* We should probably check for hypervisor errors here and
> +	 * reset the LDC channel if we get one.
> +	 */

Coding style purist would say that the comment should look like this:

> +     /*
> +	 * We should probably check for hypervisor errors here and
> +      * reset the LDC channel if we get one.
> +      */

I do this for new stuff - and as part of other changes when I do
general clean-ups. It does not warrant an independet patch.

Patch is already pushed to kernel.org - so I do not expect any update.

	Sam
