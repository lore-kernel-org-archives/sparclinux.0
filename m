From: Jason Wever <weeve@gentoo.org>
Date: Tue, 16 Mar 2004 21:57:56 +0000
Subject: Re: missing define for SNDRV_DMA_TYPE_PCI in 2.6.5_rc1
Message-Id: <Pine.LNX.4.58.0403161453550.7544@stargazer.weeve.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.58.0403161427310.7544@stargazer.weeve.org>
In-Reply-To: <Pine.LNX.4.58.0403161427310.7544@stargazer.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 16 Mar 2004, Jason Wever wrote:

> --[PinePGP]--------------------------------------------------[begin]--
> Looking around in 2.6.5_rc1, it looks like the driver for cs4231 had some
> work.  Among the changes for the driver, two new macros,
> SNDRV_DMA_TYPE_PCI and SNDRV_DMA_TYPE_SBUS, were added.
> SNDRV_DMA_TYPE_PCI however, is not defined in include/sound/memalloc.h,
> where SNDRV_DMA_TYPE_SBUS is. In 2.6.4 SNDRV_DMA_TYPE_PCI was defined as
> buffer type 3, but in 2.6.5_rc1 3 is now SNDRV_DMA_TYPE_DEV_SG.

So I just realized that SNDRV_DMA_TYPE_PCI and SNDRV_DMA_TYPE_SBUS aren't 
actually new to 2.6.5_rc1, however SNDRV_DMA_TYPE_PCI is missing from 
memalloc.h, so just ignore the first part of my second sentence :)

- -- 
Jason Wever
Gentoo/Sparc Co-Team Lead
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAV3hmdKvgdVioq28RAnfJAJ949heOjHzRxZb6nHreBz7Z60yHMQCgu1mU
cDeZVoopFj/9BCQD6nXdekE=K60o
-----END PGP SIGNATURE-----
