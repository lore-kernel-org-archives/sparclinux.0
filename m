Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795548256;
	b=eIEE9ukonGXnD7Nmvrclp+xtuykAWpMx3/eCyNZZb0MNrskcbmy6cF3rqL/miWZkeNh9
	 IuFOq5G6ijBXOlbce+fJIj5TxRcCc3i/MB1o7qIQg1zC/bp7DjQYggJs4+2/0Gqcjtv/g
	 Fn4/tO1SbVaIXQa5uaPxyJCZ0K2f9fUI+P3wEw7aUBfsPDF0gmo2CWqX5y5dxalRdSFfA
	 2l6j8VZl11pEVuFYplpaqEkL5bhsYhgGBpYXlgnrBs/PMlKBlfc8gJWxCQevbLJiZKU7m
	 0snax0sbR47LwiIsZQAJqN0AkYd3lGYQE7qQ13LWHasOJbpaPPVa1SxqP1O859b58Cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795548256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=NSZBSccsPMnu9J6uIz8xAFUlyfwWf0uUXT5bABYKMkc=;
	b=IAtEPNjHfF7tyJJDgyWWoLV9SqNOXFxqxnY2JgDoZgrf5IWbq/A7bxh4PHin8FxFByP1
	 e9iSyxMAbmFG7Mx4SY9RNMiD35okDRZwe1XFsgyWGOLe6j+zR/196QVp3iEmYfBdCk6D0
	 ptYigZ1lc7Igu6ry+ZUwy6f6oE8HjmnTgWDuPkwrvkxac6A0V/AJ5Kq8Zo0bmpTARXDK4
	 Ayi7rJzejVPv/EE2CDp9MEyz+QmpVPOGXmp2sFxa/EcDMVYIvyinE5EDiE27nAlSkwpw0
	 Q/EJ5mOqRlDJVRMmV1EEoDmrMthyZOSLSnF4DLdBDpqngE6WVSHrTsrOlW38K3O3Q7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dOTPGtHu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D0606A31E
	for <sparclinux@vger.kernel.org>; Tue, 24 Nov 2026 19:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 662D0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dOTPGtHu
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b4f4095a7aso42181937b3.0
        for <sparclinux@vger.kernel.org>; Tue, 24 Nov 2026 11:24:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795548255; cv=none;
        d=google.com; s=arc-20260327;
        b=DT75nc20cOJmL942jaSyrBD6g3erZxkcG+7YHcuOUOGL/81FVspIfFNdblm7rV4DAm
         1ebuSmTnr/nswLcTN3XBm9jORoy+JuJNyqqbcvRmjmrBS5d008vu9kr9y+m0BuuDQY7J
         ajDarATWC2DQdu4yg/mMqp7yea7DohnpM6Et9nA224OibKoj60prnQMYTX8bPSPDVROZ
         TQqmT12V7NugxeNYmEJfwljKyilsG5b72SUzHkQu5bI1DxbgZjayY81aldH/GTO+8kcu
         vELTqk7n2Z+43HCUH55/7sI1mTY6tQ3Vt5PSDjxtzecUKVdhRUtlXnxnhUCinV3HdNzH
         jqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NSZBSccsPMnu9J6uIz8xAFUlyfwWf0uUXT5bABYKMkc=;
        fh=zPGdxCgLiRXAb3JxHBUw5wdC5w7weQWMrgOcleT1AHU=;
        b=Ku+RIIwIwQsV2k22B0dysiGG0Er09DL3puSUKxaBnm5dCvqykfWoqcorq+Jza/T99W
         wQ3OaY+qr5D0S5CJLXXiJeSxEDEDPKwSO12HzreCzSWUvKEXdc9otabcCsAxQ/lb8h40
         ncCF/NQSFFmW9FmhMWPkg92DGGpil7un3yRUSK+aC3iZ051K7kLLQTxu7Y5rQF7OdTbZ
         PWmKqvmbOKe+tYEA2l3ndeDvEHUtF4CJ8Wv/aiy2KPrFtQbVO8m/fCmpodv2w45fAXQM
         9MzWyC+p2JCKo7z6fnt71pMIiTYirOBCIYESVL6YI9hCKYLQRpqafP8EwUkBbhhS9Gxw
         mQRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795548255; x=1796153055; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NSZBSccsPMnu9J6uIz8xAFUlyfwWf0uUXT5bABYKMkc=;
        b=dOTPGtHuH/4Pf3+3Bcc89O6JIYXruB0ecyfTuJRTogPHYi5ZPoL96CsuJJb0qNCGXx
         jU9jDP+MxvL5pY67NLk9dD1y/hNxHLRWHzAYuctIoCHOgoJKVaRu/ofdeY/7GvxuJDqY
         +oyg/21oxnbiJ6ni56SG/bYEcQCSNcworu051padEEcpbMlKcM/oe8ICgxv4ew1kGDsN
         sjyWdH6z44vAYLXKDkyenipBud8H9GodOVz1lAfo1v4FAzMWpO/mGpaXknpy3VQsqFth
         svcTvTZzUimtBF/nCKWxilOZXIUAIBV4QdWWpfj/dy3yI67kDNjHRY3OZmRC1bYSMOUJ
         9sNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795548255; x=1796153055;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NSZBSccsPMnu9J6uIz8xAFUlyfwWf0uUXT5bABYKMkc=;
        b=SEjpZ2E+2GRCPfaQwRXvUZurqLE143x9CbV9RUhmDZwUechBC5PC9gUyn/Yoff0TWp
         Xg3yQkQgv/0+SI3XDu3wQon82oNVJ0J+AP+1Bm4pRaoXs3aRRkpyb3AhJqeB0vqOVo1I
         J8Yp76Y+Trehg9Y7PCl9yO6CJ4Ybv/o4V4xm98fCSz1Doy4SKjOERtGznegmxSc7VlXF
         5oUYD5Kpky/jBvNFJFY8dbwjkw2GVBqlcSyYgkuKMUV28/vgruNDIxHgd3HZZDJZdG2h
         sBUVPWckkPbSvsWrUO76FOmUBGRE/waRYJbIx0TWyNRSigONShFkBB57ZEfCNzUGYxx4
         cOdg==
