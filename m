Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F25335C6B7
	for <sparclinux@vger.kernel.org>; Fri,  2 Oct 2026 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790924988; cv=pass; b=dhyZji8wix2VNKwLVS4qCln257gCnnZkRSqyXzNK9qaMZ4icqpcr9aKwZGNWKPL8UN06cILHb8soFltBm/Mw6LWVM6rIV2EIOKGrvShv9qx1YabINiZ1f4R/R/JaTIcNEcPatbvNQcDHlpI4Fyy4o6wBouNwmKiyEi/EXYd8op4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790924988; c=relaxed/simple;
	bh=xlo2pImW7PXhh5dT1LMiEzxF/rHfLQ3Xs3UsISEZJvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkjFKHpF90hOSmW7k4vmfpA5WUhC2lUJ0A9qJ83OvH6YgFL+MCXl2xkuW29HldDodsgQY6PdDeP5Eq1vgFeMP1JRppKbDg9ppLS0X45WQUB37QFlBxMioHgNypA7yfSe3Tb9llAVQGsiAsrYuIT6z2RaLwoldJ6wHmso/qapKKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nns1HV0q; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nns1HV0q"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2946aa0d5aso465751566b.0
        for <sparclinux@vger.kernel.org>; Fri, 02 Oct 2026 00:09:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790924985; cv=none;
        d=google.com; s=arc-20260327;
        b=LaPceObkkVwaOLt2ITzREDB7BTN9XYuAqZpqkEWsSY1/93JEpH0iQrHI1KhdAAh0fg
         nIcdPuDuPqhXfFtVcIHvsSloOBVDYPjv8QZ0cLP74N6Uw5ikK9gf4kX+5FpR2VCBnho/
         hd29qT4FVfwqUsteQzZDtUNpF4lTpx/XKs+robbbL28DZ6SiTnWI0/LhaJD0c8YsX2Vg
         Eie7S23ZP3TSYouFu6agpA+nFlr29wA8BjUv9lszazc/qNiC7872fQa01QvCH/BZTwBZ
         2kYYZMmk/zBU/qo7xgR7y8GxJpmrfNJcfbjWDOFjznN/0KargBIjJWKqAuLsetuXgHb4
         qqOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CfJWp8+LJiuY7rnCHyZh1b5K2L8Jp1k+28g5CGSVI9g=;
        fh=0avi9YJrFmLAnWIunBO+h+A1iHR2t1bZdVwKpTJ46F8=;
        b=YvHQOilWyIy4PLpnkFUct6YP283AKoIv5/UA99rrEVV+kLXYG874tRMZDgPxE4emIA
         vQpFQJxMOJlXtWRfUPCiXABbn3LCRCRzfkvIxF4uLsrnEg6x6wRka6YxL1Ox5gWs75yX
         OeshtCP3gf5qD4EDQ1SJxFpd0icM4AzIncC/WMIIqegvv94vzDnekoY9/6rpPqIIt8A2
         88Prm7PiuJAy48la2wZv2bmHwKwJKVpgHcXlokIolUxSPrdck28z0ZS6HVazhHvX0aNV
         DU26Wu5w9aF2LeTaDzrzCzKHWpgiVt3a+0oZo9fYpffWLqtIxtPAUm5zLIER2AFrWZe+
         aStQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790924985; x=1791529785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CfJWp8+LJiuY7rnCHyZh1b5K2L8Jp1k+28g5CGSVI9g=;
        b=nns1HV0qwcFXUnKhmOsNZbsIqEdKmlBZv+jCvnAq+Pypx3oiGHWpFDNyNT95zbgFA1
         xqZPEQANWRf8pVDKtw+ffDgJv/Z2FqzNOjnym/QfowNMzl32gTLgQlEgyIru/OGk7WWn
         HTQ/VqkFYxzfTqNYGNk5GFHSVh4zvAtEteSZGvfuQKW6qQ+X4n7k6Va7GmDuwoC3m+lq
         yk/d17uMNzl/Qkkraunh+sk7o7Cx2tQDpqRVZPWuJweE2q1B/1cqKtDZxVw461D/ECov
         0WMmfOo8vWVz9gYiIg8gckxUNZYjzitWCg0SEefB4HYUI5aTJzHwvmpyG5Qh6tUyQkSO
         UycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790924985; x=1791529785;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CfJWp8+LJiuY7rnCHyZh1b5K2L8Jp1k+28g5CGSVI9g=;
        b=Ch9VQCR35ZMsMwjKVDjT8ARfy5jspSZlsPH/eclczrJyk1UFwx8Wka5G2ePfiNayXn
         UB1xPdd8CLlZKtiJTK79sj08TyFZEs7hzAd2/RJtRvJbwXgl325dv/9qew3TD3K4QvML
         5WFksrx7w7mfauAo0cUs4ah/OjJSS4pSpG141UgvEny5S7TJ+Be4TzYK8vgvJW53LDKz
         gKTC4clP0BK8CQ37AR6ZRKu9F6YT6oe89CNc9KTkffTLR14UcU/sVxEHucEfCN16yBsj
         uork+KZHyWLqWSUL4pvXcRJ4w7APTq5ny/WjArOIm1MUYpezzPE41RbGj2slpRe6hwI/
         TQeA==
