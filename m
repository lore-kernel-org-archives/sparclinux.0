Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F355BA4B
	for <sparclinux@vger.kernel.org>; Sun,  8 Dec 2024 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733655861; cv=none; b=OCEttaQSjfDgmVkRrViMXxZGt11jjfE5JX//UljYHF0uSFcWeiCPUNAzWrDj4cLgIgnICFkpZ2OT766oPXWNwXH25Q1zjkanMdoK9gRDGyaA62kDYpBI/DbwD8ycfW2OPGfE3iDTUIyQBwmtNpsCNa30AIyqSeXZGi6OGQfSO2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733655861; c=relaxed/simple;
	bh=8szes4WhxJYVAHlGL6+ESDjvolj5FsPEmfkxpOockI8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=E+VTeyZ/7tq5BzNl0s5OIgIzmXW/h2Hb3ItZiEaxIQ/07zStsreNTnhLzeuFOaZOobmGMc2Ua/sOZaXhewqT3/M/7Oa2VA3RjTV5cxe4jri695P0/fs8G1CruSmqYvD6PzAEA7olO2hY4HZE1JjI0tIEtWWVzU8UQL2WcxOXUes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-43-mXI9IeoNPBGuVCQiajEE1Q-1; Sun, 08 Dec 2024 11:04:16 +0000
X-MC-Unique: mXI9IeoNPBGuVCQiajEE1Q-1
X-Mimecast-MFC-AGG-ID: mXI9IeoNPBGuVCQiajEE1Q
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 8 Dec
 2024 11:03:23 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 8 Dec 2024 11:03:23 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'liujing' <liujing@cmss.chinamobile.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "andreas@gaisler.com" <andreas@gaisler.com>
CC: "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sparc: Move va_end() before exit()
Thread-Topic: [PATCH] sparc: Move va_end() before exit()
Thread-Index: AQHbR8CT2AXjnDzB7U6Mtud49E641LLcMLug
Date: Sun, 8 Dec 2024 11:03:23 +0000
Message-ID: <b3596c1fb07e4c6bbe347e742dbb7126@AcuMS.aculab.com>
References: <20241206092346.6003-1-liujing@cmss.chinamobile.com>
In-Reply-To: <20241206092346.6003-1-liujing@cmss.chinamobile.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bvV4L67z0Vm2L3c7JFewRpD8SSObxIIz5hSVbL6fbe0_1733655855
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: liujing
> Sent: 06 December 2024 09:24
>=20
> There is a static checker warning, so move the va_end call before
> exit(1). Since the exit(1) function terminates the program, any code
> after exit(1) is unreachable thus notexecuted. Placing va_end() before
> exit() ensures that the va_list is properly cleaned up.

Aren't you just adding 'bloat' to the vdso?
(It might even be space limited?)

If you are calling exit() then there is no need to tidy up the va_list.
Much the same as there is no need to call free() or close() all fd.

I'd probably have written it as:
=09// va_end(ap);
=09exit(1);

=09David
>=20
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> ---
> V1 -> V2: Modify the commit information and title description
>=20
> diff --git a/arch/sparc/vdso/vdso2c.c b/arch/sparc/vdso/vdso2c.c
> index dc81240aab6f..372e3330850a 100644
> --- a/arch/sparc/vdso/vdso2c.c
> +++ b/arch/sparc/vdso/vdso2c.c
> @@ -90,8 +90,8 @@ static void fail(const char *format, ...)
>  =09vfprintf(stderr, format, ap);
>  =09if (outfilename)
>  =09=09unlink(outfilename);
> -=09exit(1);
>  =09va_end(ap);
> +=09exit(1);
>  }
>=20
>  /*
> --
> 2.27.0
>=20
>=20
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

