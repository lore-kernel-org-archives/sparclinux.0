Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36FE73463;
	Tue, 25 Jun 2024 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300029; cv=none; b=AT0aSA4OwyHWEaL4+4nZmAem5M0qufvNEt18KF7BUZa0B457+YOokctsmKaSByy+vrLIcA9Pws8WYOdCbg4sIB5426coOhlWhCqoYyudRdXtCNLBvJo7lYqhjCDd31wmoSb0QjefjfDv7PPCNuV6jH4L8mk6fRHfB4Mg6D34n4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300029; c=relaxed/simple;
	bh=Tozkm9wtFnnT9G4JCNr0lovUdYwf0yT3Ep2RxifKdZQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DA6S6Jz8v55cSXpgD/XykztZ6xNC9y1DQY+8+5JhM3pjCUBw4SpZPrIjQ4QY6ioY/uIXTAtdsJ52rIz8ZEUDrlPROAs8nw2gJ2KzHH7JfLLOCH/F2SAT8yXeZfJKBMxD15xoUwVoktLyY+piv5ZrE1GVhKxIvlqE3m7/+/xTJ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=W1Sbe4+p; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="W1Sbe4+p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Fa8kWntRwF1lrvqp0Rvt4vbr7SvGesSexMl/o2xfm1U=; t=1719300025; x=1719904825; 
	b=W1Sbe4+p1nOTW9a/sl4OuEabim6oYnpvNDQfCTjGKTLYf+idFFOee+vDwDqNlpY216c36pjLJHc
	Pkp2indPxng3dT2HRXeSdoAMBieeeQRQzaPLGB3j/ZhLW9Px+pwieEcMlMnahcbBoQ9BcE6xyT9TD
	3p53iVH9uoax33vggK7R6Cxx+VzcYjlSJ0TJx6wPnwTpvEpcAL9qa2EyO0w8Q3+lz0fwX+d+/uYwR
	6Uea3xZHEIlQGz/6N/M1u8Hc44kHWnsJYL67cMKh5+CEmvtPtzT+KTWeswa+zpe2dSmKrMHuCdGWX
	RL3IgfS5y/sU8nwlEIGMuKo2JLW9VG6iNEtw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sM0TM-00000003B5S-0vEE; Tue, 25 Jun 2024 09:20:12 +0200
Received: from p5b13a475.dip0.t-ipconnect.de ([91.19.164.117] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sM0TM-00000001slu-20jW; Tue, 25 Jun 2024 09:20:12 +0200
Message-ID: <e359b140839606b1856c5625669e5b6bd7ebc7eb.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc/build: Make all compiler flags also
 clang-compatible
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Koakuma <koachan@protonmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, sparclinux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Date: Tue, 25 Jun 2024 09:20:11 +0200
In-Reply-To: <Mz-kWneLsFvKbBcTaGnC2xMA2U55fINzOJqmMRMumrtTaeHW40WfS5rYUjF_71aoXG56jSHo0vJ0oRPNoCrxpE_oIr7mmnK6fg9dFC_J9hk=@protonmail.com>
References: <20240620-sparc-cflags-v1-1-bba7d0ff7d42@protonmail.com>
	 <9449319ebbcd59719614ee786f1abe18256d0331.camel@physik.fu-berlin.de>
	 <Mz-kWneLsFvKbBcTaGnC2xMA2U55fINzOJqmMRMumrtTaeHW40WfS5rYUjF_71aoXG56jSHo0vJ0oRPNoCrxpE_oIr7mmnK6fg9dFC_J9hk=@protonmail.com>
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

Hi Koakuma,

thanks for doing the research work!

On Tue, 2024-06-25 at 02:06 +0000, Koakuma wrote:
> John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:
> > V8plus does not use VIS instructions and also has a different ELF machi=
ne
> > type, namely EM_SPARC32PLUS instead of EM_SPARCV9 if I understand corre=
ctly.
> >=20
> > So, we should make sure that the above change will not affect the ELF m=
achine
> > type.
>=20
> When assembling with GNU as, there seem to be no control as to what
> machine type we want to emit, as it simply tries to autodetect it based
> on the instruction mix in the assembly code:
> - If there's a V9 instruction inside, then use EM_SPARC32PLUS; and
> - Emit EM_SPARC otherwise.

Interesting. I actually expected some flags being passed to the linker to
enable the EM_SPARC32PLUS machine type.

> This is also the case with GCC - it simply happens that GCC will try
> to emit V9 instructions whenever possible with `-m32 -mv8plus`
> or `-m32 -mcpu=3Dv9` so there's a high chance that the resulting object
> file will be of a EM_SPARC32PLUS type, but this does not seem to be
> a guaranteed behavior.

Would be interesting to find out what Sun's own C/C++ compiler (Sun Studio)
does in this case. I can try to run some tests on Solaris or you can check
out the Solaris machines in the GCC compile farm [1].

> With LLVM's as, we can have finer control of emitted machine type, but
> so far it never sets the type to EM_SPARC32PLUS - for this I have made
> a patch over at https://github.com/llvm/llvm-project/pull/96583.

I just had a brief look - will do the proper review later - and I think
it's the right approach for the time being. However, I am wondering whether
we should add "-mv8plus" to clang as well.

I wondering though whether "-mcpu=3Dv9 -m32" is truly identical to "-mv8plu=
s"
or not.

> As for VIS, GCC (and clang when it eventually supports vectorization)
> should not emit it unless explicitly asked, so I think we are
> in the clear here?
>=20
> > With `-mvis`, GCC generates code that takes advantage of
> > the UltraSPARC Visual Instruction Set extensions.
> > The default is `-mno-vis`.
>=20
> From https://gcc.gnu.org/onlinedocs/gcc/SPARC-Options.html#index-mvis

OK, very good to know. Yes, I think we should be safe here.

Again, thanks a lot for getting this sorted out so quickly!

Adrian

> [1] https://gcc.gnu.org/wiki/CompileFarm

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
