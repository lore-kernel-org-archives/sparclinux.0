Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696993A382A;
	Wed, 20 May 2026 22:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779316313; cv=none; b=nYQklZugnF7GHAHvxVFKZ4Igk8EJRlwEoTN9AWjJHMx7fA1Kdy/vI0aCXYOV2+LwKs79hwPCSWGPurf6EKYQFuZchxCf/GVjmbSALR4oxE3gxRgflZzjOXDe+iwaEZWDyAqwTg1uvgnR8SwZuNGF8TKX0lRkn0lYDfwLsgHXmZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779316313; c=relaxed/simple;
	bh=lIvH1awXCFbk1sZ4NKZBZiF7OxrEZoBrN1B0zUiKi+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxMW8w7k62xSgVWfYB3hA1IAhSXnAFzAvxhXi19xPfGyA8MXu1ZPUnGDScICLnMzNkuUoI5oaSLSnePrfaJ/ouoUI/DHUwG7kyI9+C6g5f7btF8E+o1HZuqd5sA6IHWW1z1qEq6h5GZUpMrQDSgt83v9kty4INZAaTmrjk2o4wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lH6Mnhhm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lH6Mnhhm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4A81F000E9;
	Wed, 20 May 2026 22:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779316312;
	bh=uvHgn6wL9Z/hbhcuKLuD4O1BHvgOX2gS6aLnmbXxQnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lH6Mnhhm/Mh7dg9efdieGoNUdhJGuN9ZL7NZTK+DWrmITPzFH+eWWs04rOtOaGrVQ
	 YnxGUTQy26zf4gWhopbjdKQw9OWAwfRJoA+X/OVOy+dUd/2qmPg4UWdDxR1jfIkYzT
	 VUfS2PI3Xprprbyfav+1If6iLsbp2h+XWpKtVpPEHtDja5UIqLPw2SG81BE0OyhxGV
	 f5BmlqPx/kcEZ1aSbzKKQbe1xWyUPqcykKb4g+v/0J5x2PbcFC6Ow6heqTbc+Sx1BD
	 hb/UjBjr9PXa/C0BATeLvO6xAfANFPvm5nLYS7zE34+Qhbfp+Khgz/c78r50KHsjqu
	 LwCodg19ijd0g==
Date: Wed, 20 May 2026 15:31:47 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Koakuma <koachan@protonmail.com>
Cc: Rosen Penev <rosenp@gmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Christian Brauner <brauner@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:\\\\b(?i:clang|llvm)\\\\b" <llvm@lists.linux.dev>
Subject: Re: [PATCH] sparc: Avoid unsupported LLD branch relocations
Message-ID: <20260520223147.GB1607511@ax162>
References: <20260514041908.874355-1-rosenp@gmail.com>
 <f8a58a8d567149f514f2f5f47af25905f254f72f.camel@physik.fu-berlin.de>
 <CAKxU2N_p7unDCif826jpTUtzs8=-ZoKw4u-Eg1UEM+4o+5Fbzg@mail.gmail.com>
 <20260514125820.GB1781775@ax162>
 <ov9qx_G3-lAxKXO_ur8gXhE8J5toGs8NkZ2mtMBdwEVND6y0f9CakihiR1kVbaS_lgMVbYs3NegNpFgCRjzzb79wzfbm4_1WeVt1q5pe_f0=@protonmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ov9qx_G3-lAxKXO_ur8gXhE8J5toGs8NkZ2mtMBdwEVND6y0f9CakihiR1kVbaS_lgMVbYs3NegNpFgCRjzzb79wzfbm4_1WeVt1q5pe_f0=@protonmail.com>

On Wed, May 20, 2026 at 04:20:50PM +0000, Koakuma wrote:
> Yes, at the moment LLD only has very basic capabilities and still can't link
> the kernel, at least not without some rather invasive changes.
> (And even if you manage to land all the changes to the kernel, still there are
> many complex programs out there that's currently unlinkable by LLD that I feel
> like improving LLD would be a better use of resources, in the long term)

Agreed and that is generally what we tried to do for all other
architectures, I don't think SPARC is special here.

> As for the integrated assembler, now that PR 187534 [1] is merged it should
> be possible to build the kernel with IAS, but that commit hasn't made it into
> a release yet so I don't feel like it's the time to update the kernel's
> docs... maybe?
> 
> [1]: https://github.com/llvm/llvm-project/pull/187534

Yeah, we can update the documentation when 23.1.0 is out, but I should
update our CI to test sparc64_defconfig with the integrated assembler
for clang-23+ because we test from main.

-- 
Cheers,
Nathan
