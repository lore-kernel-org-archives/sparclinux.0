Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="sVEfynpC";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="2ytiNmKT"
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [46.30.211.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5CAEA
	for <sparclinux@vger.kernel.org>; Sun,  3 Dec 2023 11:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=rIA/VTAshu8TtbHwnRhRIY/l1QMC3eABQvOmudQt1/g=;
	b=sVEfynpC0ny4CWOUnhDfmUGjlEvTC2IpTC6ucwVB4ykc6YBFVqAMyAHTWyw8/p1+8qx9ZAA//ZNKm
	 mgk/X8n0eAe0B0ZIoy5nnqxLc4NEmqyL+JHUk77uXNSoCSMlF7OHLGQQ8meRYrhY/iC6J+9pBSJZd+
	 2A7CpJU9vAcIDsFs7+kgGtrBpHMOOzhIMWoMU9Oww06ZHJnXskd72fsv/gN5TeMxu+TygrqlsRAIkn
	 DbztQOw13qFomHk67mrQkdabk3rDZEKbwyQM+mdBV98ujJyIExD3kFZMQeEcHfcZfrlGZyKQCvAuBD
	 +eRz71mGIyOc7geZrSZ8B56Xj/zeiFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=rIA/VTAshu8TtbHwnRhRIY/l1QMC3eABQvOmudQt1/g=;
	b=2ytiNmKTQ2JnHyg1W4z5eLbB8CSVeaLDyP79SvslWWmrpyMJ/hTwcJNbwgMqXFxLxlzMnJkmt9dfh
	 3pnW7g6Bg==
X-HalOne-ID: ec77c7d3-9210-11ee-b4a7-a71ee59276a3
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay5 (Halon) with ESMTPSA
	id ec77c7d3-9210-11ee-b4a7-a71ee59276a3;
	Sun, 03 Dec 2023 19:19:49 +0000 (UTC)
Date: Sun, 3 Dec 2023 20:19:47 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 1/3] sparc: vdso: clean up build artifacts in
 arch/sparc/vdso/
Message-ID: <20231203191947.GA147536@ravnborg.org>
References: <20231203101418.1910661-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203101418.1910661-1-masahiroy@kernel.org>

Hi Masahiro.

On Sun, Dec 03, 2023 at 07:14:16PM +0900, Masahiro Yamada wrote:
> Currently, vdso-image-*.c, vdso*.so, vdso*.so.dbg are not cleaned
> because 'make clean' does not include include/config/auto.conf,
> resulting in $(vdso_img-y) being empty.
> 
> Add the build artifacts to 'targets' unconditionally.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Nice small fix/clean-ups.

This and the following two patches are:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

> ---
> 
>  arch/sparc/vdso/Makefile | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
> index d08c3a0443f3..eb52d0666ffc 100644
> --- a/arch/sparc/vdso/Makefile
> +++ b/arch/sparc/vdso/Makefile
> @@ -24,11 +24,8 @@ targets += vdso.lds $(vobjs-y)
>  
>  # Build the vDSO image C files and link them in.
>  vdso_img_objs := $(vdso_img-y:%=vdso-image-%.o)
> -vdso_img_cfiles := $(vdso_img-y:%=vdso-image-%.c)
> -vdso_img_sodbg := $(vdso_img-y:%=vdso%.so.dbg)
>  obj-y += $(vdso_img_objs)
> -targets += $(vdso_img_cfiles)
> -targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
> +targets += $(foreach x, 32 64, vdso-image-$(x).c vdso$(x).so vdso$(x).so.dbg)
>  
>  CPPFLAGS_vdso.lds += -P -C
>  
> -- 
> 2.40.1
> 
