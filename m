Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A692B2CC;
	Sat, 22 Jun 2024 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719041356; cv=none; b=VxsobAEn5opYn97EqIbMgBOsYPcXDJmfn/8D09ZyiFoBVKQ5/HGvGtYY3EE10RBNuDPXL9sTa5jxkl9q+pKEPOZaf8NGbIrvqWHi+t0f3aFG0mG0jd9y6Ozbj3n2Aa6R8NHZG4L8/XBUvIoHmo/f+ltZFeEe4vMoiaXXSti2XfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719041356; c=relaxed/simple;
	bh=iqLulf/rD1NvA0LE8LuLF/+Z2k5eg20+82y5x+UFl6g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rTCJC6T4aeDeIpfxuellw96M5esnPX8UHbdV48dtmq9AtthqdU3EoWuF9rejdx5+Ak6e3K2PDlch9nmI19B+2O2Z+nzeA6qLXwtWnGt8eznv/04vktABLXx+GoxO7mjhmixD4HDHCbzd324LdBofe3EyEqPUqjvS+06Uei0PsgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=RcfV2RhY; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="RcfV2RhY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4BlOodcHBQPbIPkH5yQr6ccoGViUa7yXt3bhkI+0hmk=; t=1719041353; x=1719646153; 
	b=RcfV2RhYqBRjPoR6zBqFAcJYJ5yCEXPLXOaR7p88+A3wafqUOIQzQcC2GuX9EWeVLm1rrBvsfIr
	zZ0Zvdqma8o4CI6iCVjvdEPanVa+YdPyVnKRMDtN0peH0S1IVZy/Bg2nEnA5J7hu67XN4B5LY4wqB
	m52ODWajfSSNlNIVMDGWkO5oXcFPeopB3yJ0mKW7Bhw8nidofYaGHG/H5sHM1abHNcSmUE1njGvcg
	VsQYcOCpB4CCeV9SkG71jjFxbBx2hOlayM2cONpg+EIFVf6ekW/v5jgJ4caMxp7/we90/yc0F5wrM
	hmTU8zM+VtYFl2KGWUqcQAeHJVfmJHw+d2rw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sKvBK-000000044kH-1Bvk; Sat, 22 Jun 2024 09:29:06 +0200
Received: from p5b13a475.dip0.t-ipconnect.de ([91.19.164.117] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sKvBK-00000000bCd-2ErI; Sat, 22 Jun 2024 09:29:06 +0200
Message-ID: <ee12bbe782e44a96f4894dfd9ab0550233014c19.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc/build: Make all compiler flags also
 clang-compatible
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Nathan Chancellor <nathan@kernel.org>, koachan@protonmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 sparclinux@vger.kernel.org,  linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Date: Sat, 22 Jun 2024 09:29:05 +0200
In-Reply-To: <20240621185345.GA416370@thelio-3990X>
References: <20240620-sparc-cflags-v1-1-bba7d0ff7d42@protonmail.com>
	 <20240621185345.GA416370@thelio-3990X>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Nathan,

On Fri, 2024-06-21 at 11:53 -0700, Nathan Chancellor wrote:
> I think a good amount of the reasoning below the '---' could probably
> make it into the commit message as well but I don't have much of a
> vision there, maybe one of the SPARC folks will.
>=20
> I saw through the LLVM issue above that one other patch is necessary to
> fix an issue in the vDSO [1], which I applied in testing this one. I
> noticed in applying that change that you appear to be working on 6.1,
> which is fine for now, but you'll need another diff once you get to a
> newer version, as we stopped using CROSS_COMPILE to set clang's
> '--target=3D' value:
>=20
> diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> index 6c23c6af797f..2435efae67f5 100644
> --- a/scripts/Makefile.clang
> +++ b/scripts/Makefile.clang
> @@ -10,6 +10,7 @@ CLANG_TARGET_FLAGS_mips		:=3D mipsel-linux-gnu
>  CLANG_TARGET_FLAGS_powerpc	:=3D powerpc64le-linux-gnu
>  CLANG_TARGET_FLAGS_riscv	:=3D riscv64-linux-gnu
>  CLANG_TARGET_FLAGS_s390		:=3D s390x-linux-gnu
> +CLANG_TARGET_FLAGS_sparc	:=3D sparc64-linux-gnu
>  CLANG_TARGET_FLAGS_x86		:=3D x86_64-linux-gnu
>  CLANG_TARGET_FLAGS_um		:=3D $(CLANG_TARGET_FLAGS_$(SUBARCH))
>  CLANG_TARGET_FLAGS		:=3D $(CLANG_TARGET_FLAGS_$(SRCARCH))
>=20
> With those, I can successfully build a kernel with clang that boots in
> QEMU :)
>=20
>   $ make -skj"$(nproc)" \
>          ARCH=3Dsparc64 \
>          CC=3Dclang \
>          CROSS_COMPILE=3Dsparc64-linux-gnu- \
>          LLVM_IAS=3D0 \
>          mrproper defconfig all
>=20
>   $ qemu-system-sparc64 \
>         -serial mon:stdio \
>         -display none \
>         -no-reboot \
>         -M sun4u \
>         -cpu 'TI UltraSparc IIi' \
>         -m 512 \
>         -append console=3DttyS0 \
>         -initrd sparc64-rootfs.cpio \
>         -kernel arch/sparc/boot/image
>   ...
>   [    1.788544] Run /init as init process
>   ...
>   Linux version 6.10.0-rc4+ (nathan@thelio-3990X) (ClangBuiltLinux clang =
version 19.0.0git (https://github.com/llvm/llvm-project a083e50f53f0f9eb9ad=
0c5b65f3c627cf97043e6), GNU ld (GNU Binutils) 2.42) #1 SMP Fri Jun 21 11:36=
:18 MST 2024
>   ...

Wow, this is really great progress. Kudos to everyone who helped to make th=
is happen!

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