X-Forwarded-Encrypted: i=1; AKwUvBwISr/dJAykNJ6CTonC/EWiH1HcpV7XJXNG90LH/IH8JDg4F3VwqUkF3x4ceiUXfUdCnOl8XFz1T8KI@vger.kernel.org
X-Gm-Message-State: AFuF++k3Ltg3vX+BpsNZ3gUB7pXFaMtphVaHmDR9TiapzqFcfr/KPDwy
	YqlgQInPhDIldGsvFHF6Fqi54OQkRojYRhmJutWzXGULPcVV0Jkvw2zzjmoauNpzQdi6uIj5+7Q
	NSU/MPO9zMGr9VB/RlIdrNNPB/wEGV792wA==
X-Gm-Gg: AYBFou0R79LuVmMnBLzaQfkm8bpsZ6D0ktk5/g9jt+7C0gdnksRzbqgP7xU4wKnxXx1
	yBmzNHbho6Jd5pSy3T6ciFJiPXSjObC+onr8qBuYI5fx29y+PZJYX8+jALGaHEv9VGJln4VgUv2
	T29e9QENbTHVnAyqogWN4d6AkYiJ2j0mal5roOOzz/ImGPB9Ty9gmrCQmDZeIyt0mWfJT7KQHH7
	XzeASQvIu5ZJVfB13cTXzZepeJyI8ekNPuz8IAnAWIoS79eQ+0M0BGC+Z3EFnaAA78KNE6rqGzn
	JCNjUY0pVuE6VYkBDdDh9dp5NFaBJVXKs7W+looitlyvVw/5/01MutXiZi3P0t7MhSho/ur3+/f
	6Fe68xspB8s47tNpGw9065sQXDr1ZAGn5DG8S2kyKeQ==
X-Received: by 2002:a17:907:940d:b0:c25:f7dc:2dc with SMTP id
 a640c23a62f3a-c2e340a9fafmr420417966b.29.1790924985034; Fri, 02 Oct 2026
 00:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929222752.36427-1-ebiggers@kernel.org> <322e5255353e3a5f9e3840a496018edd980fb016.camel@itx.no>
 <1f85bdb9614365fedda81fb649147da48bf7be13.camel@physik.fu-berlin.de>
 <25c7a7c7bbe3c7f70fca559867e0883b9e4dc48d.camel@itx.no> <3ea57d640ac7409fa37b15ec9e3f49126347e432.camel@physik.fu-berlin.de>
 <8d3d3142d1ac323695a3ea2d5b3e2a10d2a129d6.camel@itx.no> <CA+=Fv5R0F5YNgORUx1c8YWzyFcS6wqVtmzQUXaS3vuLHYwBndw@mail.gmail.com>
 <071a1ebbd8dc9d99bfe9b4c98285f435bdb3a39f.camel@physik.fu-berlin.de>
 <CA+=Fv5SgDoLxN5-un=Q2=Q-SYCyZwHMNLEeBkjSqrc5KSS0=ww@mail.gmail.com> <e2113dd8-6e87-469a-a635-df357a869320@blastwave.org>
In-Reply-To: <e2113dd8-6e87-469a-a635-df357a869320@blastwave.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 2 Oct 2026 09:09:33 +0200
X-Gm-Features: AclHuK8PzjBzTYj0CNLkmXv3OxTM0FDJ-KTONUfuhQK26ixuXHP1qvYjd8zjcmA
Message-ID: <CA+=Fv5RqCug-f7R40k2MJGL=frXaxv9OzNwQWSB_o7XP5FryHA@mail.gmail.com>
Subject: Re: Linux on Fujitsu M3000 - was: Re: [PATCH v3] crypto: aes - Fix
 undesired override of some optimized AES modes
To: Dennis Clarke <dclarke@blastwave.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, sparclinux@vger.kernel.org, 
	"<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dennis,

On Thu, Oct 1, 2026 at 7:37=E2=80=AFPM Dennis Clarke <dclarke@blastwave.org=
> wrote:
>
>
> Sadly I tossed that machine into the trash a few months ago. Full of
> memory and SAS disks and gone out the door to the recycle centre.
>
Oooh no! Missed that by only a few months then?  But I understand,
My M3000 came close to meeting the same faith a few times, but for
some reason I've kept it in the hopes of resurrecting it again some
day.

>
> I still have a SPARC S7-2 server and a few Netra units.
>
The S7-2 is a really nice machine.

Magnus