X-Forwarded-Encrypted: i=1; AL+hErGy4wuPFRN2xUuhZgPOuFrLmsYZF6tzWabm2CgWHcgmBARjFL+vGN/FIpZsWnL5mynrW6jLT7PhWDxd@vger.kernel.org
X-Gm-Message-State: APuU4Z8Goite7mSTn9yvNzbzzPcoVKEHovtOqfL/06a0roTxZRl0ZBCP
	JD3YXOqNH2zo5wzvs4bgRZOPygLs16/A8k6qfU7QPK8K3olJGct/Q0SY5Rl7fONUd2YuTU9yHTo
	PDVY/mhlzEoPYfiSmO211NQjrkx1bFLs=
X-Gm-Gg: AZFdTZdaiXu6owFcjqtuXV2NgJLR93wb7Ur+NKPloh5DZ5ewG6/uJECjVsIvmY9S41t
	23eFlcFkzTLOXPQ0raPdNPqUVAbH6UnCRi/PWjB1pRcKnGKGV8IND1/2I/R4JmZBVOQOR07B7ie
	rnMmy/G4WSKpNSo3dxKlQdrfr9RGSCPuFgUQ+0bhiRQFi+5ZG3S9EFWcmTPIdHIjl8/B18RIOEO
	ELZen/BcYVZw4Hj5Telnq/sT+oK2qJdtyjobM+kCkDKLb6zF9ZwHJnVUA4mmS3458HpMcUwTU/W
	XO6OeaZEJlX/5/D2DRbaeBVZAi2cBQyT43s7N9R45zpNnBXaAimz04UipPmDtbxGJYm5Ew+Wbn3
	qXbeReg5kwoKw1TJJUjfmNkbBxUljIvUt42UwvY/rubnygSnQG3/L8mZ1TsZD+R7UC01sW0SUlu
	SPZIbb0ffJVwXY5umlcnBR8czNBzVYTSI0JtSOH+5ZPSlfh3dELJqy533ixMDEajIMketMQ0Iyd
	HuIIZ2RkjuPjP9b2MP7yOkTizHKqcszTd+isBAfs+6B8PxuN6Hz2Rdu+YSnJrCLUv+xZ4Xf1V42
	wpXi+rGd37XHUxW86r//v/c3GdNyX503g0/BNHWYAhAx18G5k9TH2vpZZKI96Z+5Yver
X-Received: by 2002:a05:690c:a40f:20b0:8b5:635b:4ec7 with SMTP id
 00721157ae682-8b5635b4f9amr11045027b3.44.1795548255313; Tue, 24 Nov 2026
 11:24:15 -0800 (PST)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <14af96f20e7b24734c45f6f71b1800b6ce46b888.camel@physik.fu-berlin.de>
 <d7695125c69b38407ab4a11f67b25bf2eb8f8b80.camel@physik.fu-berlin.de>
In-Reply-To: <d7695125c69b38407ab4a11f67b25bf2eb8f8b80.camel@physik.fu-berlin.de>
From: Kjetil Oftedal <oftedal@gmail.com>
Date: Tue, 24 Nov 2026 20:25:31 +0100
X-Gm-Features: Aa3M54qq6raeg3n7NJhwUlyr_wylSKfX6HaDC9bqFwjVrks0LcXl3D1r4jaeoCM
Message-ID: <CALMQjD9JtaF0V+eVanujrjBiR17V6tSGhUK1+cj9J1JmLPhfHw@mail.gmail.com>
Subject: Re: Need help replacing one of Debian's SPARC T4-1
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>, sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Just looking at the error. Might it be that you need a new powersupply
instead of a motherboard?

Best regards,
Kjetil Oftedal

On Tue, 24 Nov 2026 at 16:42, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi,
>
> On Tue, 2026-11-24 at 15:57 +0100, John Paul Adrian Glaubitz wrote:
> > the motherboard of one of Debian's SPARC T4-1 servers just failed:
> >
> > -> show /System/Open_Problems
> >
> > Open Problems (1)
> > Date/Time                 Subsystems          Component
> > ------------------------  ------------------  ------------
> > Tue Nov 24 13:48:08 2026  System              MB (Motherboard)
> >         A chassis voltage supply is operating outside of the allowable range. (Probability:100, UUID:xxxx, Resource:/SYS/MB, Part Number:7063388, Serial Number:XXxX,
> >         Reference Document:http://support.oracle.com/msg/SPT-8000-DH)
> >
> > ->
> >
> > I'm looking for a solution to either replace the mainboard or the
> > whole machine now. If anyone is interested in supporting me in this
> > effort, please let me know. The easiest way would be to just replaced
> > the faulted board or server with an identical model.
>
> OK, since I was able to backup the LDOM configuration from ILOM and also
> have the latest firmware available, I will just have to look for a replacment
> SPARC T4-1 to get the machine back up.
>
> Adrian
>
> --
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
>
